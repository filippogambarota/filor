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
#> 1   1 0.9024568 0.07052802 0.2655711      0 30 30
#> 2   2 0.5182052 0.06688264 0.2586168      0 30 30
#> 3   3 0.5333819 0.05887324 0.2426381      0 30 30
#> 4   4 0.9428279 0.08237068 0.2870029      0 30 30
#> 5   5 0.6190081 0.07604036 0.2757542      0 30 30
#> 6   6 0.1733626 0.06483562 0.2546284      0 30 30
#> 7   7 0.3226554 0.05984337 0.2446291      0 30 30
#> 8   8 0.3849306 0.06289481 0.2507884      0 30 30
#> 9   9 0.8160566 0.05353059 0.2313668      0 30 30
#> 10 10 0.5929035 0.06447308 0.2539155      0 30 30
```
