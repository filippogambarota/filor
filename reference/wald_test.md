# wald_test

wald_test

## Usage

``` r
wald_test(x, h0 = 0, btt = NULL, alternative = "two.sided", alpha = 0.05)
```

## Arguments

- x:

  a model. Currently supported classes are \`lmerMod\`, \`glmerMod\`,
  \`lm\` and \`glm\`

- h0:

  a vector of null hypothesis, default to 0

- btt:

  vector of coefficents names to test. Default to \`NULL\` (all
  coefficients)

- alternative:

  character indicating the side of the hypothesis

- alpha:

  the alpha level, default to 0.05

## Value

a dataframe

## Examples

``` r
fit <- lm(Sepal.Lenght ~ Species, data = iris)
#> Error in eval(predvars, data, env): object 'Sepal.Lenght' not found
wald_test(fit)
#> Error: object 'fit' not found
```
