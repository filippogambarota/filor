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
#>  [1] -0.24787308  0.13179875  0.14306822  0.06248182  0.18737804  0.02814191
#>  [7]  0.21583993 -0.16760277 -0.07576693  0.24119612
```
