# Express a Probability Relative to Chance

Converts a probability or accuracy value to a chance-relative scale. The
chance level is mapped to 0, and perfect performance is mapped to 1.
Values below chance become negative.

## Usage

``` r
rel_chance(p, chance = 1/2)
```

## Arguments

- p:

  Numeric vector. Observed probability or accuracy values. Values must
  be between 0 and 1.

- chance:

  Numeric vector or scalar. Chance-level probability. Defaults to
  \`1/2\`. Values must be greater than or equal to 0 and strictly less
  than 1.

## Value

A numeric vector of chance-relative scores. Values are 0 at chance, 1 at
perfect performance, and negative below chance.

## Details

The transformation is:

\$\$ \frac{p - chance}{1 - chance} \$\$

This expresses performance as the proportion of the maximum possible
improvement above chance.

For example, if \`p = 0.75\` and \`chance = 0.5\`, then the
chance-relative score is \`0.5\`, meaning that performance covers 50
improvement from chance to perfect accuracy.

## Examples

``` r
rel_chance(0.75, chance = 0.5)
#> [1] 0.5
rel_chance(c(0.55, 0.60, 0.70), chance = 0.5)
#> [1] 0.1 0.2 0.4
```
