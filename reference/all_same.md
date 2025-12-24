# all_same

Check if all values in a vector are the same. It is robust also to NA
values that can be handled with the `na.rm` parameter

## Usage

``` r
all_same(x, na.rm = FALSE)
```

## Arguments

- x:

  a vector

- na.rm:

  logical indicating whether `NA` values should be removed or not.

## Value

logical vector

## Examples

``` r
all_same(c(1,1,1))  # TRUE
#> [1] TRUE
all_same(c(1,2,3))  # FALSE
#> [1] FALSE
all_same(c(1,1,NA)) # FALSE
#> [1] FALSE
all_same(c(1,1,NA), na.rm = TRUE) # TRUE
#> [1] TRUE
```
