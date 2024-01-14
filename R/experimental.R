.get_id_na <- function(x){
  res <- sapply(unique(x), function(lv) {
    id_na <- which(x %in% lv)
    if(length(id_na) != 1){
      id_na[-1]
    }
  })
  unname(unlist(res))
}

#' Collapse rows of a dataframe
#' @param data a dataframe
#' @param cols character vector with columns to collapse
#' @param to value to put. Default to `NA`
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' dt <- data.frame(a = c(1, 1, 2, 2), b = c("a", "a", "a", "b"))
#' collapse_rows(dt, "a", to = "")
collapse_rows <- function(data, cols, to = NA){
  idx <- which(names(data) %in% cols)
  dcols <- data[, cols, drop = FALSE]

  ncols <- dcols
  for(i in 1:ncol(dcols)){
    id_to_na <- .get_id_na(dcols[[i]])
    ncols[id_to_na, i] <- to
  }
  ncols <- data.frame(ncols)
  ndata <- data[, which(!names(data) %in% names(ncols)), drop = FALSE]
  ndata <- cbind(ndata, ncols)
  ndata[, names(data)]
}
