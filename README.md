bib
===

"**B**lend **I**t **B**ayes!" Toolbox - A Collection of My Favourite Data Mining Algorithms and Routines.


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

## My Blog

Don't forget to check out my [blog](http://blenditbayes.blogspot.co.uk/search/label/R) with random stuff about R!

## Example Usage


### activate_core(num_core)

Activate multiple CPU cores for parallel computation (e.g. foreach) in R.

```
Command:
activate_core(8)
```
```
Output:
Activaing parallel processing ... 8 cores have been successfully activated in 2.254 seconds.
```

### install_key_packages()

Check and install some of the key R packages for data mining (if they have not been installed yet).

```
Command:
install_key_packages()
```
```
Outputs:
Checking Package: devtools ...already installed.
Checking Package: caret ...already installed.
Checking Package: randomForest ...already installed.
... 
```




