#' Install some of the key R packages for data mining.


install_key_pkg <- function() {
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Key packages on CRAN
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  if (TRUE) {
  
    ## Edit this list manually
    list_pkg <- c("devtools","caret","randomForest","e1071","kernlab","doSNOW",
                  "knitr","doSNOW","Rserve","shiny","forecast","ffbase","gbm",
                  "plyr", "dplyr", "data.table","microbenchmark","ggmap","jsonlite",
                  "roxygen2", "animation", "Quandl", "quantmod")
    
    ## Install packages one by one
    for (num_pkg in 1:length(list_pkg)) {  
      
      ## Display
      cat("Checking Package:", list_pkg[num_pkg], "...")
      
      ## Check
      suppressWarnings(
        suppressMessages(temp_check <- require(list_pkg[num_pkg], 
                                               character.only = TRUE,
                                               warn.conflicts = FALSE,
                                               quietly = TRUE)))
      
      
      ## Install if needed
      if (temp_check) {
        cat(" already installed.\n")
      } else {
        cat(" not there ... now installing ...\n")
        suppressMessages(install.packages(list_pkg[num_pkg]))
      }
      
    }
    
  }
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Install Packages on GitHub
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  ## Edit this list manually
  list_pkg <- data.frame(matrix(NA, nrow = 1, ncol = 3))
  colnames(list_pkg) <- c("author", "package", "dev")
  list_pkg[1,] <- c("rstudio", "shinyapps", "no")
  list_pkg[2,] <- c("ramnathv", "rCharts", "yes")
  list_pkg[3,] <- c("ramnathv", "slidify", "yes")
  list_pkg[4,] <- c("ramnathv", "slidifyLibraries", "yes")
  list_pkg[5,] <- c("ramnathv", "rMaps", "no")
  list_pkg[6,] <- c("ramnathv", "rblocks", "no")
  list_pkg[7,] <- c("woobe", "rCrimemap", "no")
  list_pkg[8,] <- c("jbryer", "makeR", "no")
  
  ## Install packages one by one
  for (n_pkg in 1:nrow(list_pkg)) {
    
    ## Display
    cat("Checking Package:", list_pkg[n_pkg,]$author, "/", list_pkg[n_pkg,]$package, "...")
    
    ## Check
    suppressWarnings(
      suppressMessages(temp_check <- 
                         require(list_pkg[n_pkg,]$package, 
                                 character.only = TRUE,
                                 warn.conflicts = FALSE,
                                 quietly = TRUE)))
    
    ## Install if needed
    if (!temp_check) {
      
      ## Display
      cat(" not there ... now installing ...\n")
      
      ## Generate text
      txt_install <- paste0(list_pkg[n_pkg,]$author, "/", list_pkg[n_pkg,]$package)
      
      ## Add "@dev" if needed
      if (list_pkg[n_pkg,]$dev == "yes") txt_install <- paste0(txt_install, "@dev")
      
      ## Install
      devtools::install_github(txt_install)
      
    } else {
      
      ## Display
      cat(" already installed.\n")
      
    }
    
  }
    
}


