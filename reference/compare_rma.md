# compare_rma

Put in a dataframe one or more models fitted with `metafor::rma.uni` for
a nice visual comparison.

## Usage

``` r
compare_rma(..., fitlist = NULL, extra_params = NULL)
```

## Arguments

- ...:

  models to be compared

- fitlist:

  a list of models instead of using \`...\`. When \`fitlist\` is
  provided \`...\` are ignored.

- extra_params:

  a vector of (extra) parameters to be extracted. These are the elements
  of the `rma.uni` objects.

## Value

a dataframe
