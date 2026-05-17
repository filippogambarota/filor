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
#>  [1] 10.000000 10.000000 10.000000  5.000000  9.506331  5.000000  7.596331
#>  [8] 10.000000  7.035958  5.000000  5.000000 10.000000  8.352936 10.000000
#> [15]  5.000000  8.697855 10.000000 10.000000 10.000000  5.000000
trim(x, max = 10)
#>  [1] 10.00000000 10.00000000 10.00000000  0.01249547  9.50633148  4.40237770
#>  [7]  7.59633075 10.00000000  7.03595818  2.22270849  4.87238945 10.00000000
#> [13]  8.35293559 10.00000000  2.05729289  8.69785483 10.00000000 10.00000000
#> [19] 10.00000000  3.50105301
trim(x, min = 5)
#>  [1] 15.089503 12.584423 14.203648  5.000000  9.506331  5.000000  7.596331
#>  [8] 12.255420  7.035958  5.000000  5.000000 13.361112  8.352936 15.763917
#> [15]  5.000000  8.697855 19.699140 17.861022 17.729381  5.000000
```
