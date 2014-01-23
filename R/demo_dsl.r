#' Demo R script using data from Kaggle's "Data Science London" competition
#' 

demo_dsl <- function() {
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Introduction
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  cat("\n")
  cat("[bib]: =============================================================================\n")
  cat("[bib]: DEMO Using data from Kaggle's 'Data Science London' competition\n")
  cat("[bib]: =============================================================================\n")
  
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Step 1 - Loading example dataset
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  ## Initiate the connection
  con <- url("http://woobe.bitbucket.org/data/bib/data_science_london.rda")
  
  ## Timer
  time_start <- start_timer()
  
  ## Display info
  cat("\n")
  cat("[bib]: STEP 1 - Loading example dataset (about 3.1MB).\n")
  cat("[bib]: Source --> http://woobe.bitbucket.org/data/bib/data_science_london.rda\n")
  cat("[bib]: The dataset has three objects --> ")
  
  ## Load and print the value to see what objects have been created
  print(load(con))  
  close(con)
  
  ## Display info
  cat("[bib]: It took", stop_timer(time_start), "seconds to load the objects from bitbucket.\n")
  
  
  
  
  
  
  
  
  
  
  
  
}











