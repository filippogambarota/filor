# Simple or Stratified Random Sampling

Draws a random sample of rows from a data frame. Sampling can be
performed globally across the whole data set or separately within groups
defined by one or more columns.

## Usage

``` r
sample_by_group(data, n = 1, by = NULL)
```

## Arguments

- data:

  A `data.frame` from which rows are sampled.

- n:

  A non-negative integer giving the number of rows to sample from each
  group. If a group contains fewer than `n` rows, all rows in that group
  are returned. Defaults to `1`.

- by:

  A character vector specifying the grouping columns, for example
  `"group"` or `c("group1", "group2")`. If `NULL`, sampling is performed
  over the entire data frame. Defaults to `NULL`.

## Value

A `data.frame` containing the sampled rows, with row names reset.

## Details

When `by = NULL`, the function samples up to `n` rows from the full data
frame. When `by` is supplied, the data are split by the selected
grouping columns and up to `n` rows are sampled independently from each
group.

If a group contains fewer than `n` rows, all rows from that group are
returned. The function does not set a random seed; use
[`set.seed`](https://rdrr.io/r/base/Random.html) before calling it if
reproducible sampling is required.

## Examples

``` r
# Sample 2 rows from the full iris data set
sample_by_group(iris, n = 2)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 1          5.1         2.5          3.0         1.1 versicolor
#> 2          5.4         3.7          1.5         0.2     setosa

# Sample 1 row per Species
sample_by_group(iris, n = 1, by = "Species")
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 1          5.1         3.5          1.4         0.2     setosa
#> 2          6.6         2.9          4.6         1.3 versicolor
#> 3          6.2         3.4          5.4         2.3  virginica

# Sample 2 rows per combination of cyl and am
sample_by_group(mtcars, n = 2, by = c("cyl", "am"))
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1  22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> 2  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> 3  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> 4  21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> 5  14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 6  15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 7  32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> 8  22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> 9  21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 10 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> 11 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> 12 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4

# Reproducible sampling
set.seed(123)
sample_by_group(iris, n = 1, by = "Species")
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 1          4.8         3.1          1.6         0.2     setosa
#> 2          5.6         2.9          3.6         1.3 versicolor
#> 3          5.7         2.5          5.0         2.0  virginica
```
