#' fpvalue
#'
#' @param p numeric. The p value to format
#' @param digits numeric. The number of digits that the p value should be printed with.
#' @param omit.p logical. Should the string "p ..." be omitted (e.g., for a table where the header is already "p")
#' @param tex logical. If TRUE, the latex math symbols are used
#' @param wrap character. A string that will be pasted before and after the final p value. Default to `NULL` thus empty string. If `NULL` and `tex` is `TRUE` the `$` symbol is used.
#' @return string with the formatted p value
#' @export
#'
#' @examples
#' fpvalue(0.0001, tex = TRUE)
#' fpvalue(0.001, tex = FALSE)
fpvalue <- function(
  p,
  digits = 3,
  omit.p = FALSE,
  tex = FALSE,
  wrap = NULL
) {
  limit <- 10^(-digits)

  if (is.null(wrap)) {
    if (tex) {
      wrap <- "$"
    } else {
      wrap <- ""
    }
  }

  sym_min <- if (tex) "\\leq" else "<"

  if (omit.p) {
    ptext <- ifelse(
      p < limit,
      sprintf("%s %s", sym_min, limit),
      as.character(round(p, digits))
    )
  } else {
    ptext <- ifelse(
      p < limit,
      sprintf("p %s %s", sym_min, limit),
      sprintf("p = %s", round(p, digits))
    )
  }

  ptext <- sprintf("%s%s%s", wrap, ptext, wrap)

  return(ptext)
}
