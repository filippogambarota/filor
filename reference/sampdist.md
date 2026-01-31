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
#>  [1] -2.923829e-02  4.442401e-05  4.178289e-01 -2.372357e-02  7.601238e-02
#>  [6]  2.279345e-01 -2.367952e-02 -4.850809e-02 -1.687226e-02  2.038590e-01
```
