#' get_rmd_comments
#'
#' @description Extract all comments from an \code{Rmd} file
#' @param file string indicating the file
#' @param exclude character vector with pattern to excluding some comments
#' @param write logical that indicate if returning a bullet list
#' for printing. Default to \code{TRUE}.
#' @export
#' @return list of comments
#'
get_rmd_comments <- function(file, exclude = c("#SETUP"), write = TRUE){
  exclude <- paste0(exclude, collapse = "|")
  file_lines <- readLines(file, warn = FALSE)
  file_lines <- paste0(file_lines, collapse = "")
  pattern <- "<!--\\s*(.*?)\\s*-->"
  regmatch <- gregexec(pattern,file_lines)
  comments <- regmatches(file_lines, regmatch)[[1]][2, ]
  comments <- comments[!grepl(exclude, comments)]
  if(write & length(comments) > 0){
    cat(paste("-", comments), sep = "\n")
  }
  invisible(comments)
}

#' get_bib_entries
#'
#' @param file character that indicate the input file. Default to
#' the current \code{.Rmd} file if not specified.
#'
#' @return character vector with all bibtex entry used in a document
#' @importFrom knitr current_input
#' @export
#'
get_bib_entries <- function(file = knitr::current_input()){
  lines <- paste(readLines(file, warn = FALSE), collapse = "")
  regex <- "(?<=@)([a-zA-Z0-9-]+)(?=\\]|,|;)"
  matches <- regmatches(lines, gregexpr(regex, lines, perl = TRUE))
  unique(unlist(matches))
}

#' write_bib_rmd
#'
#' @param file character that indicate the input file
#' @param input_bib character that indicate the input \code{.bib} file
#' @param output_bib character that indicate the output \code{.bib} file
#'
#' @return the bibfile
#' @export
#' @importFrom knitr current_input
#' @importFrom cli cli_alert_success
#'
write_bib_rmd <- function(file = knitr::current_input(), input_bib, output_bib){
  bib_entries <- get_bib_entries(file)
  bib_entries_rx <- paste0(bib_entries, collapse = "|") # collapse patterns
  # Thanks to https://stackoverflow.com/a/68221000
  bibfile <- paste(readLines(input_bib), collapse = "\n")
  bibfile <- unlist(strsplit(bibfile, "@"))
  bibfile_sub <- bibfile[grepl(bib_entries_rx, bibfile)]
  bibfile_sub <- gsub("\n\n", "\n", bibfile_sub) # removing double \n
  bibfile_sub <- paste0("@", bibfile_sub)
  nbib <- length(bibfile_sub)
  writeLines(bibfile_sub, output_bib)
  msg <- sprintf("%s with %s entries created!", output_bib, nbib)
  cli::cli_alert_success(msg)
  invisible(bibfile_sub)
}

#' disp_file
#'
#' @param file string that indicate the path and filename
#'
#' @return Invisibly return the file lines and print the content
#' @export
#'
#'
disp_file <- function(file){
  lines <- readLines(file)
  cat(lines, sep = "\n")
  invisible(lines)
}

#' get_caption
#' @description Match a reference within an R Markdown document using the chunk label
#'
#' @return The pandoc syntax for the cross-referencing
#' @export
#'
get_caption <- function() {
  chunk <- knitr::opts_current$get("label")
  sprintf("(ref:%s)", chunk)
}

#' cap_link
#' @description Format html code for an hyperlink
#' @param link character. The web address
#' @param text charactet. The text to be displayed. Default to \code{NULL} thus
#' the same as the \code{link}
#' @return The html code for the hyperlink
#' @export
#'
cap_link <- function(link, text = NULL){
  if (is.null(text)) {
    text <- link
  }
  sprintf('<a href="%s">%s</a>', link, text)
}


#' get_chunk_labels
#'
#' @param file the input rmd document
#' @param output the output text document. Default to NULL
#' @param as_captions logical. If the output should be formatted as captions
#'
#' @export
#' @import stringr
get_chunk_labels <- function(file, output = NULL, as_captions = FALSE){
  lines <- suppressWarnings(readLines(file))
  chunks <- lines[grepl("```\\{", lines)]
  chunks <- stringr::str_extract(chunks, regex("(?<=\\{r).+?(?=,)"))
  chunks <- gsub(" ", "", chunks)
  chunks <- chunks[!is.na(chunks)]
  if(!is.null(output)){
    if(as_captions){
      chunks <- sprintf("(ref:%s) Caption", chunks)
    }
    writeLines(chunks, output)
    invisible(chunks)
  }else{
    chunks
  }
}

#' get_funs
#' @description
#' Extract functions from an .R file as text, creating a named list.
#'
#' @param file an .R file from which extracting function
#'
#' @return a named list with function
#' @export
#'
get_funs <- function(file){
  file <- suppressWarnings(readLines(file))
  cutpoints <- grep("<- function", file)
  cutpoints[length(cutpoints) + 1] <- length(file)

  out <- vector(mode = "list", length = length(cutpoints)-1)
  fun_names <- vector(mode = "character", length = length(cutpoints)-1)

  for(i in 1:(length(cutpoints) - 1)){
    if(i == length(cutpoints) - 1){
      out[[i]] <- file[cutpoints[i]:(cutpoints[i + 1])]
    }else{
      out[[i]] <- file[cutpoints[i]:(cutpoints[i + 1] - 1)]
    }

    out[[i]] <- out[[i]][!grepl("#'", out[[i]])]
    endfun <- rev(grep("\\}", out[[i]]))[1]
    out[[i]] <- out[[i]][1:endfun]

    fun_names[i] <- stringr::str_extract(out[[i]][1], ".+?(?=<-)")
  }
  fun_names <- gsub(" ", "", fun_names)
  names(out) <- fun_names
  return(out)
}

#' print_fun
#'
#' @param fun a character resulting from the \code{get_funs} function
#'
#' @export
#'
print_fun <- function(fun){
  cat("```r", fun, "```", sep = "\n")
}
