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
    j$assign("form", formula(cv_df$Var2[[x]]))
    j$assign("dt", dt)
    j$assign("train", train)
    j$eval("glmm1 = fit(GeneralizedLinearMixedModel, form, train, Binomial())")
    coefs <- j$eval("coef(glmm1)")
    # test_eval <- plogis(coefs[1]+(0.002135430*test_use$cov3) + (-0.009059523*test_use$cov1) + (-0.008199742*test_use$cov2))
    # background_eval <- plogis(-0.097+0.002135430*test_background$cov3 -0.009059523*test_background$cov1 -0.008199742*test_background$cov2)
    # dismo::evaluate(test_eval, background_eval)@auc
  },
  cv_df, dt
)
stopCluster(cl)
toc()
