#' leave1out
#'
#' @param data a dataframe
#' @param group_var name of the variable that identify each
#' observation to remove. If \code{NULL} will be removed one
#' dataframe line at time.
#' @return a named list of dataframes
#' @export
#'
leave1out <- function(data, group_var = NULL, keep_full = FALSE){

  if(!is.null(substitute(group_var))){
    group_var <- substitute(group_var)
    group_var_names <- data[[deparse(group_var)]]
    group_var_obj <- as.integer(as.factor(group_var_names))

  }else{
    group_var_obj <- 1:nrow(data) # remove row
    group_var_names <- as.character(group_var_obj)
  }

  # make expression to eval (exclude a level)
  out <- lapply(unique(group_var_obj), function(excl) subset(data, !group_var_obj %in% excl))
  names(out) <- paste0("no_", unique(group_var_names))

  if(keep_full){
    out <- c(list("all" = data), out)
  }

  return(out)
}

#' get_model_formula
#'
#' @param fit a model object
#'
#' @return A character with the model formula
#' @export
#'
get_model_formula <- function(fit){
  deparse(formula(fit))
}


# this is a wrapper of the predict function
# add prediction to a dataframe given a model
# extra arguments to predict are passed using ...
# it works well with pipes %>% or |>

add_predict <- function(data, fit, ...){
  pr <- stats::predict(fit, newdata = data, ...)
  cbind(data, data.frame(pr))
}

# print model equation with generic or actual values
# thanks to https://stats.stackexchange.com/a/433060 for the
# equation part. I've added the printing and prediction

#' model_equation
#' @description
#' print model equation with generic or actual values thanks to https://stats.stackexchange.com/a/433060 for the equation part. I've added the printing and prediction
#' @param model a fitted glm/lm object
#' @param newdata a list or dataframe with values where evaluate the prediction
#' @param ... additional arguments to \code{predict()}
#' @param only_print logical. TRUE if returning the equation as string
#' @importFrom purrr reduce2
#' @importFrom dplyr case_when
#' @importFrom cli col_blue
#' @importFrom cli col_green
#' @importFrom stringr str_replace
#' @export
#'
model_equation <- function(model, newdata = NULL, ..., only_print = FALSE) {
  format_args <- list(...)
  model_coeff <- model$coefficients
  model_coeff <- round(model_coeff, 3)
  format_args$x <- abs(model_coeff)
  model_coeff_sign <- sign(model_coeff)
  model_coeff_prefix <- dplyr::case_when(model_coeff_sign == -1 ~ " - ",
                                         model_coeff_sign == 1 ~ " + ",
                                         model_coeff_sign == 0 ~ " + ")
  nms <- names(model_coeff[-1])
  # check if there are values to print
  if(!is.null(newdata)){
    # check if there are too much values to print
    if(length(newdata[[1]]) > 3){
      # formatting
      newdata <- lapply(newdata, function(x) sprintf("[%s ... %s]", x[1], x[length(x)]))
    }

    nms <- purrr::reduce2(names(newdata),
                          as.character(newdata),
                          .init = nms,
                          stringr::str_replace)
  }


  y <- strsplit(as.character(model$call$formula), "~")[[2]]
  b0 <- paste0(ifelse(model_coeff[1] < 0, "-", ""), do.call(base::format, format_args)[1])
  bs <- paste0(model_coeff_prefix[-1],
               do.call(base::format, format_args)[-1],
               "*",
               cli::col_blue(nms),
               sep = "", collapse = "")

  model_eqn <- sprintf("%s ~ %s%s", cli::col_green(y), b0, bs)
  cat(model_eqn)
  if(!only_print){
    invisible(model_eqn)
  }
}

#' epredict
#' @description
#' improved predict function, it works as the standard predict function but prints the model equation that is supporting the current prediction
#'
#' @param model a fitted glm/lm object
#' @param newdata a list or dataframe with values where evaluate the prediction
#' @param ... additional arguments to \code{predict()}
#'
#' @export
#'
epredict <- function(model, newdata, ...){
  message(model_equation(model, newdata, only_print = TRUE))
  pr <- predict(model, newdata, ...)
  as.numeric(sapply(pr, unname))
}

#' odds
#'
#' @param p numeric vector with a probability
#'
#' @return the odds of the probability
#' @export
#'
odds <- function(p){
  p / (1 - p)
}

#' odds_ratio
#'
#' @param pn numeric the probability at the numerator
#' @param pd numeric the probability at the denominator
#'
#' @return the odds ratio
#' @export
#'
odds_ratio <- function(pn, pd){
  odds(pn) / odds(pd)
}
