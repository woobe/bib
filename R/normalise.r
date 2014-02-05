#' Normalise values

normalise <- function(x, method = "range") {
  pp <- caret::preProcess(x, method)
  return(predict(pp, x))
}