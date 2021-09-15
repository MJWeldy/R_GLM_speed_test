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
source("03_for_loop_no_allocations.R")      # 463.14 sec elapsed
source("04_for_loop_pre_allocations.R")     # 449.45 sec elapsed
source("05_lapply.R")                       # 450.69 sec elapsed
source("06_foreach.R")                      # 446.64 sec elapsed
source("07_purrr_map.R")                    # 450.05 sec elapsed
# Parallel implementations. 
# Moderately effective in Windows (more effective on
# mac/linux). ALso, the gains here would likely increase as the number of rows
# of cv_df increases (i.e. either the number of folds or number of model structures)
source("08_furrr_future_map.R")             # 90.06 sec elapsed
source("09_parLapply.R")                    # 5.06 sec elapsed
source("10_par_foreach.R")                  # 79.64 sec elapsed
# source("11_mclapply.R") does not work for more than 1 core on windows
