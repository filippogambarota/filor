# sampdist

Generate a sampling distribution from a statistics applied to samples
generated from a normal distribution.

## Usage

``` r
sampdist(n, mean = 0, sd = 1, B = 1000, FUN)
```

## Arguments

- n:

  sample size

- mean:

  the mean of the normal distribution

- sd:

  the standard deviation of the normal distribution

- B:

  the number of simulations

- FUN:

  the function to be applied to each sample

## Value

a vector of length B with the sampling distribution

## Examples

``` r
sampdist(30, 0, 1, B = 10, FUN = mean)
#>  [1] -0.14200813  0.07706306  0.30237423  0.06861222  0.06597333  0.16636795
#>  [7]  0.01581691 -0.10390356  0.02784649  0.19536957
```
