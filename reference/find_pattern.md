# find_pattern

return how many times a specific pattern occurs in any file of the
current directory and sub directories.

## Usage

``` r
find_pattern(pattern, which_files = c("R", "Rmd"), dir = ".")
```

## Arguments

- which_files:

  a character vector with file extensions to check.

- dir:

  starting directory from which an iterative search is performed

- fun:

  string or name with the pattern to search
