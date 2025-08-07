#' Calculate Standard Error (SE) associated with a desired level of statistical power
#' @description Calculate the Standard Error (SE) that is associated with a given power and a given alpha level for a given value of a model parameter B
#' @param B The model parameter B (practically, the effect size)
#' @param power The desired level of statistical power
#' @param alpha The alpha level (rate of type I errors)
#' @param alternative Whether the statistical test is two sided or one sided. Must be one of "two.sided" (default) or "one.sided"
#'
#' @return The numerical value of the Standard Error (SE) associated with the above arguments
#' @export
SE4power = function(b, power = 0.80, alpha = 0.05, alternative = "two.sided") {
  alternative <- match.arg(alternative, choices = c("two.sided", "one.sided"))
  if (alternative == "two.sided") {
    alpha <- alpha / 2
  }
  SE <- abs(b) / (qnorm(1 - alpha) + qnorm(power))
  return(SE)
}
