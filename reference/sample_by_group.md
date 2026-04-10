# Campionamento Casuale Semplice o Stratificato

Questa funzione permette di estrarre un campione casuale di righe da un
data frame. È possibile eseguire un campionamento globale oppure un
campionamento stratificato raggruppando i dati per una o più colonne
specificate.

## Usage

``` r
sample_by_group(data, n = 1, by = NULL)
```

## Arguments

- data:

  Un `data.frame` da cui estrarre il campione.

- n:

  Un intero positivo che indica il numero di righe da estrarre per ogni
  gruppo. Se il gruppo ha meno di `n` righe, viene restituito l'intero
  gruppo. Predefinito a 1.

- by:

  Un vettore di caratteri (es. `"colonna_A"` o `c("col1", "col2")`) che
  specifica le colonne di raggruppamento. Se `NULL` (predefinito), il
  campionamento avviene sull'intero dataset.

## Value

Un `data.frame` contenente le righe campionate, con i nomi delle righe
(`rownames`) resettati.

## Details

La funzione utilizza internamente
[`split`](https://rdrr.io/r/base/split.html) e
[`lapply`](https://rdrr.io/r/base/lapply.html) per gestire i
sottogruppi. Se un gruppo risultante è vuoto, non contribuirà al
risultato finale.

## Examples

``` r
# Campionamento di 2 righe dal dataset iris (globale)
sample_by_group(iris, n = 2)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 1          5.1         2.5          3.0         1.1 versicolor
#> 2          5.4         3.7          1.5         0.2     setosa

# Campionamento di 1 riga per ogni Specie in iris
sample_by_group(iris, n = 1, by = "Species")
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 1          5.1         3.5          1.4         0.2     setosa
#> 2          6.6         2.9          4.6         1.3 versicolor
#> 3          6.2         3.4          5.4         2.3  virginica

# Campionamento stratificato su più colonne (se applicabile)
# sample_by_group(mtcars, n = 2, by = c("cyl", "am"))
```
