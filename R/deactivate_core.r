#' De-activate multiple CPU cores when they are not needed anymore.

deactivate_core <- function(num_core = 4, verbose = FALSE) {
  
  ## Timer
  if (verbose) tt <- start_timer()
  
  ## Load Packages
  suppressMessages(library(doSNOW))
  suppressMessages(library(foreach))  
  
  ## Display
  if (verbose) cat("De-activaing parallel processing ... ")
  
  ## Activate Cores
  stopCluster(makeCluster(num_core, type="SOCK"))
  
  ## Display
  if (verbose) cat(num_core, "cores have been de-activated in", stop_timer(tt), "seconds.\n")
  
}


