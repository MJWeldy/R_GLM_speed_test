tic()
index <- 1:nrow(cv_df)
results <- purrr::map(index, cv_fun)
toc()