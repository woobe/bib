#' Install some of the key R packages for data mining.


install_key_pkg <- function() {
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Key packages on CRAN
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  list_pkg <- c("devtools","caret","randomForest","e1071","kernlab","doSNOW",
                    "knitr","doSNOW","Rserve","shiny","forecast","ffbase","gbm",
                    "dplyr", "data.table","microbenchmark","ggmap","jsonlite",
                    "roxygen2", "animation", "Quandl", "quantmod")
  
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
  
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Shinyapps
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  cat("Checking Package: shinyapps ...")
  
  ## Check
  suppressMessages(temp_check <- require("shinyapps", 
                                         character.only = TRUE,
                                         warn.conflicts = FALSE,
                                         quietly = TRUE))
  
  ## Install if needed
  if (temp_check) {
    cat(" already installed.\n")
  } else {
    cat(" not there ... now installing ...\n")
    suppressMessages(devtools::install_github('rstudio/shinyapps'))
  }
  
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## rCharts
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  cat("Checking Package: rCharts ...")
  
  ## Check
  suppressMessages(temp_check <- require("rCharts", 
                                         character.only = TRUE,
                                         warn.conflicts = FALSE,
                                         quietly = TRUE))
  
  ## Install if needed
  if (temp_check) {
    cat(" already installed.\n")
  } else {
    cat(" not there ... now installing ...\n") 
    suppressMessages(devtools::install_github("rCharts", "ramnathv", ref = "dev"))
  }
  
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## slidify
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  cat("Checking Package: slidify ...")
  
  ## Check
  suppressMessages(temp_check <- require("slidify", 
                                         character.only = TRUE,
                                         warn.conflicts = FALSE,
                                         quietly = TRUE))
  
  ## Install if needed
  if (temp_check) {
    cat(" already installed.\n")
  } else {
    cat(" not there ... now installing ...\n") 
    suppressMessages(devtools::install_github("slidify", "ramnathv", ref = "dev"))
  }
  
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## slidifyLibraries
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  cat("Checking Package: slidifyLibraries ...")
  
  ## Check
  suppressMessages(temp_check <- require("slidifyLibraries", 
                                         character.only = TRUE,
                                         warn.conflicts = FALSE,
                                         quietly = TRUE))
  
  ## Install if needed
  if (temp_check) {
    cat(" already installed.\n")
  } else {
    cat(" not there ... now installing ...\n") 
    suppressMessages(devtools::install_github("slidifyLibraries", "ramnathv", ref = "dev"))
  }
  
}




