bib: Feature Engineering
===

### select_feature(x, y, method = "fastest", verbose = TRUE)

Select best features in x based on known y (supervised feature selection).

In this example, we're using the dataset from Kaggle's 'Data Science London' Competition (http://www.kaggle.com/c/data-science-london-scikit-learn/data). This dataset consists of 1000 training samples with 40 features and outcomes of 0 or 1. The objective is to identify the best features out of the possible 40 based on their impact on model performance. This example is based on classification accuracy (as y is a factor here) but the function is also applicable for regression problems (i.e. when y is numerical values, the evaluation system will automatcially switch to R-squared).

Available methods are "fastest", "fast" and "normal". The key differences are the number of trees in Random Forest and the settings of cross-validation. In theory, "normal" is more robust than the rest but I find that "fastest" is good enough and a lot more practical.


**Load example dataset from author's bitbucket**
```
load(url("http://woobe.bitbucket.org/data/bib/data_science_london.rda"))
```

**Activate multiple cores for parallel processing (I use 5 in this case)**
```
activate_core(5)
```
```
Output:

[bib]: Activaing parallel processing ... 5 cores have been successfully activated in 1.65 seconds.
```

**Using select_feature()**
```
set.seed(1234)
feature_best <- select_feature(x_train, y_train, method = "fastest")
```
```
Output:

[bib]: Calculating variable importance score ... Duration: 5.8 seconds.
[bib]: Most important variables are:

  variables importance
1       V15  1.0000000
2       V13  0.8730826
3       V19  0.3343729
4        V7  0.3047871
5       V40  0.3045897
6       V37  0.2681036

[bib]: Evaluating the most important  4 features ... Mean Accuracy: 0.78 ... Duration: 7.36 seconds.
[bib]: Evaluating the most important  8 features ... Mean Accuracy: 0.882 ... Duration: 8.05 seconds.
[bib]: Evaluating the most important  12 features ... Mean Accuracy: 0.892 ... Duration: 8.19 seconds.
[bib]: Evaluating the most important  16 features ... Mean Accuracy: 0.905 ... Duration: 9.08 seconds.
[bib]: Evaluating the most important  20 features ... Mean Accuracy: 0.892 ... Duration: 9.84 seconds.
[bib]: Evaluating the most important  24 features ... Mean Accuracy: 0.89 ... Duration: 11.04 seconds.
[bib]: Evaluating the most important  28 features ... Mean Accuracy: 0.878 ... Duration: 11.8 seconds.
[bib]: Evaluating the most important  32 features ... Mean Accuracy: 0.877 ... Duration: 13.21 seconds.
[bib]: Evaluating the most important  36 features ... Mean Accuracy: 0.875 ... Duration: 13.75 seconds.
[bib]: Evaluating the most important  40 features ... Mean Accuracy: 0.878 ... Duration: 14.44 seconds.

[bib]: Feature selection summary
   num_features acc_rf acc_knn acc_avNNet acc_mean decision
1             4  0.765   0.785      0.790    0.780         
2             8  0.855   0.905      0.885    0.882         
3            12  0.875   0.890      0.910    0.892         
4            16  0.895   0.910      0.910    0.905   *Best*
5            20  0.890   0.910      0.875    0.892         
6            24  0.875   0.910      0.885    0.890         
7            28  0.885   0.895      0.855    0.878         
8            32  0.885   0.885      0.860    0.877         
9            36  0.870   0.900      0.855    0.875         
10           40  0.865   0.925      0.845    0.878         

[bib]: Total number of features selected: 16 
[bib]: The name of those features are: V15 V13 V19 V7 V40 V37 V33 V29 V35 V5 V24 V30 V39 V8 V23 V2 
```

**Reduce dimensionality of x_train and x_test using the best features**
```
x_train <- x_train[, feature_best]
x_test <- x_test[, feature_best]
```


