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
  key_val_temp <- "%s: %s\n  "
  out <- vector(mode = "list", length = length(x))
  for(i in 1:length(x)){
    x[[i]] <- ifelse(is.na(x[[i]]), "", x[[i]])
    out[[i]] <- sprintf(key_val_temp, names(x)[i], x[[i]])
  }
  nn <- length(out[[1]])
  yml <- lapply(1:nn, function(i) sapply(out, function(x) x[i]))
  yml <- lapply(yml, paste, collapse = "")
  yml <- sapply(yml, function(x) paste("-", x))
  if(!is.null(file)){
    writeLines(yml, con = file)
    invisible(yml)
  } else{
    yml
  }
}
