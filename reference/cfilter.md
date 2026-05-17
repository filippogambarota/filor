# Filter a List by Class

Filters a list, keeping or excluding elements based on their class.

## Usage

``` r
cfilter(x, classes, not = FALSE)
```

## Arguments

- x:

  A list of R objects.

- classes:

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
#> Error in FUN(X[[i]], ...): 'what' must be a character vector or an object with a nameOfClass() method
cfilter(lst, "character")  # returns character elements
#> Error in FUN(X[[i]], ...): 'what' must be a character vector or an object with a nameOfClass() method
cfilter(lst, "numeric", not = TRUE)  # returns elements that are NOT numeric
#> Error in FUN(X[[i]], ...): 'what' must be a character vector or an object with a nameOfClass() method
```
