# Check lme4 Model Convergence Status

\`lme4_has_converged\` checks whether a model fitted with \`lme4::lmer\`
or \`lme4::glmer\` has converged successfully.

## Usage

``` r
lme4_has_converged(x)
```

## Arguments

- x:

  An object of class \`merMod\` (e.g., the result of \`lmer()\` or
  \`glmer()\`).

## Value

An integer indicating the convergence status:

- 1:

  Converged successfully (no convergence issues).

- 0:

  Model is singular (some random effects may be redundant).

- -1:

  Convergence issues detected, but model is not singular.

## Details

This function inspects the \`@optinfo\$conv\$lme4\` slot of the model
object to determine if the optimizer reported any convergence problems.
It also checks for singularity using \`isSingular()\`. The function has
been copied from Robert Long
https://stackoverflow.com/a/72128391/9032257.

## Examples

``` r
if (FALSE) { # \dontrun{
library(lme4)
fm <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
lme4_has_converged(fm)
} # }
```
