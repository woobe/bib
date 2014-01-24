bib: Feature Engineering
===

### select_feature(x, y, method = "fastest", verbose = TRUE)

Select best features in x based on known y (supervised feature selection).

In this example, we're using the dataset from Kaggle's 'Data Science London' Competition (http://www.kaggle.com/c/data-science-london-scikit-learn/data). This dataset consists of 1000 training samples with 40 features and outcomes of 0 or 1. The objective is to identify the best features out of the possible 40 based on their impact on model performance. This example is based on classification accuracy (as y is a factor here) but the function is also applicable for regression problems (i.e. when y is numerical values, the evaluation system will automatcially switch to R-squared).


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

[bib]: Activaing parallel processing ... 5 cores have been successfully activated in 1.37 seconds.
```

**Using select_feature()**
```
set.seed(1234)
feature_best <- select_feature(x_train, y_train, method = "fastest")
```
```
Output:

[bib]: Calculating variable importance score ... Duration: 5.59 seconds.
[bib]: Most important variables are:

  variables importance
1       V15  1.0000000
2       V13  0.8633318
3       V19  0.3591985
4        V7  0.3076226
5       V40  0.3053976
6       V37  0.2529182

[bib]: Evaluating the most important  4 features ... Mean Accuracy: 0.787 ... Duration: 7.2 seconds.
[bib]: Evaluating the most important  8 features ... Mean Accuracy: 0.888 ... Duration: 7.52 seconds.
[bib]: Evaluating the most important  12 features ... Mean Accuracy: 0.895 ... Duration: 8.36 seconds.
[bib]: Evaluating the most important  16 features ... Mean Accuracy: 0.913 ... Duration: 9.11 seconds.
[bib]: Evaluating the most important  20 features ... Mean Accuracy: 0.89 ... Duration: 9.19 seconds.
[bib]: Evaluating the most important  24 features ... Mean Accuracy: 0.888 ... Duration: 10.29 seconds.
[bib]: Evaluating the most important  28 features ... Mean Accuracy: 0.885 ... Duration: 11.57 seconds.
[bib]: Evaluating the most important  32 features ... Mean Accuracy: 0.872 ... Duration: 12.45 seconds.
[bib]: Evaluating the most important  36 features ... Mean Accuracy: 0.862 ... Duration: 13.61 seconds.
[bib]: Evaluating the most important  40 features ... Mean Accuracy: 0.875 ... Duration: 14.89 seconds.

[bib]: Feature selection summary
   num_features acc_rf acc_knn acc_avNNet  acc_mean decision
1             4  0.775   0.785      0.800 0.7866667         
2             8  0.870   0.905      0.890 0.8883333         
3            12  0.870   0.905      0.910 0.8950000         
4            16  0.890   0.920      0.930 0.9133333   *Best*
5            20  0.885   0.910      0.875 0.8900000         
6            24  0.875   0.915      0.875 0.8883333         
7            28  0.875   0.915      0.865 0.8850000         
8            32  0.870   0.890      0.855 0.8716667         
9            36  0.870   0.885      0.830 0.8616667         
10           40  0.870   0.905      0.850 0.8750000         

[bib]: Total number of features selected: 16 
[bib]: The name of those features are: V15 V13 V19 V7 V40 V37 V33 V29 V35 V5 V30 V24 V39 V8 V23 V2 
```