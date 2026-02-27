# Pairwise name combinations (as concatenated strings)

Generate all 2-combinations of a set of names and return each pair as a
single concatenated string (e.g., \`"ab"\`, \`"ac"\`, ...).

## Usage

``` r
wcor(n, names = NULL)
```

## Arguments

- n:

  Integer. Number of elements (and number of names to generate if
  \`names\` is \`NULL\`).

- names:

  Character vector of length \`n\`. If \`NULL\`, defaults to
  \`letters\[1:n\]\`.

## Value

A character vector of length \`choose(n, 2)\` containing concatenated
name pairs.

## Details

If \`names\` is not provided, the first \`n\` lowercase letters
(\`letters\[1:n\]\`) are used as default names.

Uses \[gtools::combinations()\] to generate all unordered pairs of
\`names\`, then concatenates each pair with no separator.

## See also

\[gtools::combinations()\]

## Examples

``` r
wcor(4)
#> Error in loadNamespace(x): there is no package called ‘gtools’
wcor(3, c("x", "y", "z"))
#> Error in loadNamespace(x): there is no package called ‘gtools’
```
