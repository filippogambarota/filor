#' find_pattern
#' @description return how many times a specific pattern occurs in any file of
#' the current directory and sub directories.
#' @param fun string or name with the pattern to search
#' @param which_files a character vector with file extensions to check.
#' @param dir starting directory from which an iterative search
#' is performed
#' @export
#'

find_pattern <- function(pattern, which_files = c("R", "Rmd"), dir = ".") {
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
  if (length(pattern_times) > 0) {
    out <- paste(names(files_content), "---", pattern_times, "times")
    out_cli <- ifelse(grepl("R/", out), cli::col_blue(out), out) # Different for R/ files
    msg <- lapply(out_cli, cli::cli_alert_success)
  } else {
    cli::cli_alert_info(paste("No files with", cli::col_green(pattern)))
  }
}

#' success
#' @description fancy success message
#' @param msg string with the message
#' @importFrom cli cli_alert_success
success <- function(msg) {
  cli::cli_alert_success(msg)
}

#' pb
#' @description Display a progress bar to use within a \code{for} loop
#' @param niter Integer that indicate the total number of iterations
#' @param index Integer that indicate the current iteration
#' @param width Maximum width of the console output
#' @export
#'

pb <- function(index, niter, width = 40) {
  if (!is.numeric(index) || !is.numeric(niter)) {
    stop("`index` and `niter` must be numeric.")
  }

  if (length(index) != 1 || length(niter) != 1) {
    stop("`index` and `niter` must be scalar values.")
  }

  if (is.na(index) || is.na(niter) || niter <= 0) {
    stop("`niter` must be a positive number and `index` must not be NA.")
  }

  index <- max(0, min(index, niter))
  progress <- index / niter

  percent <- floor(progress * 100)
  filled <- round(width * progress)
  empty <- width - filled

  bar <- paste0(
    "[",
    paste0(rep("=", filled), collapse = ""),
    paste0(rep(" ", empty), collapse = ""),
    "]"
  )

  cat(sprintf("\r%3d%% %s", percent, bar))
  utils::flush.console()

  if (index >= niter) {
    cat("\n")
  }

  invisible(progress)
}

