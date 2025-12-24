# get_rmd_comments

Extract all comments from an `Rmd` file

## Usage

``` r
get_rmd_comments(file, exclude = c("#SETUP"), write = TRUE)
```

## Arguments

- file:

  string indicating the file

- exclude:

  character vector with pattern to excluding some comments

- write:

  logical that indicate if returning a bullet list for printing. Default
  to `TRUE`.

## Value

list of comments
