# Calculate Standard Error and Confidence Interval for a Proportion

This function computes the standard error and the asymptotic (Wald)
confidence interval for a given proportion based on a specified number
of simulations or observations.

## Usage

``` r
se_p(p, nsim, conf.level = 0.95)
```

## Arguments

- p:

  A numeric value representing the proportion (between 0 and 1).

- nsim:

  An integer representing the number of simulations or the sample size.

- conf.level:

  A numeric value between 0 and 1 specifying the confidence level for
  the interval. Defaults to 0.95.

## Value

A list containing:

- `se`: The calculated standard error of the proportion.

- `ci`: A named numeric vector with the lower bound (`ci.lb`) and upper
  bound (`ci.ub`) of the confidence interval.

## Details

The standard error is calculated as: \$\$SE =
\sqrt{\frac{p(1-p)}{n}}\$\$ The confidence interval is calculated using
the standard normal distribution (Z-score) approximation.

## Examples

``` r
se_p(p = 0.5, nsim = 1000)
#> $se
#> [1] 0.01581139
#> 
#> $ci
#>     ci.lb     ci.ub 
#> 0.4690102 0.5309898 
#> 
se_p(p = 0.2, nsim = 500, conf.level = 0.99)
#> $se
#> [1] 0.01788854
#> 
#> $ci
#>     ci.lb     ci.ub 
#> 0.1539222 0.2460778 
#> 
```
