% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmd_utils.R
\name{get_rmd_comments}
\alias{get_rmd_comments}
\title{get_rmd_comments}
\usage{
get_rmd_comments(file, exclude = c("#SETUP"), write = TRUE)
}
\arguments{
\item{file}{string indicating the file}

\item{exclude}{character vector with pattern to excluding some comments}

\item{write}{logical that indicate if returning a bullet list
for printing. Default to \code{TRUE}.}
}
\value{
list of comments
}
\description{
Extract all comments from an \code{Rmd} file
}
