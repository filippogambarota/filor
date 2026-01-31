# Filter knitr output by line indices

Sets a custom knitr output hook that filters printed output, keeping
only the lines specified in the chunk option `lines`. This is useful
when you want to show only selected parts of console output in knitted
documents.

## Usage

``` r
set_filter_output()
```

## Value

Invisibly returns `NULL`. Called for its side effects.

## Details

The function modifies knitr's global output hook. Call it once (e.g., in
a setup chunk) to activate the behavior for the rest of the document.

The hook:

- splits the output into lines using
  [`xfun::split_lines()`](https://rdrr.io/pkg/xfun/man/split_lines.html)

- selects lines via an internal helper `filor:::.grep_lines()`

- passes the filtered output to the original knitr output hook

## See also

[`knit_hooks`](https://rdrr.io/pkg/knitr/man/knit_hooks.html)

## Examples

``` r
if (FALSE) { # \dontrun{
set_filter_output()

## In an R Markdown chunk:
## ```{r, lines = c(1, 3, 5)}
## print(1:10)
## ```
} # }
```
