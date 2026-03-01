# sim_meta

Simulate meta-analysis data using unstandardized mean difference as
effect size.

## Usage

``` r
sim_meta(k, mu, tau2, n1, n2 = NULL, v = 1)
```

## Arguments

- k:

  number of studies.

- mu:

  average effect size.

- tau2:

  between studies heterogeneity.

- n1:

  sample size for the first group.

- n2:

  sample size for the second group. Default to `NULL`

- v:

  pooled within-study variance. Default to `1`

## Value

dataframe with simulated data

## Examples

``` r
# simulate equal-effects model with 10 studies, 30 participants in each study
# and an effect size of 0.5
sim_meta(10, 0.5, 0, 30, 30)
#>    id        yi         vi       sei deltai n1 n2
#> 1   1 0.5108790 0.04865300 0.2205742      0 30 30
#> 2   2 0.8045880 0.05783129 0.2404814      0 30 30
#> 3   3 0.4336632 0.07001336 0.2646004      0 30 30
#> 4   4 0.2272552 0.07379644 0.2716550      0 30 30
#> 5   5 0.5513241 0.07906605 0.2811869      0 30 30
#> 6   6 0.6679670 0.04347523 0.2085072      0 30 30
#> 7   7 0.5887980 0.06866455 0.2620392      0 30 30
#> 8   8 0.8814972 0.08392140 0.2896919      0 30 30
#> 9   9 0.5185970 0.06354618 0.2520837      0 30 30
#> 10 10 1.0490456 0.05232454 0.2287456      0 30 30
```
