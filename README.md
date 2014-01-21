bib: Blend It Bayes! Data Mining Toolbox (v0.0.2)
===

## Introduction

This tooblox is a collection of my favourite data mining wrapper functions. It includes:

* Data processing (normalise, split, denoising etc.)
* Feature selection (correlation, variable importance etc.)
* Feature extraction (deep learning with RBM)
* Model parameters fine-tuning (via [caret](http://caret.r-forge.r-project.org/))
* Ensembles (simple averaging, stacking with replacement and Bayesian methods)
* Data visualisation (mainly via [ggplot2](http://ggplot2.org/))
* Auto reporting (via [ggplot2](http://ggplot2.org/) and [knitr](http://yihui.name/knitr/))
* Miscellaneous wrapper functions to make life easier

Please note that this package is still at its early stage. **First stable release will be version 0.1**.

Don't forget to check out my [blog](http://blenditbayes.blogspot.co.uk/search/label/R) with random stuff about R!

## Installation

In order to install this R package directly from github, you will need to install [Hadley Wickham](http://had.co.nz/)'s [devtools](http://cran.r-project.org/web/packages/devtools/index.html) first.

```
install.packages("devtools")
```

After that, you can install this package with ...

```
devtools::install_github("bib", "woobe")
```

Enjoy!

## Example Usage

### activate_core(num_core)

Activate multiple CPU cores for parallel computation (e.g. foreach) in R.

```
activate_core(8)
```
```
Output:

Activaing parallel processing ... 8 cores have been successfully activated in 2.254 seconds.
```

### auto_load(list_pkg)

Load package and automatically install it if it has not been installed.

```
auto_load(c("caret", "randomForest"))
```
```
Output:

Checking Package: caret ... already installed.
Checking Package: randomForest ... already installed.
```

### install_key_pkg()

Check and install some of the key R packages for data mining (if they have not been installed yet).

```
install_key_pkg()
```
```
Output:

Checking Package: devtools ... already installed.
Checking Package: caret ... already installed.
Checking Package: randomForest ... already installed.
... 
```

### generate_dummy_xy(num_sample, num_feature, num_outcome)

Generate random numbers for demo purposes.

```
set.seed(1234)
xy <- generate_dummy_xy(num_sample = 1000, num_feature = 5, num_outcome = 1)
head(xy)
```
```
Output:

         x.1        x.2        x.3        x.4        x.5          y
1 -1.2070657 -1.2053334 -0.9738186 -0.3850724 -0.9628732 -0.8251442
2  0.2774292  0.3014667 -0.0996312  0.5140555 -0.8137121  0.3471682
3  1.0844412 -1.5391452 -0.1107350  0.3080042 -0.1945124 -0.9200929
4 -2.3456977  0.6353707  1.1921946  1.8391539  1.9160126 -0.2873365
5  0.4291247  0.7029518 -1.6558859  1.5934046  0.7017692 -0.5511303
6  0.5060559 -1.9058829 -1.0456433 -0.3581969  0.9705494  0.8486456
```

### start_timer(), stop_timer(time_start)

Simple stopwatch timer functions (measurement in seconds).

```
time_start <- start_timer()
```

(... do something and wait for a few seconds ...)

```
time_diff <- stop_timer(time_start)
print(time_diff)
```
```
Output:

4.364
```

