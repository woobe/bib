#' Generate random dummy x and y for demo purposes

gen_rand_xy <- function(num_sample = 1000, num_feature = 10, num_outcome = 1) {
  
  x <- matrix(rnorm(num_sample * num_feature), nrow = num_sample, ncol = num_feature)
  y <- matrix(rnorm(num_sample * num_outcome), nrow = num_sample, ncol = num_outcome)
  
  return(data.frame(x=x, y=y))
  
}

