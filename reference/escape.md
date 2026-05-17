# Escape Text for a Target Output Format

Escapes special characters in a character vector so that the text can be
safely inserted into Markdown, LaTeX, or HTML output.

## Usage

``` r
escape(x, fmt = c("markdown", "tex", "html"))
```

## Arguments

- x:

  A character vector, or an object coercible to character.

- fmt:

  Output format. One of:

  \`"markdown"\`

  :   Escape Markdown-sensitive characters in ordinary prose.

  \`"tex"\`

  :   Escape LaTeX-sensitive characters.

  \`"html"\`

  :   Escape HTML-sensitive characters.

## Value

A character vector of the same length as \`x\`.

## Details

This function is intended for escaping plain text before wrapping it in
lightweight formatting helpers such as \[bold()\], \[italic()\], or
\[code()\].

For Markdown, this function performs conservative escaping of characters
that commonly have syntactic meaning, including emphasis markers,
brackets, braces, list markers, pipes, and backslashes.

For LaTeX, this function escapes the standard special characters: \`\\,
\`\`, \`\`, \`#\`, \`\$\`, \`

For HTML, this function escapes: \`&\`, \`\<\`, \`\>\`, \`"\`, and
\`'\`.

Markdown inline code spans are a special case. When formatting code,
prefer \[code()\] rather than calling \`escape(x, "markdown")\`
directly, because inline code delimiters need to be chosen according to
the content.

## Examples

``` r
escape("a_b * c", "markdown")
#> [1] "a\\_b \\* c"
escape("50% of x_1", "tex")
#> [1] "50\\\\% of x\\\\_1"
escape("<span class='x'>A & B</span>", "html")
#> [1] "&lt;span class=&#39;x&#39;&gt;A &amp; B&lt;/span&gt;"
```
