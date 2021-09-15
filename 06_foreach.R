library(foreach)
tic()
results <- foreach(i = 1:nrow(cv_df)) %do% cv_fun(i)
toc()
