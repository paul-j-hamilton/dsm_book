# Coding Platforms

R is a programming language and software environment that was designed for statistical computing and graphics. In its most basic form, R looks like the following:

```{figure} ../_build/images/R_terminal.jpg
---
height: 600px
width: 800px
---
```

R commands can be entered one-by-one into the **prompt** (*i.e.*, the ">") towards the bottom left of the window. 

This is the version of R you will get if you go to the official website and follow the steps to download R. However, this is not the way most people work with the R programming language. Instead, most people use one of the **development environments** that have been created to make it easier to write and run R code. In the same way that Microsoft Word and Apple Pages are software environments that help us write human language documents, these R development environments can help us write and run R code. Below is a brief description of the most popular development environments for R. 

## Jupyter Notebooks & Google Colab

**Jupyter** is a free, open-source application that is one of many different ways to write, run, and present R code. Jupyter notebooks are a particularly good option in business settings, because one can annotate code with nicely formatted images and text. This functionality can be used to create presentation-ready reports that combine code and its outputs with a written discussion of the results. Jupyter can be installed and run locally on your computer. 

**Google Colab** is a browser-based platform that allows one to create, share, edit, and run notebooks in the cloud. In the same way that Google Docs allows one to write and share Word documents through a browser, Google Colab allows one to write, run, and share code notebooks. Google Colab is the platform that will be used throughout this book. 

## Deepnote

Deepnote is a cloud-based data analytics platform that parallels Google Colab and RStudio Cloud. The core project environment, built around Jupyter notebooks, allows users to run Python or R code. Deepnote distinguishes itself by emphasizing overall ease of use, real-time collaboration within notebooks, user-friendly file management and commenting functionality, and an active user community. It also includes more advanced features for version control, publishing, integrations with other platforms, and the like. This makes Deepnote a good option for both novice R users and educators looking for user-friendly solutions to programming, as well as advanced users working collaboratively.

## RStudio

RStudio is another free, open-source development environment that many programmers use to develop R code. RStudio can be installed and run locally on your computer. As shown in the figure below, the standard RStudio layout consists of four main panes:

  1. ***The Source Pane*** - Here you can write multiple lines of R code and then run them all at once. You can also save all the code you write in the Source pane into an **R script (.R)** file.
  2. ***The Console Pane*** - A prompt where you can enter R commands one-by-one. This may look similar to the R Console shown above.
  3. ***The Environment & History Pane*** - In the *Environment* tab you can see the objects that exist within your working environment, and in the *History* tab you can look back through the commands you have run during the current working session. 
  4. ***The Files, Plots, Etc. Pane*** - In the *Files* tab you can see your file directory, and in the *Plots* tab you can see any plots that you create during your working session.

  ```{figure} ../_build/images/RStudio.png
---
height: 600px
width: 800px
---
```

### RStudio Cloud

If you do not want to run RStudio locally on your own computer, you can use RStudio Cloud ([here](https://rstudio.cloud/)). This browser-based service allows you to create several RStudio projects for free, but you will eventually need to pay to for your usage.

