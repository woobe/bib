#' Get the mode of a numeric or character matrix
#' 
#' Original Code: http://stackoverflow.com/questions/2547402/standard-library-function-in-r-for-finding-the-mode

get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}