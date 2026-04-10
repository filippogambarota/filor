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
#> 1   1 0.80508150 0.04509161 0.2123478      0 30 30
#> 2   2 0.55122462 0.06404108 0.2530634      0 30 30
#> 3   3 0.39661581 0.08079445 0.2842436      0 30 30
#> 4   4 0.65909035 0.06240211 0.2498041      0 30 30
#> 5   5 1.00972508 0.06401846 0.2530187      0 30 30
#> 6   6 0.98661772 0.07374413 0.2715587      0 30 30
#> 7   7 0.08981994 0.06980589 0.2642081      0 30 30
#> 8   8 0.36059244 0.08490492 0.2913845      0 30 30
#> 9   9 0.19804635 0.06640416 0.2576900      0 30 30
#> 10 10 0.64436055 0.09421276 0.3069410      0 30 30
```
