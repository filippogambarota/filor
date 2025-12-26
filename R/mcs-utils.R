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
