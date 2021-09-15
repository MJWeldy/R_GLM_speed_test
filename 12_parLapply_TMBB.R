tic()
library(doParallel)
no_cores <- detectCores() - 2
registerDoParallel(cores = no_cores)
cl <- makeCluster(no_cores)
x <- 1
results <- parLapply(
  cl, 1:2,
  function(x, cv_df, dt) {
    train <- collapse::fsubset(dt, k_fold_id != cv_df$Var1[x])
    test_use <- collapse::fsubset(dt, k_fold_id == cv_df$Var1[x] & y == 1)
    test_background <- collapse::fsubset(dt, k_fold_id == cv_df$Var1[x] & y == 0)
    mod <- glmmTMB::glmmTMB(as.formula(cv_df$Var2[[x]]),
                       data = train,
                       family = binomial(link="logit")
    )
    dismo::evaluate(test_use, test_background, mod)@auc
  },
  cv_df, dt
)
stopCluster(cl)
toc()
