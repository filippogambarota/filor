#' Create a YAML-style list from a named vector or list
#'
#' This function takes a named vector or list and converts it into a
#' YAML-style list of key–value pairs. Each element is represented as
#' `- key: value`. If a file path is provided, the YAML output is written
#' to disk.
#'
#' @param x A named vector or list. The names will be used as keys, and
#'   the corresponding values as values. `NA` values are converted to
#'   empty strings.
#' @param file Optional. A character string giving the path to a file where
#'   the YAML output should be written. If `NULL` (default), the result
#'   is returned instead of written.
#'
#' @return If `file` is `NULL`, returns a character vector with one entry
#'   per YAML item. If `file` is not `NULL`, the YAML output is written
#'   to the specified file and the result is returned invisibly.
#'
#' @examples
#' # Create a simple YAML list from a named vector
#' x <- c(name = "Alice", age = 30, country = NA)
#' create_yml(x)
#'
#' @export
create_yml <- function(x, file = NULL){
  # Replace NA with empty string efficiently using vectorization
  x <- lapply(x, function(val) ifelse(is.na(val), "", val))
  
  # Create key-value pairs efficiently
  out <- lapply(seq_along(x), function(i) {
    sprintf("%s: %s\n  ", names(x)[i], x[[i]])
  })
  
  # Assumes all elements in x have the same length (original behavior)
  nn <- length(out[[1]])
  yml <- lapply(1:nn, function(i) vapply(out, function(x) x[i], character(1)))
  yml <- vapply(yml, paste, character(1), collapse = "")
  yml <- paste("-", yml)
  
  if(!is.null(file)){
    writeLines(yml, con = file)
    invisible(yml)
  } else{
    yml
  }
}
