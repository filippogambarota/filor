#' .download_sign
#'
#' @param path he googledrive path
#' @importFrom googledrive drive_download
#'
.download_sign <- function(path){
  #options(googledrive_quiet = TRUE)
  link <- "https://drive.google.com/file/d/17LR6SesbcayTWmmRH3oRsQjLYZZ-n-Nf/view?usp=sharing"
  path <- file.path(path, "signature.png")
  googledrive::drive_download(file = link, path = path)
}

#' Output formats for filor
#'
#' @param \dots Arguments passed to \code{pdf_document}.
#'
#' @return An R Markdown output format object.
#'
#' @importFrom rmarkdown pdf_document
#' @export
letter <- function(...) {
  template <- system.file("rmarkdown/templates/letter/resources/letter-template.tex",
                          package="filor")
  rmarkdown::pdf_document(...,
                          template = template
  )
}

#' Output formats for filor
#'
#' @param \dots Arguments passed to \code{pdf_document}.
#'
#' @return An R Markdown output format object.
#'
#' @importFrom rmarkdown pdf_document
#' @export
review <- function(...) {
  template <- system.file("rmarkdown/templates/review/resources/review-template.tex",
                          package="filor")
  rmarkdown::pdf_document(...,
                          template = template
  )
}
