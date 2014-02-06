#' Activate multiple CPU cores for parallel computing.

activate_core <- function(num_core = 4, verbose = TRUE) {
  
  if (verbose) tt <- start_timer()
  
  ## Load Packages
  suppressMessages(library(doSNOW))
  suppressMessages(library(foreach))  

  if (verbose) cat("[bib]: Activaing parallel processing ... ")
  
  ## Activate Cores
  registerDoSNOW(makeCluster(num_core, type="SOCK"))
  
  if (verbose) cat(num_core, "cores have been successfully activated in", stop_timer(tt), "seconds.\n")
    
}
