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

word_count <- function(file){
  file <- readLines("notes.md")

  p_start <- "#WC-START"
  p_end <- "#WC-END"

  # remove empty lines
  file <- file[!grepl("^\\s*$", file)]

  start <- grep(p_start, file)
  end <- grep(p_end, file)

  if(length(start) == 0 | length(end) == 0){
    parts <- mapply(function(s, e) file[s:e], start, end)
    parts <- lapply(parts, function(p) p[!(grepl(p_start, p) | grepl(p_end, p))])
  }else{
    parts <- list(file)
  }

  parts <- lapply(parts, function(x) paste0(x, collapse = " "))

  nwords <- sapply(parts, function(x) lengths(strsplit(x, ' ')))
  nchars <- sapply(parts, function(x) nchar(x))
  nchars_nows <- sapply(parts, function(x) nchar(gsub(" ", "", x)))

  out <- lapply(1:length(parts), function(i) list(nwords = nwords[i], nchars = nchars[i], nchars_nows = nchars_nows[i]))
  out$total$nwords <- sum(nwords)
  out$total$nchars <- sum(nchars)
  out$total$nchars_nows <- sum(nchars_nows)
  out <- out[c(length(out), (1:(length(out) - 1)))]

  for(i in 1:length(out)){
    if(i == 1){
      cat("######", "Total", "\n\n")
    } else{
      cat("######", "Section", i, "\n\n")
    }
    cat("Number of Words:", out[[i]]$nwords, "\n")
    cat("Number of Characters:", out[[i]]$nchars, "\n")
    cat("Number of Characters (no white spaces)", out[[i]]$nchars_nows, "\n\n")
  }

  invisible(out)
}

chd <- function(x, l = 1, toclip = TRUE, max = 75){
  hash <- paste0(rep("#", l), collapse = "")
  sep <- paste0(rep("-", max - (nchar(hash) + 2) - nchar(x)), collapse = "")
  res <- sprintf("%s %s %s", hash, x, sep)
  if(toclip){
    clipr::write_clip(res)
  }
  cat(res)
}

#' Calculate Standard Error (SE) associated with a desired level of statistical power
#' @description Calculate the Standard Error (SE) that is associated with a given power and a given alpha level for a given value of a model parameter B
#' @param B The model parameter B (practically, the effect size)
#' @param power The desired level of statistical power
#' @param alpha The alpha level (rate of type I errors)
#' @param alternative Whether the statistical test is two sided or one sided. Must be one of "two.sided" (default) or "one.sided"
#'
#' @return The numerical value of the Standard Error (SE) associated with the above arguments
#' @export
SE4power = function(b = NA, power = 0.80, alpha = 0.05, alternative = "two.sided"){
  alternative <- match.arg(alternative, choices = c("two.sided","one.sided"))
  if(alternative == "two.sided") {
    alpha <- alpha/2
  }
  SE <- abs(b) / (qnorm(1 - alpha) + qnorm(power))
  return(SE)
}
