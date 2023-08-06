#' tau2_from_I2
#'
#' @param I2 the I squared value
#' @param vi the effect size sampling variability
#'
#' @return the tau2 value
#' @export
#'
#' @examples
#' tau2_from_I2(0.2, 0.08)
tau2_from_I2 <- function(I2, vi){
  (I2 * vi) / (1 - I2)
}

#' I2
#'
#' @param tau the standard error (tau)
#' @param vi the typical sampling variability
#'
#' @return numeric the I^2 value
#' @export
#'
#' @examples
#' I2(0.1, 0.08)
I2 <- function(tau, vi){
  tau^2 / (tau^2 + vi)
}

#' sim_meta
#' @description
#' Simulate meta-analysis data using unstandardized mean difference as effect size.
#' @param k number of studies.
#' @param mu average effect size.
#' @param tau2 between studies heterogeneity.
#' @param n1 sample size for the first group.
#' @param n2 sample size for the second group. Default to \code{NULL}
#' @param v pooled within-study variance. Default to \code{1}
#'
#' @return dataframe with simulated data
#' @export
#'
#' @examples
#' # simulate equal-effects model with 10 studies, 30 participants in each study
#' # and an effect size of 0.5
#' sim_meta(10, 0.5, 0, 30, 30)
sim_meta <- function(k,
                     mu,
                     tau2,
                     n1,
                     n2 = NULL,
                     v = 1){
  if(is.null(n2)) n2 <- n1

  if(length(n1) > 1 | length(n2) > 1){
    if(length(n1) != k | length(n2) != k){
      stop("When used as vector, n1 and n2 need to be of the same length as k")
    }
  }

  deltai <- rnorm(k, 0, sqrt(tau2))
  yi <- mu + deltai + rnorm(k, 0, sqrt(v*(1/n1 + 1/n2)))
  vi <- (rchisq(k, n1 + n2 - 2) / (n1 + n2 - 2)) * v*(1/n1 + 1/n2)
  data.frame(id = 1:k, yi, vi, sei = sqrt(vi), deltai, n1 = n1, n2 = n2)
}


