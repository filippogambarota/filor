#' col_has_na
#' @description Return columns names where there is
#' at least one NA value
#' @param data dataframe
#'
#' @return character vector
#' @export
#'
col_has_na <- function(data){
  # return TRUE if a column is all without NA
  has_na <- sapply(data, function(col) any(is.na(col)))
  colnames(data)[has_na] # select only NA columns
}

#' get_na_rows
#' @description Return the rows index where there are NA values in specific
#' columns
#' @param data dataframe
#' @param ... comma separated names of columns to evaluate
#' @param subset logical that indicate if returning the subsetted data.
#' Default to \code{false}
#' @return integer vector
#' @export
#'
get_na_rows <- function(data, ..., subset = FALSE){
  cols <- as.list(substitute(...())) # get columns to check
  cols <- as.character(unlist(cols))

  if(length(cols) < 1){
    cols <- TRUE # check all columns if not specified
  }
  rows <- !complete.cases(data[, cols])
  if(all(!rows)){
    cli::cli_alert_success(sprintf("No %s found in selected cols!", cli::col_red("NA")))
  }else{
    if(subset){
      subset(data, rows)
    }else{
      which(rows)
    }
  }
}

#' closest_number
#' @description Find the closest number in a vector given
#' a target number
#' @param vector numeric
#' @param target numeric
#'
#' @return numeric
#' @export
#'
#'
closest_number <- function(vector, target){
  index <- which.min(abs(vector - target))
  out <- vector[index]
  return(out)
}


#' cinorm
#'
#' @param x a vector
#' @param se the standard error
#' @param avg the mean
#' @param interval the desired interval
#'
#' @return the upper and lower CI bound
#' @export
#'
cinorm <- function(x = NULL, se = NULL, avg = NULL, interval = 0.95){
  if(is.null(se)){
    se <- sd(x) / sqrt(length(x))
  }
  if(is.null(avg)){
    avg = mean(x)
  }
  upper <- interval + (1 - interval) / 2
  lower <- 1 - upper
  names_ci <- sprintf("%s_%s", c("lower", "upper"), interval*100)
  ci <- qnorm(c(lower, upper), avg, se)
  names(ci) <- names_ci
  return(ci)
}

#' named_list
#'
#' @param ... comma separated R objects
#' @description Create a named list with input objects directly using the object name of the global environment
#' @return a named list
#' @export
#'
named_list <- function(...){
  input_values <- list(...)
  input_names <- as.character(substitute(...()))
  if(is.null(names(input_values))){
    names(input_values) <- rep("", length(input_values))
  }
  input_names <- ifelse(names(input_values) == "",
                        input_names,
                        names(input_values))
  names(input_values) <- input_names
  return(input_values)
}

