\name{select_feature}
\alias{select_feature}
\title{Select best features in x based on known y}
\usage{
select_feature(x, y, resamp_max = 1000, rf_samp_perc = 0.1,
  rf_samp_max = 500, rf_mtry_perc = 0.1, rf_mtry_max = 500,
  rf_tree = 100, num_model_max = 10, size_perc = seq(0.1, 0.5, 0.05),
  num_cv = 4, num_repeat = 1, num_model_eval = 3, verbose = TRUE)
}
\description{
Select best features in x based on known y
}

