#' Format p-values
#'
#' Formats numeric p-values to a fixed number of decimal places, using
#' a threshold display for very small values.
#'
#' Values smaller than `10^(-digits)` are displayed as `"< 0.001"` when
#' `digits = 3`, `"< 0.01"` when `digits = 2`, and so on.
#'
#' @param p Numeric vector of p-values.
#' @param digits Integer. Number of digits to show after the decimal point.
#'   Defaults to `3`.
#'
#' @return A character vector of formatted p-values, with `NA` values preserved.
#'
#' @examples
#' fpval(c(0.2, 0.0456, 0.0004))
#' fpval(c(0.049, 0.001, 0.0009), digits = 3)
#'
#' @export
fpval <- function(p, digits = 3) {
  limit <- 10^(-digits)

  ifelse(
    is.na(p),
    NA_character_,
    ifelse(
      p < limit,
      sprintf("< %.*f", digits, limit),
      sprintf("%.*f", digits, p)
    )
  )
}

#' @export
wrap <- function(x, before = NULL, after = NULL) {
  if(is.null(before)) before <- ""
  if(is.null(after)) after <- before
  sprintf("%s%s%s", before, x, after)
}

#' Escape Text for a Target Output Format
#'
#' Escapes special characters in a character vector so that the text can be
#' safely inserted into Markdown, LaTeX, or HTML output.
#'
#' This function is intended for escaping plain text before wrapping it in
#' lightweight formatting helpers such as [bold()], [italic()], or [code()].
#'
#' @param x A character vector, or an object coercible to character.
#' @param fmt Output format. One of:
#'   \describe{
#'     \item{`"markdown"`}{Escape Markdown-sensitive characters in ordinary prose.}
#'     \item{`"tex"`}{Escape LaTeX-sensitive characters.}
#'     \item{`"html"`}{Escape HTML-sensitive characters.}
#'   }
#'
#' @details
#' For Markdown, this function performs conservative escaping of characters that
#' commonly have syntactic meaning, including emphasis markers, brackets,
#' braces, list markers, pipes, and backslashes.
#'
#' For LaTeX, this function escapes the standard special characters:
#' `\\`, `{`, `}`, `#`, `$`, `%`, `&`, `_`, `^`, and `~`.
#'
#' For HTML, this function escapes:
#' `&`, `<`, `>`, `"`, and `'`.
#'
#' Markdown inline code spans are a special case. When formatting code, prefer
#' [code()] rather than calling `escape(x, "markdown")` directly, because inline
#' code delimiters need to be chosen according to the content.
#'
#' @return A character vector of the same length as `x`.
#'
#' @examples
#' escape("a_b * c", "markdown")
#' escape("50% of x_1", "tex")
#' escape("<span class='x'>A & B</span>", "html")
#'
#' @export
escape <- function(x, fmt = c("markdown", "tex", "html")) {
  fmt <- match.arg(fmt)
  x <- as.character(x)

  switch(
    fmt,

    markdown = {
      chars <- c(
        "\\", "*", "_", "{", "}", "[", "]", "(", ")",
        "#", "+", "-", ".", "!", "|"
      )

      for (ch in chars) {
        x <- gsub(ch, paste0("\\", ch), x, fixed = TRUE)
      }

      x
    },

    tex = {
      x <- gsub("\\", r"(\textbackslash{})", x, fixed = TRUE)
      x <- gsub("{", "\\\\{", x, fixed = TRUE)
      x <- gsub("}", "\\\\}", x, fixed = TRUE)
      x <- gsub("#", "\\\\#", x, fixed = TRUE)
      x <- gsub("$", "\\\\$", x, fixed = TRUE)
      x <- gsub("%", "\\\\%", x, fixed = TRUE)
      x <- gsub("&", "\\\\&", x, fixed = TRUE)
      x <- gsub("_", "\\\\_", x, fixed = TRUE)
      x <- gsub("^", r"(\textasciicircum{})", x, fixed = TRUE)
      x <- gsub("~", r"(\textasciitilde{})", x, fixed = TRUE)

      x
    },

    html = {
      x <- gsub("&", "&amp;", x, fixed = TRUE)
      x <- gsub("<", "&lt;", x, fixed = TRUE)
      x <- gsub(">", "&gt;", x, fixed = TRUE)
      x <- gsub('"', "&quot;", x, fixed = TRUE)
      x <- gsub("'", "&#39;", x, fixed = TRUE)

      x
    }
  )
}


