---
jupytext:
  cell_metadata_filter: -all
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.11.5
kernelspec:
  display_name: R
  language: R
  name: ir
---

# R as a Calculator

At its most basic, R can be used as a calculator. As you would expect, you can use all the standard mathematical operators:

+ Addition (`+`) & Subtraction (`-`)
+ Multiplication (`*`) & Division (`/`)
+ Exponentiation (`^`)

```{code-cell}
:tags: [remove-output]
2 + 2
```

```{code-cell}
:tags: [remove-input]
print(2 + 2)
```

```{code-cell}
:tags: [remove-output]
100 / 20
```

```{code-cell}
:tags: [remove-input]
print(100 / 20)
```

```{code-cell}
:tags: [remove-output]
3 ^ 3
```

```{code-cell}
:tags: [remove-input]
print(3 ^ 3)
```

---

<iframe src="https://hbs-data-science.shinyapps.io/r_as_a_calculator/" width="800" height="350" frameborder="0" marginheight="0" marginwidth="0"  scrolling="no">Loading…</iframe>

---

Of course, R is much more than a simple calculator! In the following sections, you'll learn the building blocks of R that we'll rely on throughout the entire course. 

