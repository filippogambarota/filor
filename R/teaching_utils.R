#' add_random_na
#' @description put random NA values within a dataframe for teaching and
#' testing purposes.
#' @param data a dataframe
#' @param n number of NA values to insert
#' @param exclude_cols string or vector of strings with column to exclude
#' from NA filling
#' @return a dataframe with random NA
#' @export
#'
add_random_na <- function(data, n, exclude_cols = NULL){

  if(!is.null(exclude_cols)){
    data_s <- subset(data, select = !names(data) %in% exclude_cols)
  }else{
    data_s <- data
  }

  pos <- list(rows = 1:nrow(data_s),
              cols = 1:ncol(data_s))

  pos <- expand.grid(pos)

  na_pos <- sample(1:nrow(pos), n)

  for (i in 1:length(na_pos)) {

    na_pos_i <- pos[na_pos[i], ]

    data_s[na_pos_i[[1]], na_pos_i[[2]]] <- NA

  }

  data_s <- cbind(data_s, data[exclude_cols]) # combine
  data_s <- data_s[names(data)] # correct order

  return(data_s)

}

#' Plot the result of a pnorm function call
#'
#' @name ggnorm
#' @description Plot the result of the \code{pnorm} function. The syntax is the same as the \code{pnorm} function.
#' @param q numeric; The quantile to evaluate the \code{pnorm}
#' @param mean numeric; The mean of the normal distribution
#' @param sd numeric; The standard deviation of the normal distribution
#' @param lower.tail logical; if TRUE (default), probabilities are \eqn{P[X \le x]} otherwise, \eqn{P[X > x]}.
#' @import ggplot2
#' @return ggplot object
#' @export
#' @examples
#' ggnorm(0.5, 0, 1, lower.tail = TRUE)
#'
ggnorm <- function(q = NULL, mean = 0, sd = 1, lower.tail = TRUE, within = TRUE){

  # draw base plot
  plt <- ggplot(data.frame(x = c(mean - 4*sd, mean + 4*sd)), aes(x)) +
    stat_function(fun = dnorm, args = list(mean = mean,
                                           sd = sd),
                  size = 1) +
    theme_minimal(base_size = 20) +
    theme(plot.title = element_text(size = 15),
          panel.grid.major = element_blank()) +
    ylab("dnorm(x)") +
    xlab("x")

  # distribution parameters
  basetitle <- sprintf("\U03BC = %s, \U03C3 = %s", mean, sd)

  # mean sd annotation
  mean_sd_annotation <- annotate(geom = "label",
                                 x = mean + sd*3,
                                 y = dnorm(mean, mean, sd),
                                 label = basetitle,
                                 fill = "white",
                                 size = 8,
                                 label.padding=unit(0.5, "lines"))

  if(!is.null(q)){

    if(length(q) == 1){

      if(lower.tail){
        side <- - 1
        pnorm_res <- sprintf("pnorm(q = %s, mean = %s, sd = %s, lower.tail = TRUE) = %.3f",
                             round(q, 2), mean, sd,
                             pnorm(q, mean, sd, lower.tail = lower.tail))
      }else{
        side <- 1
        pnorm_res <- sprintf("1 - pnorm(q = %s, mean = %s, sd = %s, lower.tail = TRUE) = %.3f",
                             round(q, 2), mean, sd,
                             pnorm(q, mean, sd, lower.tail = lower.tail))
      }

      plt <- plt +
        ggtitle(pnorm_res) +
        geom_segment(x = q, xend = q,
                     y = 0, yend = dnorm(q, mean, sd),
                     linetype = "dashed") +
        theme(axis.title.x = element_text(colour="red", face = "bold")) +
        theme(axis.title.y = element_text(colour="blue", face = "bold"))

      plt +
        stat_function(fun = dnorm, geom = "area", args = list(mean = mean,
                                                              sd = sd),
                      xlim = c(mean + (4 * side) * sd, q),
                      fill = "red", alpha = 0.3) +
        ggtitle(pnorm_res) +
        geom_point(x = q, y = 0, size = 5, col = "red") +
        geom_point(x = q, y = dnorm(q, mean, sd), size = 5, col = "blue") +
        mean_sd_annotation

    }else{
      # if two quantiles are given
      minq <- q[which.min(q)]
      maxq <- q[which.max(q)]

      plt <- plt +
        geom_segment(x = q, xend = q,
                     y = 0, yend = dnorm(q, mean, sd),
                     linetype = "dashed") +
        theme(axis.title.x = element_text(colour="red", face = "bold")) +
        theme(axis.title.y = element_text(colour="blue", face = "bold")) +
        geom_point(x = q, y = 0, size = 5, col = "red") +
        geom_point(x = q, y = dnorm(q, mean, sd), size = 5, col = "blue")

      if(within){
        pnorm_op <- pnorm(maxq, mean, sd, lower.tail = TRUE) -
          pnorm(minq, mean, sd, lower.tail = TRUE)

        pnorm_res <- sprintf("pnorm(%s, %s, %s, lower.tail = TRUE) - pnorm(%s, %s, %s, lower.tail = TRUE) = %s",
                             maxq, mean, sd,
                             minq, mean, sd,
                             round(pnorm_op, 3))
        plt +
          stat_function(fun = dnorm, geom = "area", args = list(mean = mean,
                                                                sd = sd),
                        xlim = c(minq, maxq), fill = "red", alpha = 0.3) +
          ggtitle(pnorm_res)  +
          mean_sd_annotation

      }else{
        pnorm_op <- pnorm(minq, mean, sd, lower.tail = TRUE) +
          pnorm(maxq, mean, sd, lower.tail = FALSE)

        pnorm_res <- sprintf("pnorm(%s, %s, %s, lower.tail = TRUE) + pnorm(%s, %s, %s, lower.tail = FALSE) = %s",
                             maxq, mean, sd,
                             minq, mean, sd,
                             round(pnorm_op, 3))
        plt +
          stat_function(fun = dnorm, geom = "area", args = list(mean = mean,
                                                                sd = sd),
                        xlim = c(mean - 4*sd, minq), fill = "red", alpha = 0.3) +
          stat_function(fun = dnorm, geom = "area", args = list(mean = mean,
                                                                sd = sd),
                        xlim = c(maxq, mean + 4*sd), fill = "red", alpha = 0.3) +
          ggtitle(pnorm_res) +
          mean_sd_annotation
      }
    }
  }else{
    plt +
      geom_segment(x = mean, xend = mean,
                   y = 0, yend = dnorm(mean, mean, sd),
                   linetype = "dashed") +
      mean_sd_annotation
  }
}

