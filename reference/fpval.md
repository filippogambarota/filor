# Format p-values

Formats numeric p-values to a fixed number of decimal places, using a
threshold display for very small values.

## Usage

``` r
fpval(p, digits = 3)
```

## Arguments

- p:

  Numeric vector of p-values.

- digits:

  Integer. Number of digits to show after the decimal point. Defaults to
  \`3\`.

## Value

A character vector of formatted p-values, with \`NA\` values preserved.

## Details

Values smaller than \`10^(-digits)\` are displayed as \`"\< 0.001"\`
when \`digits = 3\`, \`"\< 0.01"\` when \`digits = 2\`, and so on.

## Examples

``` r
fpval(c(0.2, 0.0456, 0.0004))
#> [1] "0.200"   "0.046"   "< 0.001"
fpval(c(0.049, 0.001, 0.0009), digits = 3)
#> [1] "0.049"   "0.001"   "< 0.001"
```
