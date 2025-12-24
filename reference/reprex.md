# Create and copy a minimal reproducible example (reprex)

This helper function prints both the expression and its evaluated output
in a tidyverse-style format, prefixing output lines with a comment
marker (e.g. \`#\>\`). The formatted text is also copied to the
clipboard for easy pasting into issues, documents, or chat.

## Usage

``` r
reprex(expr, comment = "#>")
```

## Arguments

- expr:

  An R expression or block of expressions surrounded by \`\`. The
  expressions are deparsed and evaluated sequentially.

- comment:

  A string used to prefix each output line. Defaults to \`"#\>"\`.

## Value

Invisibly returns \`NULL\`. The side effects are printed and copied
text.

## Details

\- Leading indentation is stripped for readability. - The outer \`\` of
a block are removed before printing. - Vector output markers like
\`\[1\]\` are removed. - The result (both code and output) is copied to
the clipboard using the \*\*clipr\*\* package if available.

## Examples

``` r
if (FALSE) { # \dontrun{
reprex({
  x <- 1:5
  mean(x)
})

reprex(mean(1:5))
} # }
```