#' Format Text as Inline Code
#'
#' Wraps text as inline code for Markdown, LaTeX, or HTML output.
#'
#' @param x A character vector, or an object coercible to character.
#' @param fmt Output format. One of:
#'   \describe{
#'     \item{`"markdown"`}{Return Markdown inline code spans.}
#'     \item{`"tex"`}{Return LaTeX `\\texttt{}` markup.}
#'     \item{`"html"`}{Return HTML `<code>` elements.}
#'   }
#'
#' @details
#' For Markdown output, this function uses single backticks for ordinary strings.
#' If a string contains a backtick, it uses double backticks with surrounding
#' spaces:
#'
#' ```
#' `` code with ` backtick ``
#' ```
#'
#' This avoids the common problem of producing invalid inline code when the
#' content itself contains a backtick.
#'
#' For LaTeX and HTML output, the input is first escaped using [escape()] and
#' then wrapped in the appropriate code markup.
#'
#' @return A character vector of the same length as `x`.
#'
#' @examples
#' code("x <- 1", "markdown")
#' code("a `quoted` name", "markdown")
#' code("x_1 <- 50%", "tex")
#' code("<script>alert('x')</script>", "html")
#'
#' @export
code <- function(x, fmt = c("markdown", "tex", "html")) {
  fmt <- match.arg(fmt)
  x <- as.character(x)

  switch(
    fmt,

    markdown = {
      needs_double <- grepl("`", x, fixed = TRUE)

      out <- sprintf("`%s`", x)
      out[needs_double] <- sprintf("`` %s ``", x[needs_double])

      out
    },

    tex = {
      x <- escape(x, "tex")
      sprintf(r"(\texttt{%s})", x)
    },

    html = {
      x <- escape(x, "html")
      sprintf(r"(<code>%s</code>)", x)
    }
  )
}


#' Format Text as Bold
#'
#' Wraps text in bold markup for Markdown, LaTeX, or HTML output.
#'
#' @param x A character vector, or an object coercible to character.
#' @param fmt Output format. One of:
#'   \describe{
#'     \item{`"markdown"`}{Return text wrapped in Markdown bold markers.}
#'     \item{`"html"`}{Return text wrapped in HTML `<b>` tags.}
#'     \item{`"tex"`}{Return text wrapped in LaTeX `\\textbf{}` markup.}
#'   }
#'
#' @details
#' The input is escaped with [escape()] before being wrapped. This prevents
#' special characters in `x` from being interpreted as Markdown, LaTeX, or HTML
#' syntax.
#'
#' For example, `bold("a_b", "markdown")` returns escaped Markdown rather than
#' allowing `_b` to be interpreted as emphasis.
#'
#' @return A character vector of the same length as `x`.
#'
#' @examples
#' bold("important", "markdown")
#' bold("a_b", "markdown")
#' bold("50% complete", "tex")
#' bold("<unsafe>", "html")
#'
#' @export
bold <- function(x, fmt = c("markdown", "html", "tex")) {
  fmt <- match.arg(fmt)
  x <- escape(x, fmt)

  switch(
    fmt,
    markdown = sprintf("**%s**", x),
    html = sprintf("<b>%s</b>", x),
    tex = sprintf("\\textbf{%s}", x)
  )
}


#' Format Text as Italic
#'
#' Wraps text in italic markup for Markdown, LaTeX, or HTML output.
#'
#' @param x A character vector, or an object coercible to character.
#' @param fmt Output format. One of:
#'   \describe{
#'     \item{`"markdown"`}{Return text wrapped in Markdown italic markers.}
#'     \item{`"html"`}{Return text wrapped in HTML `<i>` tags.}
#'     \item{`"tex"`}{Return text wrapped in LaTeX `\\textit{}` markup.}
#'   }
#'
#' @details
#' The input is escaped with [escape()] before being wrapped. This prevents
#' special characters in `x` from being interpreted as Markdown, LaTeX, or HTML
#' syntax.
#'
#' For example, `italic("x_1", "markdown")` returns escaped Markdown rather than
#' allowing `_1` to affect the surrounding markup.
#'
#' @return A character vector of the same length as `x`.
#'
#' @examples
#' italic("emphasis", "markdown")
#' italic("x_1", "markdown")
#' italic("50% complete", "tex")
#' italic("<unsafe>", "html")
#'
#' @export
italic <- function(x, fmt = c("markdown", "html", "tex")) {
  fmt <- match.arg(fmt)
  x <- escape(x, fmt)

  switch(
    fmt,
    markdown = sprintf("*%s*", x),
    html = sprintf("<i>%s</i>", x),
    tex = sprintf("\\textit{%s}", x)
  )
}
