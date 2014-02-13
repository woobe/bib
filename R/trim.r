#' Trimming dataset 

trim <- function(x, num_row, from_top = FALSE) {
  if (num_row < nrow(x)) {
    num_end <- nrow(x)
    num_start <- num_end - num_row + 1
    x <- x[num_start:num_end,]
  }
  return(x)
}