#' gh_down_link
#' @description create a download/view link for a github file from url
#' @param x character with the github link
#' @param url_name character with the url name for the hyperlink
#' @param print_url logical
#'
#' @export
#'
gh_down_link <- function(x, hyperlink = FALSE, url_name = NULL) {
  xs <- gsub("https://github.com/", "", x)
  xsl <- unlist(strsplit(xs, "/"))
  file <- xsl[(which(xsl %in% c("master", "main")) + 1):length(xsl)]
  file <- paste0(file, collapse = "/")
  url <- sprintf("https://%s.github.io/%s/%s", xsl[1], xsl[2], file)
  if (hyperlink) {
    if (!is.null(url_name)) {
      url <- sprintf("[%s](%s)", url_name, url)
    } else {
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
all_same <- function(x, na.rm = FALSE) {
  if (na.rm) {
    x <- x[!is.na(x)]
  }
  length(unique(x)) == 1
}


#' is_valid_url
#' @description
#' Check if a string is a valid url. Thanks to https://stackoverflow.com/a/73952264/9032257
#'
#' @param string url
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
#' @param link url
#'
#' @return the link to be used
#' @export
#'
osf_badge <- function(link) {
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

#' Filter a List by Class
#'
#' Filters a list, keeping or excluding elements based on their class.
#'
#' @param x A list of R objects.
#' @param classes A character string specifying the class to filter by.
#' @param not Logical; if `TRUE`, elements *not* inheriting from `class` are kept. Default is `FALSE`.
#'
#' @return A list containing the elements of `x` that (do not) inherit from the specified class.
#'
#' @examples
#' lst <- list(1L, "text", 3.14, list(a = 1))
#' cfilter(lst, "numeric")  # returns elements that are numeric
#' cfilter(lst, "character")  # returns character elements
#' cfilter(lst, "numeric", not = TRUE)  # returns elements that are NOT numeric
#'
#' @export
cfilter <- function(x, classes, not = FALSE) {
  keep <- vapply(
    x,
    function(e) any(vapply(classes, inherits, logical(1), what = e)),
    logical(1)
  )

  if (not) {
    keep <- !keep
  }

  x[keep]
}
#' sourceR
#' @description
#' Load one or more R functions from R/ folder (or any custom folder)
#'
#' @param files files to source. Default to NULL (i.e., all files)
#' @param path path with .R files. Default to "R/" as in standard package-like projects.
#'
#' @export
#'
sourceR <- function(files = NULL, path = "R") {
  rfiles <- list.files(
    path,
    pattern = "\\.[Rr]$",
    full.names = TRUE
  )

  if (!is.null(files)) {
    rfiles <- rfiles[basename(rfiles) %in% files]
  }

  for (r in rfiles) {
    source(r, echo = FALSE)
  }

  invisible(rfiles)
}

#' trim
#' @description
#' Cut a numeric vector between min and max. Values lower than min or higher than max are substituted with the provided values.
#'
#' @param x the numeric vector
#' @param min the minimum value. Default to `NULL`. If `NULL`, the lower bound is not modified.
#' @param max the maximum value. Default to `NULL`. If `NULL`, the upper bound is not modified.
#'
#' @export
#' @examples
#' x <- runif(20, 0, 20)
#' trim(x, min = 5, max = 10)
#' trim(x, max = 10)
#' trim(x, min = 5)
trim <- function(x, min = NULL, max = NULL) {
  if (!is.numeric(x)) {
    warning("x is not numeric: returning NA")
    rep(NA, length(x))
  } else {
    if (!is.null(min)) {
      x[x < min] <- min
    }

    if (!is.null(max)) {
      x[x > max] <- max
    }
    x
  }
}

#' create_R_env
#' @description
#' Create an ".Renviron" file if not exists and optionally opens it.
#'
#' @param open logical indicating if opening the file interactively
#'
#' @export
#'
create_R_env <- function(open = TRUE) {
  if (!file.exists(".Renviron")) {
    file.create(".Renviron")
  }
  if(open) utils::file.edit(".Renviron")
}

#' read_R_env
#' @description
#' Read an .Renviron file returning a named vector in the format key=value
#'
#' @returns a named vector
#' @export
#'
read_R_env <- function(){
  parts <- strsplit(readLines(".Renviron"), "=", fixed = TRUE)
  setNames(
    vapply(parts, `[`, "", 2),
    vapply(parts, `[`, "", 1)
  )
}

#' edit_R_env
#' @description
#' Edit an .Renviron file providing a named vector in the form key=value.
#' Existing keys will be overwritten and new keys will be added.
#'
#' @param x a named vector
#'
#' @export
#'
edit_R_env <- function(x) {
  if (!file.exists(".Renviron")) {
    create_R_env(open = FALSE)
  }
  current_x <- read_R_env()
  current_x[names(x)] <- x
  keyval <- sprintf("%s=%s", names(current_x), current_x)
  writeLines(keyval, con = ".Renviron")
}

#' Create and copy a minimal reproducible example (reprex)
#'
#' This helper function prints both the expression and its evaluated output
#' in a tidyverse-style format, prefixing output lines with a comment marker
#' (e.g. `#>`). The formatted text is also copied to the clipboard for easy
#' pasting into issues, documents, or chat.
#'
#' @param expr An R expression or block of expressions surrounded by `{}`.
#'   The expressions are deparsed and evaluated sequentially.
#' @param comment A string used to prefix each output line. Defaults to `"#>"`.
#'
#' @details
#' - Leading indentation is stripped for readability.
#' - The outer `{}` of a block are removed before printing.
#' - Vector output markers like `[1]` are removed.
#' - The result (both code and output) is copied to the clipboard
#'   using the **clipr** package if available.
#'
#' @return
#' Invisibly returns `NULL`. The side effects are printed and copied text.
#'
#' @examples
#' \dontrun{
#' reprex({
#'   x <- 1:5
#'   mean(x)
#' })
#'
#' reprex(mean(1:5))
#' }
#'
#' @export
reprex <- function(expr, comment = "#>"){

  # Capture the raw expression
  expr_raw <- substitute(expr)

  # If it's a block (wrapped in {}), remove the outer braces
  if (is.call(expr_raw) && identical(expr_raw[[1]], as.name("{"))) {
    exprs <- as.list(expr_raw)[-1]
  } else {
    exprs <- list(expr_raw)
  }

  # Deparse each subexpression, removing leading spaces
  texpr <- unlist(lapply(exprs, function(e) trimws(deparse(e), which = "left")))

  # printing the expression
  writeLines(texpr)
  cat("\n")

  # evaluating and capturing
  out <- capture.output(eval(expr))
  out <- gsub("^\\[\\d+\\]\\s*", "", out)
  out <- paste(comment, out)
  writeLines(out)

  # to clip
  clipr::write_clip(c(texpr, out))
}

#' Select Line Indices Based on Numeric Positions or Regex Delimiters
#'
#' Computes a vector of line indices either directly from numeric input
#' or by identifying a contiguous block of lines delimited by regular
#' expression matches.
#'
#' If \code{lines} is numeric, it is returned as-is. If \code{lines} is a
#' character string, it must be a single regex of the form
#' \code{"start|end"}, where \code{start} and \code{end} are regular
#' expressions matched against \code{x}. The returned indices span from
#' the first match of \code{start} to the first match of \code{end}
#' (inclusive). If only one regex is provided, it is used for both start
#' and end.
#'
#' @param x A character vector, typically representing lines of text.
#' @param lines Either:
#' \itemize{
#'   \item A numeric vector of line indices, or
#'   \item A character vector of length 1 specifying regex delimiters
#'         in the form \code{"start|end"}.
#' }
#'
#' @return A numeric vector of line indices.
#'
#' @details
#' When \code{lines} is \code{NULL}, the function currently returns
#' \code{1:length(lines)}, which evaluates to an empty integer vector.
#'
#' @examples
#' txt <- c("alpha", "start", "beta", "gamma", "end", "delta")
#'
#' .grep_lines(txt, c(2, 3, 4))
#' .grep_lines(txt, "start|end")
#' .grep_lines(txt, "beta")
#'
#' @export
.grep_lines <- function(x, lines = NULL){
  if(is.null(lines)) lines <- seq_along(x)
  if (!is.numeric(lines)) {
    if (length(lines) != 1) {
      stop(
        "When lines is not a numeric vector, need to be a character vector of length 1 with regex 'start|end'!"
      )
    }

    rr <- unlist(strsplit(lines, split = "\\|"))
    if(length(rr) == 1){
      rr <- c(rr, rr)
    }
    lines <- grep(rr[1], x):grep(rr[2], x)
  }
  return(lines)
}

#' Conditionally apply a function to elements of a list or columns of a data frame
#'
#' Applies `FUN` to each element of `x` for which `condition` returns `TRUE`;
#' otherwise leaves the element unchanged.
#'
#' If `x` is a data frame, the result is returned as a data frame. If `x` is a
#' list (and not a data frame), the result is returned as a list. Names are
#' preserved.
#'
#' @param x A list or a data frame.
#' @param condition A predicate function applied to each element/column. Must
#'   return a single `TRUE` to trigger the transformation; any other value (e.g.,
#'   `FALSE`, `NA`, non-scalar) leaves the element unchanged.
#' @param FUN A function to apply to elements/columns that satisfy `condition`.
#' @param ... Additional arguments passed to `FUN`.
#'
#' @return A data frame if `x` is a data frame; otherwise a list.
#'
#' @examples
#' # Round numeric columns in a data frame
#' capply(iris, is.numeric, round, 2)
#'
#' # Apply to a list: uppercase only character elements
#' x <- list(a = 1:3, b = "hello", c = TRUE)
#' capply(x, is.character, toupper)
#'
#' @export
#'
capply <- function(x, condition, FUN, ...) {
  stopifnot(is.function(condition), is.function(FUN))

  out <- x

  for (i in seq_along(x)) {
    if (isTRUE(condition(x[[i]]))) {
      out[[i]] <- FUN(x[[i]], ...)
    }
  }

  out
}

#' Round numeric columns in a data frame
#'
#' Rounds numeric columns of `x` using [base::round()] while leaving other
#' columns unchanged. Intended as an explicit alternative to registering an S3
#' method for `round.data.frame`.
#'
#' @param x A data frame (or list-like object accepted by `capply()`).
#' @param digits Integer indicating the number of decimal places to round to.
#'   Defaults to `getOption("digits")`.
#' @param ... Further arguments passed to [base::round()].
#'
#' @return An object of the same type as returned by `capply()` (typically a data
#'   frame when `x` is a data frame).
#'
#' @examples
#' dround(iris, 2)
#'
#' @export

dround <- function(x, digits = getOption("digits"), ...) {
  capply(x, is.numeric, round, digits = digits, ...)
}

#' Simple or Stratified Random Sampling
#'
#' @description
#' Draws a random sample of rows from a data frame. Sampling can be performed
#' globally across the whole data set or separately within groups defined by one
#' or more columns.
#'
#' @param data A \code{data.frame} from which rows are sampled.
#' @param n A non-negative integer giving the number of rows to sample from each
#'   group. If a group contains fewer than \code{n} rows, all rows in that group
#'   are returned. Defaults to \code{1}.
#' @param by A character vector specifying the grouping columns, for example
#'   \code{"group"} or \code{c("group1", "group2")}. If \code{NULL}, sampling is
#'   performed over the entire data frame. Defaults to \code{NULL}.
#'
#' @return
#' A \code{data.frame} containing the sampled rows, with row names reset.
#'
#' @details
#' When \code{by = NULL}, the function samples up to \code{n} rows from the full
#' data frame. When \code{by} is supplied, the data are split by the selected
#' grouping columns and up to \code{n} rows are sampled independently from each
#' group.
#'
#' If a group contains fewer than \code{n} rows, all rows from that group are
#' returned. The function does not set a random seed; use \code{\link{set.seed}}
#' before calling it if reproducible sampling is required.
#'
#' @examples
#' # Sample 2 rows from the full iris data set
#' sample_by_group(iris, n = 2)
#'
#' # Sample 1 row per Species
#' sample_by_group(iris, n = 1, by = "Species")
#'
#' # Sample 2 rows per combination of cyl and am
#' sample_by_group(mtcars, n = 2, by = c("cyl", "am"))
#'
#' # Reproducible sampling
#' set.seed(123)
#' sample_by_group(iris, n = 1, by = "Species")
#'
#' @export
sample_by_group <- function(data, n = 1, by = NULL) {
  if (!is.data.frame(data)) {
    stop("'data' must be a data.frame.", call. = FALSE)
  }

  if (length(n) != 1L || is.na(n) || n < 0 || n != floor(n)) {
    stop("'n' must be a single non-negative integer.", call. = FALSE)
  }

  if (!is.null(by)) {
    if (!is.character(by)) {
      stop("'by' must be NULL or a character vector of column names.", call. = FALSE)
    }

    missing_cols <- setdiff(by, names(data))
    if (length(missing_cols) > 0L) {
      stop(
        "The following columns in 'by' are not in 'data': ",
        paste(missing_cols, collapse = ", "),
        call. = FALSE
      )
    }
  }

  if (nrow(data) == 0L || n == 0L) {
    out <- data[0L, , drop = FALSE]
    rownames(out) <- NULL
    return(out)
  }

  if (is.null(by)) {
    idx <- sample(seq_len(nrow(data)), size = min(n, nrow(data)))
    out <- data[idx, , drop = FALSE]
  } else {
    groups <- split(data, data[by], drop = TRUE)

    out_list <- lapply(groups, function(x) {
      nr <- nrow(x)
      idx <- sample(seq_len(nr), size = min(n, nr))
      x[idx, , drop = FALSE]
    })

    if (length(out_list) == 0L) {
      out <- data[0L, , drop = FALSE]
    } else {
      out <- do.call(rbind, out_list)
    }
  }

  rownames(out) <- NULL
  out
}

#' Generate a sequence over the range of a numeric vector
#'
#' Creates a sequence from the minimum to the maximum of `x`, using either
#' a step size (`by`) or a desired number of points (`length.out`).
#'
#' @param x A numeric vector.
#' @param by A numeric increment for the sequence. Mutually exclusive with
#'   `length.out`.
#' @param length.out Desired length of the output sequence. Mutually exclusive
#'   with `by`.
#' @param na.rm Logical. Should missing values be removed before computing
#'   the range? Default is `FALSE`.
#'
#' @return A numeric vector containing a sequence from `min(x)` to `max(x)`.
#'
#' @details
#' Exactly one between `by` and `length.out` must be supplied.
#'
#' If `na.rm = FALSE` and `x` contains missing values, the function may fail
#' because `min(x)` and `max(x)` return `NA`.
#'
#' @examples
#' x <- c(3.2, 7.8, 5.1, 9.4)
#'
#' seq_range(x, by = 1)
#' seq_range(x, length.out = 5)
#'
#' x2 <- c(1, 4, NA, 10)
#' seq_range(x2, length.out = 4, na.rm = TRUE)
#'
#' @export
seq_range <- function(x, by = NULL, length.out = NULL, na.rm = FALSE) {
  if (is.null(by) && is.null(length.out)) {
    stop("Either 'by' or 'length.out' must be provided.")
  }

  if (!is.null(by) && !is.null(length.out)) {
    stop("Only one of 'by' or 'length.out' can be provided.")
  }

  if (!is.numeric(x)) {
    stop("'x' must be a numeric vector.")
  }

  if (length(x) == 0) {
    stop("'x' must not be empty.")
  }

  min_x <- min(x, na.rm = na.rm)
  max_x <- max(x, na.rm = na.rm)

  if (!is.finite(min_x) || !is.finite(max_x)) {
    stop("Could not compute a finite range from 'x'.")
  }

  if (!is.null(by)) {
    seq(min_x, max_x, by = by)
  } else {
    seq(min_x, max_x, length.out = length.out)
  }
}
