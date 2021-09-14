tic()
library(doParallel)
no_cores <- detectCores() - 2
result <- mclapply(i = 1, mc.cores = no_cores)
toc()