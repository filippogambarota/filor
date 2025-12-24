# epredict

improved predict function, it works as the standard predict function but
prints the model equation that is supporting the current prediction

## Usage

``` r
epredict(model, newdata, ...)
```

## Arguments

- model:

  a fitted glm/lm object

- newdata:

  a list or dataframe with values where evaluate the prediction

- ...:

  additional arguments to
  [`predict()`](https://rdrr.io/r/stats/predict.html)
