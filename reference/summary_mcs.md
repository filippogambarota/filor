# Summarize an object with optional extra computations

Applies a summary function to an object and optionally attaches
additional computations as an attribute.

## Usage

``` r
summary_mcs(x, summary = NULL, summary.args = NULL, extra = NULL)
```

## Arguments

- x:

  An object to be summarized.

- summary:

  A function used to summarize `x`. If `NULL`, `x` is returned
  unchanged.

- summary.args:

  A list of additional arguments passed to `summary` via
  [`do.call()`](https://rdrr.io/r/base/do.call.html).

- extra:

  An optional list of functions. Each function is applied to the
  original `x`, and the results are stored as the `"mcs"` attribute of
  the output.

## Value

If `summary` is provided, returns the result of `summary(x, ...)`;
otherwise returns `x`. If `extra` is supplied, the returned object has
an additional attribute `"mcs"` containing a list of extra results.

## Details

Functions supplied in `extra` are always evaluated on the original input
`x`, not on the summarized output.

## Examples

``` r
summary_mcs(
  x = rnorm(10),
  summary = summary,
  extra = list(
    mean = mean,
    sd = sd
  )
)
#>     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#> -0.77211 -0.32099  0.03223  0.19203  0.57595  1.62495 
```
