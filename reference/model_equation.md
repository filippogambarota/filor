# model_equation

print model equation with generic or actual values thanks to
https://stats.stackexchange.com/a/433060 for the equation part. I've
added the printing and prediction

## Usage

``` r
model_equation(model, newdata = NULL, ..., only_print = FALSE)
```

## Arguments

- model:

  a fitted glm/lm object

- newdata:

  a list or dataframe with values where evaluate the prediction

- ...:

  additional arguments to
  [`predict()`](https://rdrr.io/r/stats/predict.html)

- only_print:

  logical. TRUE if returning the equation as string
