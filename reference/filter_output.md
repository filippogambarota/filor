# filter_output

filter_output

## Usage

``` r
filter_output(x, lines = NULL, cat = TRUE)
```

## Arguments

- x:

  the result of a function to capture e.g. summary(x)

- lines:

  a vector of line numbers to extract or a pattern as "from\|to" where
  from and to are regex mapping the lines to extract.

- cat:

  logical indicating if using cat() for the output

## Examples

``` r
fit <- lm(mpg ~ hp, data = mtcars)
filter_output(summary(fit), 1:5)
#> 
#> Call:
#> lm(formula = mpg ~ hp, data = mtcars)
#> 
#> Residuals:
```
