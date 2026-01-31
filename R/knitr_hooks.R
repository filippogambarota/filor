#' Filter knitr output by line indices
#'
#' Sets a custom knitr output hook that filters printed output, keeping only
#' the lines specified in the chunk option \code{lines}. This is useful when
#' you want to show only selected parts of console output in knitted documents.
#'
#' The function modifies knitr's global output hook. Call it once (e.g., in a
#' setup chunk) to activate the behavior for the rest of the document.
#'
#' @details
#' The hook:
#' \itemize{
#'   \item splits the output into lines using \code{xfun::split_lines()}
#'   \item selects lines via an internal helper \code{filor:::.grep_lines()}
#'   \item passes the filtered output to the original knitr output hook
#' }
#'
#' @return
#' Invisibly returns \code{NULL}. Called for its side effects.
#'
#' @seealso
#' \code{\link[knitr]{knit_hooks}}
#'
#' @examples
#' \dontrun{
#' set_filter_output()
#'
#' ## In an R Markdown chunk:
#' ## ```{r, lines = c(1, 3, 5)}
#' ## print(1:10)
#' ## ```
#' }
#'
#' @export
set_filter_output <- function(){
  hook_old <- knitr::knit_hooks$get("output")
  knitr::knit_hooks$set(output = function(x, options) {
    lines <- options$lines
    x <- xfun::split_lines(x)
    x <- x[filor:::.grep_lines(x, lines)]
    hook_old(x, options)
  })
}
