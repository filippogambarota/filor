# summary_rma

summary_rma

## Usage

``` r
summary_rma(x, extra_params = NULL)
```

## Arguments

- x:

  a model fitted with `metafor::rma.uni()`

- extra_params:

  a vector of (extra) parameters to be extracted (see details). These
  are the elements of the `rma.uni` objects.

## Value

a dataframe

## Details

By default the function extract
`c("b", "se", "zval", "pval", "ci.lb", "ci.ub")` as parameters.
