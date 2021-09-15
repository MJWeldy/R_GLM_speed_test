set.seed(1)
library(data.table)
library(dplyr)
library(dismo)
library(tidyverse)
# Simulate data for 400 individuals. 5 covariates, two random hierarchies
# Assign k-fold values to each data point
n <- 50000
n_fold <- 10
pop_string <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10")
dt <- data.table(
    ID = factor(sample(1:400, n, replace = TRUE)),
    cov1 = runif(n),
    cov2 = runif(n),
    cov3 = runif(n),
    cov4 = runif(n)
  ) %>%
  group_by(ID) %>%
  mutate(
    cov5 = factor(sample(c(0, 1), 1, n())),
    y = factor(sample(c(0, 1), 1, n())),
    population = factor(sample(pop_string, 1, n())),
    k_fold_id = kfold(n(), n_fold)
  ) %>%
  ungroup()

# Generating formula strings
num_formulas <- 5
n_cov <- sample(1:5, num_formulas, replace = TRUE) #
formula_fun <- function(n_covs) {
  covs <- names(dt)[2:6] %>%
    sample(n_covs, replace = FALSE) %>%
    paste(collapse = "+")
  random <- c("+(1|ID)", "+(1|population)", "+(1|ID)+(1|population)")
  formula <- paste0("y~", covs, sample(random, 1))
}
formulas <- map(n_cov, formula_fun)

# Create
cv_df <- expand.grid(seq(1, n_fold), formulas)
