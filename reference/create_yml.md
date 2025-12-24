# Create a YAML-style list from a named vector or list

This function takes a named vector or list and converts it into a
YAML-style list of key–value pairs. Each element is represented as \`-
key: value\`. If a file path is provided, the YAML output is written to
disk.

## Usage

``` r
create_yml(x, file = NULL)
```

## Arguments

- x:

  A named vector or list. The names will be used as keys, and the
  corresponding values as values. \`NA\` values are converted to empty
  strings.

- file:

  Optional. A character string giving the path to a file where the YAML
  output should be written. If \`NULL\` (default), the result is
  returned instead of written.

## Value

If \`file\` is \`NULL\`, returns a character vector with one entry per
YAML item. If \`file\` is not \`NULL\`, the YAML output is written to
the specified file and the result is returned invisibly.

## Examples

``` r
# Create a simple YAML list from a named vector
x <- c(name = "Alice", age = 30, country = NA)
create_yml(x)
#> [1] "- name: Alice\n  age: 30\n  country: \n  "
```
