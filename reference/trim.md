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
#>  [1] 10.000000 10.000000  5.000000 10.000000  5.000000 10.000000 10.000000
#>  [8] 10.000000  8.775993  7.009731  9.530082 10.000000  5.943239  5.812966
#> [15] 10.000000  5.000000 10.000000  7.309730  5.053993 10.000000
trim(x, max = 10)
#>  [1] 10.000000 10.000000  1.368128 10.000000  4.889670 10.000000 10.000000
#>  [8] 10.000000  8.775993  7.009731  9.530082 10.000000  5.943239  5.812966
#> [15] 10.000000  3.866253 10.000000  7.309730  5.053993 10.000000
trim(x, min = 5)
#>  [1] 13.553970 14.014300  5.000000 19.170070  5.000000 18.525667 10.054942
#>  [8] 18.710343  8.775993  7.009731  9.530082 19.323191  5.943239  5.812966
#> [15] 17.194445  5.000000 16.182167  7.309730  5.053993 17.121620
```
