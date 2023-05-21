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
