#' Calculate Nash-Sutcliffe Efficiency (y_sim can have multiple columns)

nse <- function(y_sim, y_obs) {
  
  ## Convert into Matrix
  y_sim <- as.matrix(y_sim)
  y_obs <- matrix(y_obs, nrow = nrow(y_sim), ncol = ncol(y_sim))
  y_obs_avg <- mean(y_obs[,1], na.rm = TRUE)
  
  ## Upper and Lower
  nse_upper <- colSums((y_obs - y_sim)^2)
  nse_lower <- colSums((y_obs - y_obs_avg)^2)
  nse_output <- 1 - (nse_upper / nse_lower)
  
  ## Return
  return(nse_output)
  
}