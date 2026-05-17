# Format Text as Inline Code

Wraps text as inline code for Markdown, LaTeX, or HTML output.

## Usage

``` r
code(x, fmt = c("markdown", "tex", "html"))
```

## Arguments

- x:

  A character vector, or an object coercible to character.

- fmt:

  Output format. One of:

  \`"markdown"\`

  :   Return Markdown inline code spans.

  \`"tex"\`

  :   Return LaTeX \`\texttt\` markup.

  \`"html"\`

  :   Return HTML \`\<code\>\` elements.

## Value

A character vector of the same length as \`x\`.

## Details

For Markdown output, this function uses single backticks for ordinary
strings. If a string contains a backtick, it uses double backticks with
surrounding spaces:

“\` “ code with \` backtick “ “\`

This avoids the common problem of producing invalid inline code when the
content itself contains a backtick.

For LaTeX and HTML output, the input is first escaped using \[escape()\]
and then wrapped in the appropriate code markup.

## Examples

``` r
code("x <- 1", "markdown")
#> [1] "`x <- 1`"
code("a `quoted` name", "markdown")
#> [1] "`` a `quoted` name ``"
code("x_1 <- 50%", "tex")
#> [1] "\\texttt{x\\\\_1 <- 50\\\\%}"
code("<script>alert('x')</script>", "html")
#> [1] "<code>&lt;script&gt;alert(&#39;x&#39;)&lt;/script&gt;</code>"
```
