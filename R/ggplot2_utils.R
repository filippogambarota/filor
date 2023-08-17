#' remove_axis
#' @description
#' Utility to remove in a vectorized manner axis elements from a \code{ggplot2} object
#'
#' @param where character vector indicating which axis to remove (e.g., "x" or c("x", "y"))
#' @param what character vector indicating which elements to remove (e.g., "title")
#'
#' @export
#'
remove_axes <- function(where,
                        what){
  txt <- sprintf("axis.%s.%s = element_blank()", what, where)
  txt <- sprintf("theme(%s)", paste(txt, collapse = ","))
  eval(parse(text=as.character(txt)))
}
