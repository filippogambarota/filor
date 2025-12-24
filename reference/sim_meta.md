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
#>    id         yi         vi       sei deltai n1 n2
#> 1   1 0.19804635 0.06980589 0.2642081      0 30 30
#> 2   2 0.64436055 0.08490492 0.2913845      0 30 30
#> 3   3 0.03024656 0.06640416 0.2576900      0 30 30
#> 4   4 0.60156098 0.09421276 0.3069410      0 30 30
#> 5   5 0.51087898 0.04865300 0.2205742      0 30 30
#> 6   6 0.80458798 0.05783129 0.2404814      0 30 30
#> 7   7 0.43366324 0.07001336 0.2646004      0 30 30
#> 8   8 0.22725519 0.07379644 0.2716550      0 30 30
#> 9   9 0.55132405 0.07906605 0.2811869      0 30 30
#> 10 10 0.66796704 0.04347523 0.2085072      0 30 30
```
