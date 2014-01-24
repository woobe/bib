#' Normalise values

normalise <- function(x, method = "range") {
  pp <- preProcess(x, method)
  return(predict(pp, x))
}