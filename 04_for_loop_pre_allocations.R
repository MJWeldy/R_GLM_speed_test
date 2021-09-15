tic()
results <- rep(NA, nrow(cv_df))
for (i in 1:nrow(cv_df)) {
  results[i] <- cv_fun(i)
}
toc()