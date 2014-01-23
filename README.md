bib: Blend It Bayes! Data Mining Toolbox (v0.0.2)
===

## Introduction

This tooblox is a collection of my favourite data mining wrapper functions. It includes:

* Data processing (normalise, split, denoising etc.)
* Feature selection (correlation, variable importance etc.)
* Feature extraction (deep learning with RBM)
* Model parameters fine-tuning (via <a href="http://caret.r-forge.r-project.org" target="_blank">caret</a>)
* Ensembles (simple averaging, stacking with replacement and Bayesian methods)
* Data visualisation (mainly via <a href="http://ggplot2.org/" target="_blank">ggplot2</a>)
* Auto reporting (via <a href="http://ggplot2.org/" target="_blank">ggplot2</a> and <a href="http://yihui.name/knitr/" target="_blank">knitr</a>)
* Miscellaneous wrapper functions to make life easier ([see example usage](README_misc.md))

Please note that this package is still at its early stage. **First stable release will be version 0.1**.

Don't forget to check out my <a href="http://blenditbayes.blogspot.co.uk/search/label/R" target="_blank">blog</a> with random stuff about R!

## Installation

In order to install this R package directly from github, you will need to install <a href="http://had.co.nz/" target="_blank">Hadley Wickham</a>'s <a href="http://cran.r-project.org/web/packages/devtools/index.html" target="_blank">devtools</a> first.

```
install.packages("devtools")
```

After that, you can install this package with ...

```
devtools::install_github("bib", "woobe")
```

Enjoy!

