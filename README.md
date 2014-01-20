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
Output:

Checking Package: devtools ...already installed.
Checking Package: caret ...already installed.
Checking Package: randomForest ...already installed.
... 
```

### generate_dummy_xy(num_sample, num_feature, num_outcome)

Generate random numbers for demo purposes.

```
Command:

set.seed(1234)
df <- generate_dummy_xy(1000, 5, 1)
head(df)
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
Command:

time_start <- start_timer()
(... wait for a few seconds ...)

time_diff <- stop_timer(time_start)
print(time_diff)
```
```
Output:

4.364
```





