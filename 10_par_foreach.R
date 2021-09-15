tic()
library(doParallel)
no_cores <- detectCores() - 2
registerDoParallel(cores = no_cores)
cl <- makeCluster(no_cores)
results <- foreach(i = 1:nrow(cv_df)) %dopar% cv_fun(i)
stopCluster(cl)
toc()
