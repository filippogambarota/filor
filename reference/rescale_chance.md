# Rescale a Probability to a Different Chance Level

Converts a probability or accuracy value from one chance-level scale to
another while preserving the same chance-relative performance.

## Usage

``` r
rescale_chance(p, chance.old, chance.new)
```

## Arguments

- p:

  Numeric vector. Observed probability or accuracy values on the
  original scale. Values must be between 0 and 1.

- chance.old:

  Numeric vector or scalar. Original chance-level probability. Values
  must be greater than or equal to 0 and strictly less than 1.

- chance.new:

  Numeric vector or scalar. New chance-level probability. Values must be
  between 0 and 1.

## Value

A numeric vector of probabilities rescaled to the new chance level.

## Details

The transformation first computes chance-relative performance:

\$\$ r = \frac{p - chance.old}{1 - chance.old} \$\$

and then maps it onto the new chance-level scale:

\$\$ p\_{new} = chance.new + r(1 - chance.new) \$\$

Equivalently:

\$\$ p\_{new} = chance.new + \frac{p - chance.old}{1 - chance.old}(1 -
chance.new) \$\$

This preserves the relative distance between chance and perfect
performance.

## Examples

``` r
rescale_chance(0.60, chance.old = 0.5, chance.new = 0.2)
#> [1] 0.36

p <- c(0.55, 0.60, 0.70)
rescale_chance(p, chance.old = 0.5, chance.new = 0.25)
#> [1] 0.325 0.400 0.550
```
