tic()
results <- c()
for (i in 1:nrow(cv_df)) {
  results[i] <- cv_fun(i)
}
toc()