#' Data slicing for multivariate data (x1, x2, x3 ..., y)

slice_multi <- function(x, y, num_past = 3, include_y = TRUE, verbose = FALSE) {

  ## Timer
  if (verbose) {
    tt <- start_timer()
  }
  
  ## Convert into matrix
  x <- as.matrix(x)
  y <- matrix(y, ncol = 1)
  
  ## Empty Shell
  output <- matrix(NA, nrow = (nrow(y) - num_past), ncol = (num_past * ncol(x)))
  
  ## Slice x
  for (num_col in 1:ncol(x)) {
    num_start <- (num_col-1) * num_past + 1
    num_end <- num_col * num_past
    temp_output <- slice_univ(x[, num_col], num_past)
    temp_output <- temp_output[, which(!colnames(temp_output) %in% "y")]
    temp_output <- as.matrix(temp_output)
    output[, num_start:num_end] <- temp_output
  }
  
  ## Slice y
  if (include_y) {
    output <- cbind(output, as.matrix(slice_univ(y, num_past)))
  } else {
    output <- cbind(output, as.matrix(slice_univ(y, num_past)$y))
  }

  ## Convert into data.frame
  output <- data.frame(output)
  colnames(output) <- c(paste0("x", 1:(ncol(output)-1)), "y")
  
  ## Display
  cat("[bib]: Converted xy from", ncol(x) + ncol(y), "x 1 into", dim(output)[1], "x", dim(output)[2], "in", stop_timer(tt), "seconds.")
  
  ## Return
  return(output)
  
}
