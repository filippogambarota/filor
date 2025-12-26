# trim

Cut a numeric vector between min and max. Values lower than min or
higher than max are substituted with the provided values.

## Usage

``` r
trim(x, min = NULL, max = NULL)
```

## Arguments

- x:

  the numeric vector

- min:

  the minimum value. Default to \`NULL\`. If \`NULL\`, the lower bound
  is not modified.

- max:

  the maximum value. Default to \`NULL\`. If \`NULL\`, the upper bound
  is not modified.

## Examples

``` r
x <- runif(20, 0, 20)
trim(x, min = 5, max = 10)
#>  [1] 10.000000  9.361787 10.000000  6.619074 10.000000  9.051049 10.000000
#>  [8] 10.000000  5.000000  5.626261 10.000000  8.843738 10.000000 10.000000
#> [15]  5.000000 10.000000  5.000000 10.000000 10.000000 10.000000
trim(x, max = 10)
#>  [1] 10.000000  9.361787 10.000000  6.619074 10.000000  9.051049 10.000000
#>  [8] 10.000000  2.761191  5.626261 10.000000  8.843738 10.000000 10.000000
#> [15]  1.368128 10.000000  4.889670 10.000000 10.000000 10.000000
trim(x, min = 5)
#>  [1] 13.373490  9.361787 10.763849  6.619074 12.573642  9.051049 17.760304
#>  [8] 15.684036  5.000000  5.626261 14.138930  8.843738 13.553970 14.014300
#> [15]  5.000000 19.170070  5.000000 18.525667 10.054942 18.710343
```
