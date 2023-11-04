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
  lines <- readLines(file, warn = FALSE)
  # removing yaml
  yaml <- grep("^---$", lines)
  lines <- lines[-c(1:29)]
  lines <- paste(lines, collapse = "")

  regex <- "(?<=@)([a-zA-Z0-9-]+)(?=|,|;)"
  matches <- regmatches(lines, gregexpr(regex, lines, perl = TRUE))
  matches <- unique(unlist(matches))

  # exclude crossrefs
  crefs <- c("fig-", "tbl-", "eq-", "sec-", "thm-", "lem-", "cor-", "prp-", "cnj-", "def-", "exm-", "exr-")
  matches[!grepl(paste0(crefs, collapse = "|"), matches)]
}

#' write_bib_rmd
#'
#' @param file character that indicate the input file
#' @param input_bib character that indicate the input \code{.bib} file
#' @param output_bib character that indicate the output \code{.bib} file
#' @param get_file logical should the raw file be invisibly returned
#' @return the bibfile
#' @export
#' @importFrom knitr current_input
#' @importFrom cli cli_alert_success
#'
write_bib_rmd <- function(file = knitr::current_input(), input_bib, output_bib, get_file = FALSE){
  bib_entries <- get_bib_entries(file)
  bib_entries_rx <- paste0(bib_entries, collapse = "|") # collapse patterns
  # Thanks to https://stackoverflow.com/a/68221000
  if(is_valid_url(input_bib)){
    tempbib <- tempfile(fileext = ".bib")
    download.file(input_bib, tempbib, quiet = TRUE)
  }else{
    tempbib <- input_bib
  }
  bibfile <- paste(readLines(tempbib), collapse = "\n")
  bibfile <- unlist(strsplit(bibfile, "@"))
  bibfile_sub <- bibfile[grepl(bib_entries_rx, bibfile)]
  bibfile_sub <- gsub("\n\n", "\n", bibfile_sub) # removing double \n
  bibfile_sub <- paste0("@", bibfile_sub)
  nbib <- length(bibfile_sub)
  writeLines(bibfile_sub, output_bib)
  msg <- sprintf("%s with %s entries created!", output_bib, nbib)
  cli::cli_alert_success(msg)
  if(get_file){
    invisible(bibfile_sub)
  }else{
    invisible(output_bib)
  }
}

#' show_file
#'
#' @param file string that indicate the path and filename
#' @param how if bare, the file is printed as it is. With generic the file is embedded into backticks.
#' If code, the file is embedded with backticks and an engine. If not specified the default engine is R.
#' @return Invisibly return the file lines and print the content
#' @export
#'
#'
show_file <- function(file,
                      how = c("bare", "generic", "code"),
                      engine = NULL){
  how <- match.arg(how)
  lines <- suppressWarnings(readLines(file))
  if(how == "generic"){
    cat("```", lines, "```", sep = "\n")
  }else if(how == "code"){
    if(is.null(engine)) engine <- "r"
    cat(paste0("```", engine), lines, "```", sep = "\n")
  }else{
    cat(lines, sep = "\n")
  }
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
#' Extract functions from .R files as text, creating a named list.
#'
#' @param file one or multiple .R files as character vector from which extracting function
#'
#' @return a named list with function
#' @export
#'
get_funs <- function(files){
  funs <- lapply(files, function(file){
    file <- suppressWarnings(readLines(file))
    cutpoints <- grep("^\\S*\\s*<-\\s*function", file)
    cutpoints[length(cutpoints) + 1] <- length(file)
    out <- vector(mode = "list", length = length(cutpoints)-1)
    fun_names <- vector(mode = "character", length = length(cutpoints)-1)
    if(length(file) != 0){
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
  })
  unlist(funs, recursive = FALSE)
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

#' remove_revision
#'
#' @param file the input file
#' @param out the output file name. Default to \code{NULL}
#'
#' @export
#'
remove_revision <- function(file, out = NULL){
  lines <- suppressWarnings(readLines(file))
  lines <- gsub("\\\\brev[ ]{0,1}", "", lines)
  lines <- gsub("[ ]{0,1}\\\\erev", "", lines)
  if(is.null(out)) out <- tools::file_path_sans_ext(file)
  out <- paste0(out, "_norev.", tools::file_ext(file))
  writeLines(lines, out)
  msg <- sprintf("All revision removed from %s! :)",
                 cli::col_green(basename(file)))
  cli::cli_alert_success(msg)
}

#' scount
#' @description
#' A safe counter useful for rmarkdown/quarto documents
#' @export
#'
scount <- function(){
  env <- new.env()
  env$n <- 0
  update_n <-
    rlang::new_function(
      args = NULL,
      body =
        rlang::expr({
          assign("n", n+1, envir = env)
          n
        }),
      env = env
    )
  update_n
}

#' rename_figs
#' @description
#' Knitr hook for creating a copy of figures named in progressive order (e.g., Figure 1) instead of the chunk label
#'
#' @param prefix character to be placed before the actual name. Default to "figure"
#'
#' @export
#'
rename_figs <- function(prefix = "figure"){
  nfig <- scount()
  function(x){
    filename <- sprintf("%s%s.%s", prefix, nfig(), tools::file_ext(x))
    x2 <- file.path(dirname(x), filename)
    if (file.copy(x, x2)) x2 else x
  }
}
