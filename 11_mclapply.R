tic()
library(doParallel)
no_cores <- detectCores() - 2
result <- mclapply( 1:nrow(cv_df), cv_fun, mc.cores = no_cores)
toc()