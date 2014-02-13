#' Get the mode of a numeric or character matrix

get_mode <- function(x) {
  ## Original Code: http://stackoverflow.com/questions/2547402/standard-library-function-in-r-for-finding-the-mode
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}