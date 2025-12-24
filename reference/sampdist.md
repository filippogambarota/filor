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
#>  [1] -0.050029429  0.051403463  0.381711483  0.001575967  0.101141088
#>  [6]  0.127137814  0.025079639 -0.032132143 -0.078279466  0.255589870
```
