#' Summarize an object with optional extra computations
#'
#' Applies a summary function to an object and optionally attaches
#' additional computations as an attribute.
#'
#' @param x An object to be summarized.
#' @param summary A function used to summarize \code{x}. If \code{NULL},
#'   \code{x} is returned unchanged.
#' @param summary.args A list of additional arguments passed to
#'   \code{summary} via \code{do.call()}.
#' @param extra An optional list of functions. Each function is applied
#'   to the original \code{x}, and the results are stored as the
#'   \code{"mcs"} attribute of the output.
#'
#' @return
#' If \code{summary} is provided, returns the result of
#' \code{summary(x, ...)}; otherwise returns \code{x}.
#' If \code{extra} is supplied, the returned object has an additional
#' attribute \code{"mcs"} containing a list of extra results.
#'
#' @details
#' Functions supplied in \code{extra} are always evaluated on the
#' original input \code{x}, not on the summarized output.
#'
#' @examples
#' summary_mcs(
#'   x = rnorm(10),
#'   summary = summary,
#'   extra = list(
#'     mean = mean,
#'     sd = sd
#'   )
#' )
#'
#' @export
#'
summary_mcs <- function(x,
                        summary = NULL,
                        summary.args = NULL,
                        extra = NULL){
  out <- x
  if(!is.null(summary)){
    out <- do.call(summary, c(list(x), summary.args))
  }

  if(!is.null(extra)){
    stopifnot(is.list(extra), all(vapply(extra, is.function, logical(1))))
    out_extra <- lapply(
      extra,
      function(f) f(x)
    )
    attr(out, "mcs") <- out_extra
  }
  return(out)
}

#' Calculate Standard Error and Confidence Interval for a Proportion
#'
#' This function computes the standard error and the asymptotic (Wald)
#' confidence interval for a given proportion based on a specified
#' number of simulations or observations.
#'
#' @param p A numeric value representing the proportion (between 0 and 1).
#' @param nsim An integer representing the number of simulations or the sample size.
#' @param conf.level A numeric value between 0 and 1 specifying the confidence
#'   level for the interval. Defaults to 0.95.
#'
#' @return A list containing:
#' \itemize{
#'   \item \code{se}: The calculated standard error of the proportion.
#'   \item \code{ci}: A named numeric vector with the lower bound (\code{ci.lb})
#'     and upper bound (\code{ci.ub}) of the confidence interval.
#' }
#'
#' @details
#' The standard error is calculated as:
#' \deqn{SE = \sqrt{\frac{p(1-p)}{n}}}
#' The confidence interval is calculated using the standard normal distribution
#' (Z-score) approximation.
#'
#' @examples
#' se_p(p = 0.5, nsim = 1000)
#' se_p(p = 0.2, nsim = 500, conf.level = 0.99)
#'
#' @export
se_p <- function(p, nsim, conf.level = 0.95){
  stopifnot("p must be a number between 0 and 1" = 0 <= p & p <= 1,
            "conf.level must be a number between 0 and 1" = 0 <= conf.level & conf.level <= 1,
            "nsim must be equal or higher than 1" = nsim >= 1)
  q  <- abs(qnorm((1 - conf.level)/2))
  se <- sqrt((p * (1 - p)) / nsim)
  ci <- p + c(-1, 1) * q * se
  names(ci) <- c("ci.lb", "ci.ub")
  list(
    se = se,
    ci = ci
  )
}
