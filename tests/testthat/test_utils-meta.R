library(testthat)

# tau2_from_I2 ------------------------------------------------------------

I2i <- 0.5
vi <- 0.1
tau2 <- tau2_from_I2(I2i, vi)

test_that(
  "check tau2_from_I2", {
    expect_equal(I2(tau2, vi), I2i)
  }
)

# I2 ----------------------------------------------------------------------

vi <- 0.1
tau2 <- 0.5
I2_exp <- tau2 / (tau2 + vi)

test_that(
  "check I2 given tau2 and vi", {
    expect_equal(I2(tau2, vi), I2_exp)
  }
)

# sim_meta ----------------------------------------------------------------

# mu <- 0.3
# tau2 <- 0.2
# k <- 1e3
# n <- 1e5
#
# dat <- sim_meta(k, mu, tau2, n)
# fit <- metafor::rma(yi, vi, data = dat, method = "REML")











