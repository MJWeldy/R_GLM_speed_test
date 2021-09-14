tic()
index <- 1:nrow(cv_df)
results <- lapply(index, cv_fun)
toc()