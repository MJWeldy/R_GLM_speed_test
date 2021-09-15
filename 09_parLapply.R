tic()
library(doParallel)
no_cores <- detectCores() - 2
registerDoParallel(cores = no_cores)
cl <- makeCluster(no_cores)
results <- parLapply(
  cl, 1:2,
  function(x, cv_df, dt) {
    train <- collapse::fsubset(dt, k_fold_id != cv_df$Var1[x])
    test_use <- collapse::fsubset(dt, k_fold_id == cv_df$Var1[x] & y == 1)
    test_background <- collapse::fsubset(dt, k_fold_id == cv_df$Var1[x] & y == 0)
    mod <- lme4::glmer(cv_df$Var2[[x]],
      data = train,
      family = binomial(link = "logit"),
      nAGQ = 0,
      control = lme4::glmerControl(optimizer = "nloptwrap")
    )
    dismo::evaluate(test_use, test_background, mod)@auc
  },
  cv_df, dt
)
stopCluster(cl)
toc()

