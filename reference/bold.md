# Format Text as Bold

Wraps text in bold markup for Markdown, LaTeX, or HTML output.

## Usage

``` r
bold(x, fmt = c("markdown", "html", "tex"))
```

## Arguments

- x:

  A character vector, or an object coercible to character.

- fmt:

  Output format. One of:

  \`"markdown"\`

  :   Return text wrapped in Markdown bold markers.

  \`"html"\`

  :   Return text wrapped in HTML \`\<b\>\` tags.

  \`"tex"\`

  :   Return text wrapped in LaTeX \`\textbf\` markup.

## Value

A character vector of the same length as \`x\`.

## Details

The input is escaped with \[escape()\] before being wrapped. This
prevents special characters in \`x\` from being interpreted as Markdown,
LaTeX, or HTML syntax.

For example, \`bold("a_b", "markdown")\` returns escaped Markdown rather
than allowing \`\_b\` to be interpreted as emphasis.

## Examples

``` r
bold("important", "markdown")
#> [1] "**important**"
bold("a_b", "markdown")
#> [1] "**a\\_b**"
bold("50% complete", "tex")
#> [1] "\\textbf{50\\\\% complete}"
bold("<unsafe>", "html")
#> [1] "<b>&lt;unsafe&gt;</b>"
```
