#'@description
#'read rda file as rds giving a name
#'
read_rda <- function(x){
  env <- new.env()
  load(x, envir = env)
  get(ls(env), envir = env)
}

cut_between <- function(x, min = NULL, max = NULL) {
  if (!is.null(min)) {
    x[x < min] <- min
  }

  if (!is.null(max)) {
    x[x > max] <- max
  }
  return(x)
}

# print model equation with generic or actual values
# thanks to https://stats.stackexchange.com/a/433060 for the
# equation part. I've added the printing and prediction

model_equation <- function(model, values = NULL, ..., only_print = FALSE) {
  format_args <- list(...)
  model_coeff <- model$coefficients
  model_coeff <- round(model_coeff, 3)
  format_args$x <- abs(model_coeff)
  model_coeff_sign <- sign(model_coeff)
  model_coeff_prefix <- dplyr::case_when(
    model_coeff_sign == -1 ~ " - ",
    model_coeff_sign == 1 ~ " + ",
    model_coeff_sign == 0 ~ " + "
  )
  nms <- names(model_coeff[-1])
  # check if there are values to print
  if (!is.null(values)) {
    # check if there are too much values to print
    if (length(values[[1]]) > 3) {
      # formatting
      values <- lapply(values, function(x) {
        sprintf("[%s ... %s]", x[1], x[length(x)])
      })
    }

    nms <- purrr::reduce2(
      names(values),
      as.character(values),
      .init = nms,
      stringr::str_replace
    )
  }

  y <- strsplit(as.character(model$call$formula), "~")[[2]]
  b0 <- paste0(
    ifelse(model_coeff[1] < 0, "-", ""),
    do.call(base::format, format_args)[1]
  )
  bs <- paste0(
    model_coeff_prefix[-1],
    do.call(base::format, format_args)[-1],
    "*",
    cli::col_blue(nms),
    sep = "",
    collapse = ""
  )

  model_eqn <- sprintf("%s ~ %s%s", cli::col_green(y), b0, bs)
  cat(model_eqn)
  if (!only_print) {
    invisible(model_eqn)
  }
}