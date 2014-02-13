#' Wrapper function to delete files or directories

del <- function(file_to_delete) {
  
  ## Remove unwanted files and dir
  for (item in file_to_delete) {
    if (file.exists(item)) unlink(item, recursive = TRUE, force = TRUE)
  }
  
}
