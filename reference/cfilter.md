# Filter a List by Class

Filters a list, keeping or excluding elements based on their class.

## Usage

``` r
cfilter(x, class, not = FALSE)
```

## Arguments

- x:

  A list of R objects.

- class:

  A character string specifying the class to filter by.

- not:

  Logical; if \`TRUE\`, elements \*not\* inheriting from \`class\` are
  kept. Default is \`FALSE\`.

## Value

A list containing the elements of \`x\` that (do not) inherit from the
specified class.

## Examples

``` r
lst <- list(1L, "text", 3.14, list(a = 1))
cfilter(lst, "numeric")  # returns elements that are numeric
#> [[1]]
#> [1] 3.14
#> 
cfilter(lst, "character")  # returns character elements
#> [[1]]
#> [1] "text"
#> 
cfilter(lst, "numeric", not = TRUE)  # returns elements that are NOT numeric
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] "text"
#> 
#> [[3]]
#> [[3]]$a
#> [1] 1
#> 
#> 
```
