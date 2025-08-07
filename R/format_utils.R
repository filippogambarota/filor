#' fpvalue
#'
#' @param p numeric. The p value to format
#' @param limit numeric. the minimum value to print. Default to 0.001
#' @param tex logical. If TRUE, the result is inserted into two \code{$...$}
#'
#' @return string with the formatted p value
#' @export
#'
#' @examples
#' fpvalue(0.001, tex = TRUE)
#' fpvalue(0.001, tex = FALSE)
fpvalue <- function(p, limit = 0.001, tex = FALSE){
  p_out <- ifelse(p < limit,
                  "p < 0.001",
                  sprintf("p = %s", p))
  if(tex){
    p_out <- sprintf("$%s$", p_out)
  }

  return(p_out)
}

#' colorize
#' @description thanks to https://bookdown.org/yihui/rmarkdown-cookbook/font-color.html#using-an-r-function-to-write-raw-html-or-latex-code
#' @param x the text to be formatted
#' @param color the color to be applied
#'
#' @return string with the formatted p value
#' @importFrom knitr is_html_output
#' @importFrom knitr is_latex_output
#' @export
#'
#' @examples
#' colorize("red text", "red")
colorize <- function(x, color) {
  if (knitr::is_latex_output()) {
    sprintf("\\textcolor{%s}{%s}", color, x)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='color: %s;'>%s</span>", color,
            x)
  } else x
}
