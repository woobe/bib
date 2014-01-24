bib: Miscellaneous wrapper functions
===

### activate_core(num_core)

Activate multiple CPU cores for parallel computation (e.g. foreach) in R.

```
activate_core(8)
```
```
Output:

[bib]: Activaing parallel processing ... 8 cores have been successfully activated in 2.254 seconds.
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
...
Checking Package: rCharts ... not there ... now installing ...
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

### sys_info() and session_info()

I got fed up with Sys.info() and sessionInfo(). So here are the same functions with consistent naming convention.

```
sys_info()
```
```
Output:

                                     sysname                                      release 
                                     "Linux"                          "3.11.0-15-generic" 
                                     version                                     nodename 
"#23-Ubuntu SMP Mon Dec 9 18:17:04 UTC 2013"                                     "ubuntu" 
                                     machine                                        login 
                                    "x86_64"                                    "unknown" 
                                        user                               effective_user 
                                      "xxxx"                                       "xxxx" 
```

```
session_info()
```
```
Output:

R version 3.0.2 (2013-09-25)
Platform: x86_64-pc-linux-gnu (64-bit)

locale:
 [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
 [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8    LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] bib_0.0.2

loaded via a namespace (and not attached):
[1] tools_3.0.2
```




