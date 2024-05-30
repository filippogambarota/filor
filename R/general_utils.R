#' find_pattern
#' @description return how many times a specific pattern occurs in any file of
#' the current directory and sub directories.
#' @param fun string or name with the pattern to search
#' @param which_files a character vector with file extensions to check.
#' @param dir starting directory from which an iterative search
#' is performed
#' @export
#'

find_pattern <- function(pattern, which_files = c("R", "Rmd"), dir = "."){

  which_files <- paste0(".", which_files, "$", collapse = "|")

  # Getting files
  files <- list.files(dir, which_files, full.names = TRUE, recursive = TRUE)
  files_content <- lapply(files, function(x) readLines(x, warn = FALSE))
  names(files_content) <- files

  # Counting times
  pattern_times <- sapply(files_content, function(x) sum(grepl(pattern, x)))
  files_content <- files_content[pattern_times > 0]
  pattern_times <- pattern_times[pattern_times > 0]

  # Formatting
  if(length(pattern_times) > 0){
    out <- paste(names(files_content), "---", pattern_times, "times")
    out_cli <- ifelse(grepl("R/", out), cli::col_blue(out), out) # Different for R/ files
    msg <- lapply(out_cli, cli::cli_alert_success)
  }else{
    cli::cli_alert_info(paste("No files with", cli::col_green(pattern)))
  }
}

#' success
#' @description fancy success message
#' @param msg string with the message
#' @importFrom cli cli_alert_success
success <- function(msg){
  cli::cli_alert_success(msg)
}

#' pb
#' @description Display a progress bar to use within a \code{for} loop
#' @param niter Integer that indicate the total number of iterations
#' @param index Integer that indicate the current iteration
#'
#' @export
#'
pb <- function(niter, index){
  step <- niter/10
  if(i %% step == 0){
    pr <- paste0(rep("----", index/step), collapse = "")
    cat("\r", paste0(index/step * 10, "% "), pr, sep = "")
    utils::flush.console()
    if(index/step == 10){
      cat(" ")
      cli::cli_alert_success("")
    }
  }
}

#' conditional
#' @description Function to create a wrapper version of the input function
#' that run according to a logical condition. Useful for conditional pipelines.
#' see https://community.rstudio.com/t/conditional-pipelines/6076/2
#' @param fun function
#'
#' @export
#'
conditional <- function(fun){
  function(..., execute) {
    if (execute) fun(...) else ..1
  }
}

#' gh_down_link
#' @description create a download/view link for a github file from url
#' @param x character with the github link
#' @param url_name character with the url name for the hyperlink
#' @param print_url logical
#'
#' @export
#'
gh_down_link <- function(x, hyperlink = FALSE, url_name = NULL){
  xs <- gsub("https://github.com/", "", x)
  xsl <- unlist(strsplit(xs, "/"))
  file <- xsl[(which(xsl %in% c("master", "main")) + 1):length(xsl)]
  file <- paste0(file, collapse = "/")
  url <- sprintf("https://%s.github.io/%s/%s", xsl[1], xsl[2], file)
  if(hyperlink){
    if(!is.null(url_name)){
      url <- sprintf("[%s](%s)", url_name, url)
    }else{
      url <- sprintf("[%s](%s)", url, url)
    }
  }
  return(url)
}

#' all_same
#' @description
#' Check if all values in a vector are the same. It is robust also to NA values
#' that can be handled with the \code{na.rm} parameter
#'
#' @param x a vector
#' @param na.rm logical indicating whether \code{NA} values should be removed or not.
#'
#' @return logical vector
#' @export
#'
#' @examples
#' all_same(c(1,1,1))  # TRUE
#' all_same(c(1,2,3))  # FALSE
#' all_same(c(1,1,NA)) # FALSE
#' all_same(c(1,1,NA), na.rm = TRUE) # TRUE
all_same <- function(x, na.rm = FALSE){
  if(na.rm){
    x <- x[!is.na(x)]
  }
  length(unique(x)) == 1
}


#' is_valid_url
#' @description
#' Check if a string is a valid url. Thanks to https://stackoverflow.com/a/73952264/9032257
#'
#' @param string
#'
#' @return logical
#' @export
#'
is_valid_url <- function(string) {
  pattern <- "^www\\.|^https:\\/\\/"
  grepl(pattern, string)
}

#' Create a badge of OSF
#'
#' @param link
#'
#' @return the link to be used
#' @export
#'
osf_badge <- function(link){
  sprintf("https://img.shields.io/badge/OSF-%s-337AB7", link)
}


#' try_seed
#' @description
#' Repeat an R expression a certain number of times with a random seed. Each iteration is self-paced by pressing a key. The random seed is printed along with the result of the
#' @param expr an R expression
#' @param maxrun the maximum number of iterations
#' @param digits the number of digits for the random seed
#' @export
#'
try_seed <- function(expr, maxrun = 100, digits = 4) {
  expr <- substitute(expr)
  min_seed <- (10^(digits - 1))
  max_seed <- (10^(digits)) - 1
  for (i in 1:maxrun) {
    seed <- round(runif(1, min_seed, max_seed))
    set.seed(seed)
    eval(expr, envir = parent.frame())
    readline(sprintf("seed = %s, Press space to continue!", seed))
  }
}
