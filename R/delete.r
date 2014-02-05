#' Wrapper function to delete files or directories

delete <- function(file_to_delete) {
  
  ## Remove unwanted files and dir
  for (item in file_to_delete) {
    fn <- item
    if (file.exists(fn)) file.remove(fn)
  }
  
}
