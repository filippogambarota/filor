#' tau2_from_I2
#'
#' @param I2 the I squared value
#' @param vi the "typical" effect size sampling variability
#'
#' @return the tau2 value
#' @export
#'
#' @examples
#' tau2_from_I2(0.2, 0.08)
tau2_from_I2 <- function(I2, vi){
  -((I2 * vi) / (I2 - 1))
}

#' I2
#'
#' @param tau2 the heterogeneity
#' @param vi the typical sampling variability
#'
#' @return numeric the I^2 value
#' @export
#'
#' @examples
#' I2(0.1, 0.08)
I2 <- function(tau2, vi){
  tau2 / (tau2 + vi)
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

#' summary_rma
#'
#' @param x a model fitted with \code{metafor::rma.uni()}
#' @param extra_params a vector of (extra) parameters to be extracted (see details). These are the elements of the \code{rma.uni} objects.
#' @details
#' By default the function extract \code{c("b", "se", "zval", "pval", "ci.lb", "ci.ub")} as parameters.
#' @return a dataframe
#' @export
#'
summary_rma <- function(x,
                         extra_params = NULL) {

  if(x$model != "rma.uni"){
    stop("The function currently support only rma.uni models")
  }

  params <- c("b", "se", "zval", "pval", "ci.lb", "ci.ub")

  if(!is.null(extra_params)){
    extra_params <- base::setdiff(extra_params, params)
    params <- c(params, extra_params)
  }

  fixefs <- lapply(params, function(p) if(is.numeric(x[p])) as.numeric(x[p]) else x[p])
  names(fixefs) <- params
  fixefs <- data.frame(fixefs)

  if (is.null(x$model)) {
    sigmas <- x$sigma2
  }
  else {
    sigmas <- x$tau2
  }

  if(x$model == "rma.uni"){
    fixefs$I2 <- x$I2
  }

  if(length(sigmas) > 1){
    names(sigmas) <- paste0("tau2_", 1:length(sigmas))
  }else{
    names(sigmas) <- "tau2"
  }

  out <- cbind(fixefs, t(data.frame(sigmas)))
  rownames(out) <- NULL
  return(out)
}

#' compare_rma
#' @description
#' Put in a dataframe one or more models fitted with \code{metafor::rma.uni} for a nice visual comparison.
#'
#' @param ... models to be compared
#' @param fitlist a list of models instead of using `...`. When `fitlist` is provided `...` are ignored.
#' @param extra_params a vector of (extra) parameters to be extracted. These are the elements of the \code{rma.uni} objects.
#'
#' @return a dataframe
#' @export
#'
compare_rma <- function(..., fitlist = NULL, extra_params = NULL) {
  if(!is.null(fitlist)){
    fits <- fitlist
    fitnames <- names(fitlist)
  }else{
    fits <- list(...)
    fitnames <- as.list(substitute(...()))
  }
  sums <- lapply(fits, filor::summary_rma, extra_params = extra_params)
  sums <- do.call(rbind, sums)
  out <- data.frame(t(sums))
  setNames(out, fitnames)
}


#' r_to_z
#' @description
#' convert a correlation into the Fisher's z
#'
#' @param r the correlation
#'
#' @return the Fisher's z transformed correlation
#' @export
#'
r_to_z <- function(r){
  atanh(r)
}

#' z_to_r
#' @description
#' convert a Fisher's z into a correlation coefficient
#'
#' @param z the Fisher's value
#'
#' @return the correlation
#' @export
#'
z_to_r <- function(z){
  tanh(z)
}

#' rmat
#' @description
#' create a correlation matrix given the vector x of unique correlations
#'
#' @param x
#'
#' @return the correlation matrix
#' @export
#'
rmat <- function(x){
  p <- rdim(length(x))
  R <- diag(p)
  R[lower.tri(R)] <- x
  R[upper.tri(R)] <- t(R)[upper.tri(R)]
  R
}