#' extract_pdf_pages
#'
#' @param file character with the pdf file
#' @param slides integer vector with pdf pages to extract
#' @param out character with the output file name. Default to NULL
#' @importFrom qpdf pdf_subset
#' @importFrom cli col_blue
#' @importFrom cli col_green
#' @importFrom cli cli_alert_success
#' @export
#'
extract_pdf_pages <- function(file, pages, out = NULL){
  basefile <- tools::file_path_sans_ext(basename(file))
  file_sans_ext <- tools::file_path_sans_ext(file)
  if(is.null(out)){
    out <- sprintf("%s_updating.pdf", file_sans_ext)
  }
  msg <- sprintf("Extracted from %s, from page %s to page %s!",
                 cli::col_blue(basefile),
                 cli::col_green(pages[1]),
                 cli::col_green(pages[length(pages)]))
  cli::cli_alert_success(msg)
  pdf <- qpdf::pdf_subset(file, pages = pages, output = out)
}

#' purl_here
#'
#' @param file character with the \code{.Rmd} file to purl
#' @param output character with the path and filename of the output file. Default to the \code{.Rdm} file path.
#' @importFrom knitr purl
#' @export
#'

purl_here <- function(file, output = NULL){
  if(is.null(output)){
    output <- gsub("Rmd", "R", file)
    knitr::purl(file, output = output, documentation = 2)
  }
}

#' trim_df
#'
#' @param data a dataframe
#' @param n number of rows to display before and after the dots
#'
#' @return a dataframe
#' @export
#'
trim_df <- function(data, n = 4, digits = 3){
  data <- lapply(data, function(x) if(is.factor(x)) as.character(x) else x)
  data <- data.frame(data)
  data <- data.frame(sapply(data, function(x) if(is.numeric(x)) round(x, digits) else x))
  dots <- data[1, ]
  dots[1, ] <- "..."
  nrows <- nrow(data)
  if(nrows <= 5){
    trimmed <- data
  } else{
    if(nrows <= n*2){
      n <- floor(n/2)
    }
    trimmed <- rbind(
      data[1:n,],
      dots,
      data[(nrows-(n - 1)):nrows, ]
    )
  }
  rownames(trimmed) <- NULL
  return(trimmed)
}
