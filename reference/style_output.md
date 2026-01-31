# Highlight Selected Lines of Printed Output as HTML

Captures the printed output of an R object, escapes it for HTML, and
highlights selected lines using either an inline background color or a
CSS class. The result is wrapped in \`\<pre\>\<code\>\` tags and printed
to the output.

## Usage

``` r
style_output(x, lines, hg = "yellow", class = NULL)
```

## Arguments

- x:

  An R object whose printed representation will be captured.

- lines:

  Integer vector indicating which lines of the output should be
  highlighted. Passed to
  [`.grep_lines()`](https://filippogambarota.github.io/filor/reference/dot-grep_lines.md)
  for selection.

- hg:

  Character string specifying the background color to use for
  highlighting when `class` is `NULL`. Defaults to `"yellow"`.

- class:

  Optional character string giving a CSS class name to apply to
  highlighted lines. If provided, `hg` is ignored.

## Value

This function is called for its side effect. It prints HTML code to the
output and returns `invisible(NULL)`.

## Details

The function uses
[`capture.output`](https://rdrr.io/r/utils/capture.output.html) to
obtain the printed representation of `x` and
[`htmlEscape`](https://rstudio.github.io/htmltools/reference/htmlEscape.html)
to ensure HTML safety. Line selection is delegated to the internal
helper
[`.grep_lines()`](https://filippogambarota.github.io/filor/reference/dot-grep_lines.md).

## Examples

``` r
x <- summary(lm(mpg ~ wt, data = mtcars))
style_output(x, lines = 2:3)
#> <pre><code>
#> <span style='background-color: yellow;'>Call:</span>
#> <span style='background-color: yellow;'>lm(formula = mpg ~ wt, data = mtcars)</span>
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -4.5432 -2.3647 -0.1252  1.4096  6.8727 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(&gt;|t|)    
#> (Intercept)  37.2851     1.8776  19.858  &lt; 2e-16 ***
#> wt           -5.3445     0.5591  -9.559 1.29e-10 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.046 on 30 degrees of freedom
#> Multiple R-squared:  0.7528, Adjusted R-squared:  0.7446 
#> F-statistic: 91.38 on 1 and 30 DF,  p-value: 1.294e-10
#> 
#> </code></pre>

# Using a CSS class instead of inline color
style_output(x, lines = 1, class = "highlight")
#> <pre><code><span class='highlight'></span>
#> Call:
#> lm(formula = mpg ~ wt, data = mtcars)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -4.5432 -2.3647 -0.1252  1.4096  6.8727 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(&gt;|t|)    
#> (Intercept)  37.2851     1.8776  19.858  &lt; 2e-16 ***
#> wt           -5.3445     0.5591  -9.559 1.29e-10 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.046 on 30 degrees of freedom
#> Multiple R-squared:  0.7528, Adjusted R-squared:  0.7446 
#> F-statistic: 91.38 on 1 and 30 DF,  p-value: 1.294e-10
#> 
#> </code></pre>
```
