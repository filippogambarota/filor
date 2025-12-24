# Calculate Standard Error (SE) associated with a desired level of statistical power

Calculate the Standard Error (SE) that is associated with a given power
and a given alpha level for a given value of a model parameter B

## Usage

``` r
SE4power(b, power = 0.8, alpha = 0.05, alternative = "two.sided")
```

## Arguments

- power:

  The desired level of statistical power

- alpha:

  The alpha level (rate of type I errors)

- alternative:

  Whether the statistical test is two sided or one sided. Must be one of
  "two.sided" (default) or "one.sided"

- B:

  The model parameter B (practically, the effect size)

## Value

The numerical value of the Standard Error (SE) associated with the above
arguments
