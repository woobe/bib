#' Data slicing for univariate data (y)

slice_univ <- function(y, num_past = 5, verbose = FALSE) {
  
  ## Timer
  if (verbose) {
    tt <- start_timer()
  }
  
  
  ## Convert into Matrix regardless
  y <- matrix(y, ncol = 1)
  
  ## Create empty shell
  output <- matrix(0, nrow = nrow(y) - num_past, ncol = num_past + 1)
  
  ## Mini function
  for (num_col in 1:(num_past+1)) {
    num_start <- num_col
    num_end <- (nrow(y) - num_past) + num_col - 1
    output[, num_col] <- y[num_start:num_end,]
  }
    
  ## Convert into data.frame
  output <- data.frame(output)
  colnames(output) <- c(paste0("x", 1:(ncol(output)-1)), "y")
  
  ## Display
  if (verbose) {
    cat("[bib]: Converted y from", nrow(y), "x 1 into", dim(output)[1], 
        "x", dim(output)[2], "in", stop_timer(tt), "seconds.")
  }
  
  
  ## Return
  return(output)
  
}
