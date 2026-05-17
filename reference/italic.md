# Format Text as Italic

Wraps text in italic markup for Markdown, LaTeX, or HTML output.

## Usage

``` r
italic(x, fmt = c("markdown", "html", "tex"))
```

## Arguments

- x:

  A character vector, or an object coercible to character.

- fmt:

  Output format. One of:

  \`"markdown"\`

  :   Return text wrapped in Markdown italic markers.

  \`"html"\`

  :   Return text wrapped in HTML \`\<i\>\` tags.

  \`"tex"\`

  :   Return text wrapped in LaTeX \`\textit\` markup.

## Value

A character vector of the same length as \`x\`.

## Details

The input is escaped with \[escape()\] before being wrapped. This
prevents special characters in \`x\` from being interpreted as Markdown,
LaTeX, or HTML syntax.

For example, \`italic("x_1", "markdown")\` returns escaped Markdown
rather than allowing \`\_1\` to affect the surrounding markup.

## Examples

``` r
italic("emphasis", "markdown")
#> [1] "*emphasis*"
italic("x_1", "markdown")
#> [1] "*x\\_1*"
italic("50% complete", "tex")
#> [1] "\\textit{50\\\\% complete}"
italic("<unsafe>", "html")
#> [1] "<i>&lt;unsafe&gt;</i>"
```
