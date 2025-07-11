% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/general_utils.R
\name{cfilter}
\alias{cfilter}
\title{Filter a List by Class}
\usage{
cfilter(x, class, not = FALSE)
}
\arguments{
\item{x}{A list of R objects.}

\item{class}{A character string specifying the class to filter by.}

\item{not}{Logical; if `TRUE`, elements *not* inheriting from `class` are kept. Default is `FALSE`.}
}
\value{
A list containing the elements of `x` that (do not) inherit from the specified class.
}
\description{
Filters a list, keeping or excluding elements based on their class.
}
\examples{
lst <- list(1L, "text", 3.14, list(a = 1))
cfilter(lst, "numeric")  # returns elements that are numeric
cfilter(lst, "character")  # returns character elements
cfilter(lst, "numeric", not = TRUE)  # returns elements that are NOT numeric

}
