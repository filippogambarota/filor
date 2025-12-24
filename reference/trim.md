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
#>  [1]  8.714363 10.000000 10.000000  5.000000 10.000000  5.000000 10.000000
#>  [8] 10.000000  5.000000 10.000000 10.000000  8.147227 10.000000 10.000000
#> [15]  7.083735  9.116803  5.000000  5.000000  7.384721  5.000000
trim(x, max = 10)
#>  [1]  8.714363 10.000000 10.000000  2.562315 10.000000  2.580325 10.000000
#>  [8] 10.000000  4.835522 10.000000 10.000000  8.147227 10.000000 10.000000
#> [15]  7.083735  9.116803  4.400494  1.636660  7.384721  2.533332
trim(x, min = 5)
#>  [1]  8.714363 17.946088 15.380270  5.000000 10.772662  5.000000 10.219298
#>  [8] 10.875854  5.000000 16.062882 18.958274  8.147227 10.294891 19.630837
#> [15]  7.083735  9.116803  5.000000  5.000000  7.384721  5.000000
```
