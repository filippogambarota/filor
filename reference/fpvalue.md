# fpvalue

fpvalue

## Usage

``` r
fpvalue(p, digits = 3, omit.p = FALSE, tex = FALSE, wrap = NULL)
```

## Arguments

- p:

  numeric. The p value to format

- digits:

  numeric. The number of digits that the p value should be printed with.

- omit.p:

  logical. Should the string "p ..." be omitted (e.g., for a table where
  the header is already "p")

- tex:

  logical. If TRUE, the latex math symbols are used

- wrap:

  character. A string that will be pasted before and after the final p
  value. Default to \`NULL\` thus empty string. If \`NULL\` and \`tex\`
  is \`TRUE\` the \`\$\` symbol is used.

## Value

string with the formatted p value

## Examples

``` r
fpvalue(0.0001, tex = TRUE)
#> [1] "$p \\leq 0.001$"
fpvalue(0.001, tex = FALSE)
#> [1] "p = 0.001"
```
