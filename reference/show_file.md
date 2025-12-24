# show_file

show_file

## Usage

``` r
show_file(file, how = c("bare", "generic", "code"), engine = NULL)
```

## Arguments

- file:

  string that indicate the path and filename

- how:

  if bare, the file is printed as it is. With generic the file is
  embedded into backticks. If code, the file is embedded with backticks
  and an engine. If not specified the default engine is R.

## Value

Invisibly return the file lines and print the content
