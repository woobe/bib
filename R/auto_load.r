#' Load package and automatically install it if it has not been installed

auto_load <- function(list_pkg) {
  
  for (num_pkg in 1:length(list_pkg)) {  
    
    ## Display
    cat("Checking Package:", list_pkg[num_pkg], "...")
    
    ## Check
    suppressMessages(temp_check <- require(list_pkg[num_pkg], 
                                           character.only = TRUE,
                                           warn.conflicts = FALSE,
                                           quietly = TRUE))
    
    ## Install if needed
    if (temp_check) {
      cat(" already installed.\n")
    } else {
      cat(" not there ... now installing ...\n")
      suppressMessages(install.packages(list_pkg[num_pkg]))
    }
    
  }
  
}