library(tictoc)
source("01_simulate_big_data.R")
head(dt)
head(cv_df, n = 12)
source("02_load_functions.R")
# Testing the speed of various loop and iterators
# I fit 5 GLMs 10 times to 9 folds of a 50,000 row dataset.
# 1-5 fixed effects, 1-2 random effects per fit.
# I then used dismo to calculate the AUC score on
# 10% of the withheld data. The goal was to estimate mean
# AUC and an AUC confidence interval for
# using tictoc to measure fit speeds
source("03_for_loop.R")            # 730.52 sec elapsed
source("04_lapply.R")              # 706.97 sec elapsed
source("05_foreach.R")              # 706.97 sec elapsed
source("06_purrr_map.R")           # 715.63 sec elapsed
# Parallel implementations. 
# Moderately effective in Windows (more effective on
# mac/linux). ALso, the gains here would likely increase as the number of rows
# of cv_df increases (i.e. either the number of folds or number of model structures)
source("07_furrr_future_map.R")    # 120.25 sec elapsed
source("08_parLapply.R")           # 22.83 sec elapsed
source("09_par_foreach.R")             # 122.93 sec elapsed
# source("10_mclapply.R") does not work for more than 1 core on windows
