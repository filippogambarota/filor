# Select Line Indices Based on Numeric Positions or Regex Delimiters

Computes a vector of line indices either directly from numeric input or
by identifying a contiguous block of lines delimited by regular
expression matches.

## Usage

``` r
.grep_lines(x, lines = NULL)
```

## Arguments

- x:

  A character vector, typically representing lines of text.

- lines:

  Either:

  - A numeric vector of line indices, or

  - A character vector of length 1 specifying regex delimiters in the
    form `"start|end"`.

## Value

A numeric vector of line indices.

## Details

If `lines` is numeric, it is returned as-is. If `lines` is a character
string, it must be a single regex of the form `"start|end"`, where
`start` and `end` are regular expressions matched against `x`. The
returned indices span from the first match of `start` to the first match
of `end` (inclusive). If only one regex is provided, it is used for both
start and end.

When `lines` is `NULL`, the function currently returns
`1:length(lines)`, which evaluates to an empty integer vector.

## Examples

``` r
txt <- c("alpha", "start", "beta", "gamma", "end", "delta")

.grep_lines(txt, c(2, 3, 4))
#> [1] 2 3 4
.grep_lines(txt, "start|end")
#> [1] 2 3 4 5
.grep_lines(txt, "beta")
#> [1] 3
```
