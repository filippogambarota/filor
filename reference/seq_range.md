# Generate a sequence over the range of a numeric vector

Creates a sequence from the minimum to the maximum of \`x\`, using
either a step size (\`by\`) or a desired number of points
(\`length.out\`).

## Usage

``` r
seq_range(x, by = NULL, length.out = NULL, na.rm = FALSE)
```

## Arguments

- x:

  A numeric vector.

- by:

  A numeric increment for the sequence. Mutually exclusive with
  \`length.out\`.

- length.out:

  Desired length of the output sequence. Mutually exclusive with \`by\`.

- na.rm:

  Logical. Should missing values be removed before computing the range?
  Default is \`FALSE\`.

## Value

A numeric vector containing a sequence from \`min(x)\` to \`max(x)\`.

## Details

Exactly one between \`by\` and \`length.out\` must be supplied.

If \`na.rm = FALSE\` and \`x\` contains missing values, the function may
fail because \`min(x)\` and \`max(x)\` return \`NA\`.

## Examples

``` r
x <- c(3.2, 7.8, 5.1, 9.4)

seq_range(x, by = 1)
#> [1] 3.2 4.2 5.2 6.2 7.2 8.2 9.2
seq_range(x, length.out = 5)
#> [1] 3.20 4.75 6.30 7.85 9.40

x2 <- c(1, 4, NA, 10)
seq_range(x2, length.out = 4, na.rm = TRUE)
#> [1]  1  4  7 10
```
