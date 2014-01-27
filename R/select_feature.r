#' Select best features in x based on known y

select_feature <- function(x, y, 
                           resamp_max = 1000,
                           rf_samp_perc = 0.667,
                           rf_samp_max = 500,
                           rf_mtry_perc = 0.667,
                           rf_mtry_max = 500,
                           rf_tree = 100,
                           num_model_max = 100,
                           size_perc = seq(0.1, 0.5, 0.05),
                           num_cv = 5,
                           num_repeat = 1,
                           num_model_eval = 5,
                           verbose = TRUE) {
                           
  ## Timer
  time_start <- start_timer()
  
  ## Load Package
  suppressMessages(library("caret"))
  suppressMessages(library("randomForest"))
  suppressMessages(library("nnet"))
  suppressMessages(library("class"))
  suppressMessages(library("kernlab"))
  suppressMessages(library("gbm"))
  suppressMessages(library("survival"))
  suppressMessages(library("splines"))
  suppressMessages(library("plyr"))
  
  ## Display?
  if (verbose) {
    cat("\n")
    cat("[bib]: Calculating variable importance score ...")
  }
  
  ## Mini Function
  mini_rf <- function(x, y, resamp_max, rf_samp_perc, rf_samp_max,
                      rf_mtry_perc, rf_mtry_max, rf_tree) {
    
    ## Normalise Function (just in case it can't load from bib)
    normalise <- function(x, method = "range") {
      pp <- preProcess(x, method)
      return(predict(pp, x))
    }
    
    ## Re-sampling if needed
    if (nrow(x) > resamp_max) {
      row_sample <- as.integer(createDataPartition(y, p = resamp_max / nrow(x), list = FALSE))
    } else {
      row_sample <- as.integer(c(1:nrow(x)))
    }
    
    ## Train RF
    if (is.factor(y)) {
      num_class <- length(summary(y[row_sample]))
      samp_class <- round(min(c(min(summary(y[row_sample])) * rf_samp_perc, rf_samp_max)) / num_class)
      mtry_class <- min(c(round(ncol(x) * rf_mtry_perc), rf_mtry_max))
      model <- randomForest(x[row_sample,], y[row_sample], 
                            strata = y[row_sample],
                            mtry = mtry_class,
                            sampsize = rep(samp_class, num_class),
                            ntree = rf_tree,
                            importance = TRUE,
                            do.trace = FALSE)
    } else {
      samp_reg <- min(c(round(nrow(x[row_sample,]) * rf_samp_perc), rf_samp_max))
      mtry_reg <- min(c(round(ncol(x) * rf_mtry_perc), rf_mtry_max))
      
      model <- randomForest(x[row_sample,], y[row_sample], 
                            mtry = mtry_reg,
                            sampsize = samp_reg,
                            ntree = rf_tree,
                            importance = TRUE,
                            do.trace = FALSE)
    }
    
    return(normalise(matrix(model$importance[, 1], ncol=1)))
  }
  
  ## Run in Parallel
  num_model_total <- min(c(round(nrow(x) / resamp_max * 10), num_model_max))
  
  imp <- foreach(num_model = 1:num_model_total,
                 .combine = cbind, 
                 .multicombine = TRUE,
                 .errorhandling = "remove",
                 .packages = c("randomForest", "caret", "ff", "ffbase")) %dopar%
    mini_rf(x[,], y, resamp_max, rf_samp_perc, rf_samp_max, rf_mtry_perc, rf_mtry_max, rf_tree)
  
  ## Get Median
  imp_median <- matrix(apply(imp, 1, median), ncol = 1)
  
  ## Rank
  imp_order <- order(imp_median, decreasing = TRUE)
  
  ## Display
  if (verbose) {
    ## Display
    cat(" Duration:", stop_timer(time_start), "seconds.\n")
    cat("[bib]: Most important variables are:\n\n")
    df <- data.frame(variables = matrix(colnames(x)[imp_order], ncol = 1), importance = imp_median[imp_order,])
    print(head(df))
    cat("\n")
  }
  
  ## Empty shell for storing evaluation results
  eval_all <- data.frame(matrix(0, nrow = length(size_perc), ncol = 7))
  eval_all[, 1] <- round(size_perc * ncol(x))
  
  if (is.factor(y)) {
    colnames(eval_all) <- c("num_features", 
                            "acc_svm", 
                            "acc_knn", 
                            "acc_pcaNNet", 
                            "acc_gbm",
                            "acc_glm",
                            "acc_median")
  } else {
    colnames(eval_all) <- c("num_features", 
                            "R2_svm", 
                            "R2_knn", 
                            "R2_pcaNNet", 
                            "R2_gbm",
                            "R2_glm",
                            "R2_median")
  }

  ## Mini Function Eval
  mini_eval <- function(x, y, size_perc, num_size, num_cv, num_repeat, resamp_max) {
    
    ## Ctrl for caret
    ctrl <- trainControl(method = "repeatedcv",
                         number = num_cv,
                         repeats = num_repeat,
                         returnData = FALSE,
                         allowParallel = FALSE)
    
    ## Extract temporary features
    feature_temp <- imp_order[1:round(size_perc[num_size] * ncol(x))]
    
    ## Re-sampling
    if (nrow(x) > resamp_max) {
      row_sample <- as.integer(createDataPartition(y, p = resamp_max / nrow(x), list = FALSE))
    } else {
      row_sample <- as.integer(c(1:nrow(x)))
    }
    
    ## Train a svm
    suppressMessages(
      model_svm <- train(x[row_sample, feature_temp], y[row_sample],
                         method = "svmRadial",
                         tuneLength = 1,
                         metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                         maximize = TRUE,
                         trControl = ctrl)
    )
    
    ## Train a knn
    suppressMessages(
      model_knn <- train(x[row_sample, feature_temp], y[row_sample],
                         method = "knn",
                         tuneLength = 3,
                         metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                         maximize = TRUE,
                         trControl = ctrl)
    )
    
    ## Train a pcaNNet
    suppressMessages(
      model_pcaNNet <- train(x[row_sample, feature_temp], y[row_sample],
                             method = "pcaNNet",
                             tuneLength = 1,
                             metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                             maximize = TRUE,
                             trControl = ctrl)
    )
    
    ## Train a gbm
    suppressMessages(
      model_gbm <- train(x[row_sample, feature_temp], y[row_sample],
                         method = "gbm",
                         tuneLength = 1,
                         metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                         maximize = TRUE,
                         trControl = ctrl)
    )
    
    ## Train a glm
    suppressMessages(
      model_glm <- train(x[row_sample, feature_temp], y[row_sample],
                         method = "glm",
                         tuneLength = 1,
                         metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                         maximize = TRUE,
                         trControl = ctrl)
    )
    
    ## Store results
    if (is.factor(y)) {
      output_eval <- c(median(model_svm$resample$Accuracy),
                       median(model_knn$resample$Accuracy),
                       median(model_pcaNNet$resample$Accuracy),
                       median(model_gbm$resample$Accuracy),
                       median(model_glm$resample$Accuracy))
    } else {
      output_eval <- c(median(model_svm$resample$Rsquared),
                       median(model_knn$resample$Rsquared),
                       median(model_pcaNNet$resample$Rsquared),
                       median(model_gbm$resample$Rsquared),
                       median(model_glm$resample$Rsquared))
    }
    
    ## Return
    return(matrix(output_eval, nrow = 1))
    
  }
  
  ## Run evaluation in parallel
  for (num_size in 1:length(size_perc)) {
    
    ## Timer
    time_start <- start_timer()
    
    ## Display
    cat("[bib]: Evaluating the most important", 
        round(size_perc[num_size] * ncol(x)), 
        "features ...")
    
    ## Train and evaluate
    eval_temp <- foreach(num_model = 1:num_model_total,
                         .combine = rbind,
                         .multicombine = TRUE,
                         .errorhandling = "remove",
                         .packages = c("caret", "ff", "ffbase")) %dopar%
      mini_eval(x[,], y, size_perc, num_size, num_cv, num_repeat, resamp_max)
    
    eval_temp2 <- matrix(apply(eval_temp, 2, median), nrow=1)
    eval_temp2 <- c(eval_temp2, median(eval_temp2))
    
    eval_all[num_size, -1] <- eval_temp2
    
    ## Display
    if (is.factor(y)) {
      cat(" Mean Accuracy:", round(eval_temp2[length(eval_temp2)], digits = 3), 
          "... Duration:", stop_timer(time_start), "seconds.\n")
    } else {
      cat(" Mean R-squared:", round(eval_temp2[length(eval_temp2)], digits = 3), 
          "... Duration:", stop_timer(time_start), "seconds.\n")
    }
    
  }
  
  ## Add "decision"
  eval_best <- matrix("", nrow = length(size_perc), ncol = 1)
  eval_best[which(eval_all[,7] == max(eval_all[,7])), 1] <- "*Best*"  
  eval_all <- data.frame(eval_all, decision = eval_best)
  
  ## Output
  num_col_best <- as.integer(eval_all[which(eval_all[,7] == max(eval_all[,7]))[1], 1])
  feature_best <- imp_order[1:num_col_best]
  
  ## Display
  if (verbose) {
    ## Display
    cat("\n")
    cat("[bib]: Feature selection summary\n")
    print(eval_all)
    cat("\n")
    cat("[bib]: Total number of features selected:", length(feature_best), "\n")
    cat("[bib]: The name of those features are:\n", colnames(x[, feature_best]))
    cat("\n")
  }
  
  ## Return
  return(feature_best)
  
}