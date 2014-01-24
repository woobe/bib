#' Selecting best features in x based on known y

select_feature <- function(x, y, method = "fastest", verbose = TRUE) {
  
  ## Timer
  time_start <- start_timer()
  
  ## Load Package
  suppressMessages(library("randomForest"))
  suppressMessages(library("nnet"))
  
  ## Display?
  if (verbose) {
    cat("\n")
    cat("[bib]: Calculating variable importance score ...")
  }
  
  ## Core Options
  opt <- list()
  
  if (method == "fastest") {
    opt$mtry <- max(c(2, round(ncol(x) * 0.1)))
    opt$sampsize <- min(c(100, round(nrow(x) * 0.1)))
    opt$ntree <- 100
    opt$cv <- 5
    opt$repeats <- 1
  } else if (method == "fast") {
    opt$mtry <- max(c(2, round(ncol(x) * 0.2)))
    opt$sampsize <- min(c(100, round(nrow(x) * 0.2)))
    opt$ntree <- 200
    opt$cv <- 10
    opt$repeats <- 1
  } else if (method == "normal") {
    opt$mtry <- max(c(2, round(ncol(x) * 0.33)))
    opt$sampsize <- min(c(100, round(nrow(x) * 0.33)))
    opt$ntree <- 250
    opt$cv <- 10
    opt$repeats <- 3
  }
  
  opt$size <- c(round(ncol(x) * 0.1),
                round(ncol(x) * 0.2),
                round(ncol(x) * 0.3),
                round(ncol(x) * 0.4),
                round(ncol(x) * 0.5),
                round(ncol(x) * 0.6),
                round(ncol(x) * 0.7),
                round(ncol(x) * 0.8),
                round(ncol(x) * 0.9),
                ncol(x))
  
  ## Mini Function
  mini_rf <- function(x, y, opt) {
    model <- randomForest(x, y, 
                          mtry = opt$mtry,
                          sampsize = opt$sampsize,
                          ntree = opt$ntree,
                          importance = TRUE)
    return(normalise(matrix(model$importance[, 1], ncol=1)))
  }

  ## Run in Parallel
  imp <- foreach(num_model = 1:100, 
                 .combine = cbind, 
                 .multicombine = TRUE,
                 .errorhandling = "remove",
                 .packages = c("randomForest","bib","caret")) %dopar%
    mini_rf(x, y, opt)
  
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
  eval_all <- data.frame(matrix(0, nrow = length(opt$size), ncol = 5))
  eval_all[, 1] <- opt$size
  
  if (is.factor(y)) {
    colnames(eval_all) <- c("num_features", "acc_rf", "acc_knn", "acc_avNNet", "acc_mean")
  } else {
    colnames(eval_all) <- c("num_features", "r2_rf", "r2_knn", "r2_avNNet", "r2_mean")
  }
  
  ## Ctrl for caret
  ctrl <- trainControl(method = "repeatedcv",
                       number = opt$cv,
                       repeats = opt$repeats,
                       returnData = FALSE,
                       allowParallel = TRUE)
  
  ## Mini Function Eval
  mini_eval <- function(x, y, opt, imp_order, num_size) {
    
    ## Extract temporary features
    feature_temp <- imp_order[1:opt$size[num_size]]
    
    ## Train a rf
    model_rf <- train(x[, feature_temp], y,
                      method = "rf",
                      ntree = 50,
                      tuneLength = 3,
                      metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                      maximize = TRUE,
                      trControl = ctrl)
    
    ## Train a knn
    model_knn <- train(x[, feature_temp], y,
                       method = "knn",
                       tuneLength = 3,
                       metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                       maximize = TRUE,
                       trControl = ctrl)
    
    ## Train a knn
    model_avNNet <- train(x[, feature_temp], y,
                          method = "avNNet",
                          tuneLength = 3,
                          metric = ifelse(is.factor(y), "Accuracy", "Rsquared"),
                          maximize = TRUE,
                          trControl = ctrl)
    
    ## Store results
    if (is.factor(y)) {
      output_eval <- c(median(model_rf$resample$Accuracy),
                       median(model_knn$resample$Accuracy),
                       median(model_avNNet$resample$Accuracy))
    } else {
      output_eval <- c(median(model_rf$resample$Rsquared),
                       median(model_knn$resample$Rsquared),
                       median(model_avNNet$resample$Rsquared))
    }
    
    ## Return
    return(matrix(output_eval, nrow = 1))
    
  }
  
  ## Run evaluation in parallel
  for (num_size in 1:length(opt$size)) {
    
    ## Timer
    time_start <- start_timer()
    
    ## Display
    cat("[bib]: Evaluating performance with the most important ", opt$size[num_size], "features ...")
    
    ## Train and evaluate
    suppressWarnings(eval_temp <- mini_eval(x, y, opt, imp_order, num_size))
    eval_temp <- cbind(eval_temp, mean(eval_temp))
    eval_all[num_size, 2:5] <- eval_temp
    
    ## Display
    cat(" Mean Acc/R2:", round(eval_temp[4], digits = 2), 
        "... Duration:", stop_timer(time_start), "seconds.\n")
    
  }
  
  ## Add "decision"
  eval_best <- matrix("", nrow = length(opt$size), ncol = 1)
  eval_best[which(eval_all[,5] == max(eval_all[,5])), 1] <- "*Best*"  
  eval_all <- data.frame(eval_all, decision = eval_best)
  
  ## Display
  if (verbose) {
    ## Display
    cat("\n")
    cat("[bib]: Feature selection summary\n")
    print(eval_all)
  }
  
  ## Return
  feature_best <- imp_order[1:opt$size[which(eval_all[,5] == max(eval_all[,5]))]]
  return(feature_best)
  
}