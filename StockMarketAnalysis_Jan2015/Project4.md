---
title: "Project4"
author: "Oleksandr Bugrimenko"
date: "January 18, 2016"
output: html_document
---



## Objective

"In stock market, technical analysis is the study of market action, primarily through the use of charts, for the purpose of forecasting future price trends. In its purest form, technical analysis considers only the actual price behavior of the market or instrument, based on the premise that price reflects all relevant factors before an investor becomes aware of them through other channels. Technicians say that a market's price reflects all relevant information, so their analysis looks more at "internals" than at "externals" such as news events. Price action also tends to repeat itself because investors collectively tend toward patterned behavior - hence technicians' focus on identifiable trends and conditions." (source: [stock2own.com](http://www.stock2own.com/StockMarket/Theory/TechnicalAnalysis))

In this project I want to analyze relationship between technical indicators, such as moving averages, MACD and RSI, and makret price of a stock. In other words, I want to validate the premise that future price of a stock can be predicted by technical indicators. In particular, I'm interested to discover a correlation between technical indicators and a short term (1-2 weeks) price moves.

## Data Set

The data set used for this project, contains the list of the majority of US stocks traded on US Stock Exchanges as of December 31st, 2015. List of stocks is limited and includes only stocks that close market day of December 31st, 2015 with a price of $10 per share or higher. It filters out "penny stocks", which are extremely risky and therefore more volatile.

The data includes some basic fundamental characteristics as well as prices and technical indicators as of market close on December 31st, 2015. All fundamental characteristics provided as of latest available financial statement.

Last 4 columns show prices as of market close on the first two Fridays of 2016, i.e. as of January 7th and January 14th of 2016. It allows to compute a short term price moves in a form of weekly gain or loss for the first two weeks of 2016.

Data set described in the S2O_StockList.rd file and has the following structure:

```r
s2o_stocks <- read.csv("S2O_StockList.csv", row.names=1, stringsAsFactors=FALSE)
str(s2o_stocks)
```

```
## 'data.frame':	2831 obs. of  52 variables:
##  $ CountryCode           : chr  "US" "US" "US" "US" ...
##  $ Identifier            : chr  "A" "AAC" "AACAY" "AAL" ...
##  $ Name                  : chr  "Agilent Technologies Inc." "AAC Holdings, Inc." "AAC Technologies Holdings Inc." "American Airlines Group Inc." ...
##  $ Exchange              : chr  "NYSE" "NYSE" "OTC Markets" "NASDAQ" ...
##  $ Sector                : chr  "Healthcare" "Healthcare" "Conglomerates" "Utilities" ...
##  $ SPDRIndx              : chr  "XLV" "" "" "XLU" ...
##  $ MktCapType            : chr  "Large" "Small" "Large" "Large" ...
##  $ FS_AsOfDate           : chr  "10/31/2015" "9/30/2015" "12/31/2014" "9/30/2015" ...
##  $ FS_BVPS               : chr  "12.36" "1.36" "10.58" "7.13" ...
##  $ FS_EPS                : num  1.2 0.61 3.62 6.96 10.06 ...
##  $ FS_DivRate            : chr  "0.46" "NULL" "1.24" "0.4" ...
##  $ FS_GrowthGrade        : num  0 79.8 81.3 53.7 0 ...
##  $ FS_GrowthGradeYOY     : num  7.37 70.41 68.24 27.02 0 ...
##  $ Ratio_PE              : num  33.8 31.25 17.96 5.91 1.71 ...
##  $ Ratio_Beta            : chr  "1.22" "1.73" "0.34" "3.85" ...
##  $ Ratio_PEG             : chr  "-1" "0.2586" "0.645" "0" ...
##  $ Ratio_PEGY            : chr  "-1" "0.2586" "0.6036" "0" ...
##  $ Ratio_Current         : chr  "3.7766" "4.7661" "0" "0.9015" ...
##  $ Ratio_Quick           : chr  "2.9211" "4.6796" "0" "0.2634" ...
##  $ Ratio_DebtToFCF       : chr  "4.2112" "-14.5888" "0" "-8.4487" ...
##  $ Ratio_ROIC            : chr  "0.0655" "0.0924" "0.237" "0.0798" ...
##  $ Eval_ValuePrice_M     : num  6.11 38.88 576.43 419.76 163.94 ...
##  $ Eval_IRT_M            : num  29.01 9.2 6.7 2.81 1.09 ...
##  $ Eval_GrahamNumber     : chr  "18.268" "4.3204" "29.3554" "33.4149" ...
##  $ MktPrice_Date         : chr  "12/31/2015" "12/31/2015" "12/31/2015" "12/31/2015" ...
##  $ MktPrice_Close        : num  41.8 19.1 65 42.4 17.2 ...
##  $ MktPrice_Change       : num  -0.36 0.51 0.4 -0.45 -0.39 -0.16 -0.64 -0.45 -0.89 -2.06 ...
##  $ MktPrice_Volume       : int  1449300 143900 1900 6788900 30700 549200 103200 211100 758300 40635300 ...
##  $ MktPrice_VolumeAvg    : int  3294750 243523 10177 7282623 56600 725513 245447 180120 1216273 39398917 ...
##  $ MktPrice_52Wk_Lo      : num  34.7 19.9 48.1 37.6 11.3 ...
##  $ MktPrice_52Wk_Hi      : num  43 44.7 73 55.5 327.2 ...
##  $ MA10                  : num  41.5 19.9 65.2 42.8 17.2 ...
##  $ MA10_ChangePcnt       : num  0.0009 -0.0172 -0.0018 -0.002 0.0171 -0.002 0.0014 -0.0007 -0.0068 -0.0056 ...
##  $ MA30                  : num  40.9 22.1 68.4 42.8 15.1 ...
##  $ MA30_ChangePcnt       : num  0.0028 -0.0052 -0.0031 0 0.0102 -0.0017 0.0009 -0.0006 -0.0029 -0.0025 ...
##  $ MA50                  : num  39.6 22.8 67.1 43.8 18.6 ...
##  $ MA50_ChangePcnt       : num  0.0028 -0.0078 0.0012 -0.0011 -0.012 -0.0125 -0.0012 0.0018 -0.0051 -0.0015 ...
##  $ MA150                 : num  38.5 28.8 60.4 42.1 67.1 ...
##  $ MA150_ChangePcnt      : num  0.0001 -0.0046 0.001 0 -0.015 -0.0025 -0.0002 -0.0001 -0.0001 -0.0014 ...
##  $ MA200                 : num  39.4 29.8 60.5 43.8 102.4 ...
##  $ MA200_ChangePcnt      : num  0 -0.0018 -0.0003 -0.0013 -0.0094 -0.0009 0.0011 0.0002 0 -0.001 ...
##  $ RSI                   : num  56 30.7 38.6 43.1 52.4 ...
##  $ RSI_ChangePcnt        : num  -0.1051 0.5708 0.1799 -0.0913 -0.0416 ...
##  $ SlowStoch_K           : num  0.8579 0.0814 0.0977 0.5506 0.7596 ...
##  $ SlowStoch_D           : num  0.88 0.1059 0.0846 0.5279 0.8556 ...
##  $ SlowStoch_ChangePcnt  : num  -0.0214 0.3523 0.9004 -0.0312 -0.0356 ...
##  $ MACD                  : num  0.0299 -0.2173 -0.0358 -0.0004 0.3963 ...
##  $ MACD_ChangePcnt       : num  -0.636 0.363 0.699 -1.005 -0.386 ...
##  $ Jan_07_MktPrice_Close : num  39 18.2 58.1 40.5 15.5 ...
##  $ Jan_07_MktPrice_Volume: int  3502100 97600 2600 11282600 94400 891200 372100 152900 1342600 80229800 ...
##  $ Jan_14_MktPrice_Close : num  37.6 17.3 57.3 40.5 17 ...
##  $ Jan_14_MktPrice_Volume: int  2893300 210600 15500 11714900 26300 643900 259100 126600 1109900 62424200 ...
```

### Data Summary


```r
summary(s2o_stocks)
```

```
##  CountryCode         Identifier            Name          
##  Length:2831        Length:2831        Length:2831       
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##    Exchange            Sector            SPDRIndx        
##  Length:2831        Length:2831        Length:2831       
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##   MktCapType        FS_AsOfDate          FS_BVPS         
##  Length:2831        Length:2831        Length:2831       
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##      FS_EPS          FS_DivRate        FS_GrowthGrade   FS_GrowthGradeYOY
##  Min.   :    0.01   Length:2831        Min.   :  0.00   Min.   : 0.00    
##  1st Qu.:    0.88   Class :character   1st Qu.: 20.52   1st Qu.:20.08    
##  Median :    1.63   Mode  :character   Median : 41.98   Median :32.81    
##  Mean   :   12.55                      Mean   : 41.89   Mean   :33.12    
##  3rd Qu.:    2.89                      3rd Qu.: 62.51   3rd Qu.:44.99    
##  Max.   :13852.27                      Max.   :100.00   Max.   :93.90    
##     Ratio_PE          Ratio_Beta         Ratio_PEG        
##  Min.   :   0.5337   Length:2831        Length:2831       
##  1st Qu.:  13.9960   Class :character   Class :character  
##  Median :  19.5133   Mode  :character   Mode  :character  
##  Mean   :  37.7833                                        
##  3rd Qu.:  30.5931                                        
##  Max.   :1793.6667                                        
##   Ratio_PEGY        Ratio_Current      Ratio_Quick       
##  Length:2831        Length:2831        Length:2831       
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##  Ratio_DebtToFCF     Ratio_ROIC        Eval_ValuePrice_M    Eval_IRT_M    
##  Length:2831        Length:2831        Min.   :    0.00   Min.   : 0.000  
##  Class :character   Class :character   1st Qu.:    6.86   1st Qu.: 8.366  
##  Mode  :character   Mode  :character   Median :   16.36   Median :11.076  
##                                        Mean   :  118.20   Mean   :14.209  
##                                        3rd Qu.:   39.68   3rd Qu.:15.307  
##                                        Max.   :97133.20   Max.   :99.000  
##  Eval_GrahamNumber  MktPrice_Date      MktPrice_Close     
##  Length:2831        Length:2831        Min.   :    10.02  
##  Class :character   Class :character   1st Qu.:    18.63  
##  Mode  :character   Mode  :character   Median :    30.57  
##                                        Mean   :   189.47  
##                                        3rd Qu.:    53.58  
##                                        Max.   :197800.00  
##  MktPrice_Change     MktPrice_Volume    MktPrice_VolumeAvg
##  Min.   :-2281.000   Min.   :       0   Min.   :     107  
##  1st Qu.:   -0.630   1st Qu.:   51950   1st Qu.:   63996  
##  Median :   -0.280   Median :  232400   Median :  281887  
##  Mean   :   -2.013   Mean   :  766610   Mean   : 1076697  
##  3rd Qu.:   -0.030   3rd Qu.:  728400   3rd Qu.:  970222  
##  Max.   :    8.330   Max.   :46594300   Max.   :71855807  
##  MktPrice_52Wk_Lo    MktPrice_52Wk_Hi         MA10          
##  Min.   :     1.00   Min.   :    10.38   Min.   :     9.42  
##  1st Qu.:    15.62   1st Qu.:    24.57   1st Qu.:    18.64  
##  Median :    26.03   Median :    39.58   Median :    30.65  
##  Mean   :   111.01   Mean   :   233.33   Mean   :   190.50  
##  3rd Qu.:    45.03   3rd Qu.:    66.81   3rd Qu.:    53.42  
##  Max.   :196005.00   Max.   :224675.00   Max.   :199114.50  
##  MA10_ChangePcnt           MA30           MA30_ChangePcnt     
##  Min.   :-0.0400000   Min.   :     8.44   Min.   :-0.0302000  
##  1st Qu.:-0.0028000   1st Qu.:    18.80   1st Qu.:-0.0019000  
##  Median :-0.0007000   Median :    31.05   Median :-0.0003000  
##  Mean   :-0.0003408   Mean   :   192.22   Mean   :-0.0003416  
##  3rd Qu.: 0.0017000   3rd Qu.:    54.04   3rd Qu.: 0.0011000  
##  Max.   : 0.0783000   Max.   :200910.60   Max.   : 0.0405000  
##       MA50           MA50_ChangePcnt          MA150          
##  Min.   :     7.55   Min.   :-0.0398000   Min.   :     2.71  
##  1st Qu.:    18.98   1st Qu.:-0.0017000   1st Qu.:    19.50  
##  Median :    31.35   Median :-0.0002000   Median :    32.28  
##  Mean   :   193.08   Mean   :-0.0004707   Mean   :   195.32  
##  3rd Qu.:    54.20   3rd Qu.: 0.0010000   3rd Qu.:    54.91  
##  Max.   :201946.90   Max.   : 0.0345000   Max.   :204735.60  
##  MA150_ChangePcnt         MA200           MA200_ChangePcnt   
##  Min.   :-0.0426000   Min.   :     2.65   Min.   :-0.262400  
##  1st Qu.:-0.0013000   1st Qu.:    19.91   1st Qu.:-0.001000  
##  Median :-0.0003000   Median :    32.81   Median :-0.000200  
##  Mean   :-0.0004859   Mean   :   198.71   Mean   :-0.000392  
##  3rd Qu.: 0.0005000   3rd Qu.:    55.55   3rd Qu.: 0.000400  
##  Max.   : 0.0345000   Max.   :207714.80   Max.   : 0.027800  
##       RSI        RSI_ChangePcnt      SlowStoch_K      SlowStoch_D    
##  Min.   : 0.00   Min.   :-0.50520   Min.   :0.0000   Min.   :0.0118  
##  1st Qu.:39.16   1st Qu.:-0.18300   1st Qu.:0.4361   1st Qu.:0.4326  
##  Median :46.19   Median :-0.10590   Median :0.6414   Median :0.6187  
##  Mean   :47.36   Mean   :-0.08466   Mean   :0.6016   Mean   :0.6010  
##  3rd Qu.:54.34   3rd Qu.:-0.01255   3rd Qu.:0.7893   3rd Qu.:0.7979  
##  Max.   :96.45   Max.   : 1.67530   Max.   :1.0000   Max.   :1.0000  
##  SlowStoch_ChangePcnt      MACD          MACD_ChangePcnt    
##  Min.   :-1.00000     Min.   :-11.0949   Min.   :-132.7540  
##  1st Qu.:-0.11142     1st Qu.: -0.0016   1st Qu.:  -0.6324  
##  Median :-0.04661     Median :  0.0581   Median :  -0.3252  
##  Mean   :-0.02585     Mean   :  0.1268   Mean   :  -0.6957  
##  3rd Qu.: 0.02553     3rd Qu.:  0.1549   3rd Qu.:  -0.0961  
##  Max.   : 5.88235     Max.   : 57.6074   Max.   : 155.9407  
##  Jan_07_MktPrice_Close Jan_07_MktPrice_Volume Jan_14_MktPrice_Close
##  Min.   :     8.18     Min.   :      100      Min.   :     7.27    
##  1st Qu.:    17.75     1st Qu.:    66200      1st Qu.:    17.25    
##  Median :    28.76     Median :   341700      Median :    28.05    
##  Mean   :   185.57     Mean   :  1568085      Mean   :   182.19    
##  3rd Qu.:    50.70     3rd Qu.:  1336050      3rd Qu.:    49.48    
##  Max.   :195580.00     Max.   :115361300      Max.   :192250.00    
##  Jan_14_MktPrice_Volume
##  Min.   :      100     
##  1st Qu.:    69200     
##  Median :   354100     
##  Mean   :  1635207     
##  3rd Qu.:  1362000     
##  Max.   :125143800
```

### Data Overview

Each stock characterized by it's price and trading volume. Trading volume shows how many shares have changed hands (were bought and sold) during the trading day. Volume shows how liquid the stock is. In order to make a proper conclusions we should focus on liquid stocks, those that trade a lot every day. 


```r
summary(s2o_stocks$MktPrice_Close)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
##     10.02     18.63     30.57    189.50     53.58 197800.00
```

```r
summary(s2o_stocks$MktPrice_VolumeAvg)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##      107    64000   281900  1077000   970200 71860000
```

Price ranges from $10.02 to $197,800 per share and avergae volume is in range from 107 to 71 mln shares.


```r
library(ggplot2)
ggplot(aes(x = MktPrice_VolumeAvg, y = MktPrice_Close), data = s2o_stocks) + 
  geom_point(alpha = 0.5, position = 'jitter') + 
  ggtitle('Price by Volume')
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

The variety is enormous, therefore a logarithmic scale seem appropriate for the plot.


```r
ggplot(aes(x = MktPrice_VolumeAvg, y = MktPrice_Close), data = s2o_stocks) + 
  geom_point(alpha = 0.5, position = 'jitter') +
  scale_x_log10() +
  scale_y_log10() + 
  ggtitle('Price by Volume (log scale)')
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

As expected, the really highly priced stocks have relatively small trading volume - perhaps not so many people can buy a stock for $197,000 per share. 

In order to minimize bias, it seems reasonable to exclude less liquid stocks from the analysis. I want to get rid of the 1st quantile of data and put a limit of 64,000 shares as a minimum accepted value for an average trading volume. Let's see how this may affect overall stocks diversity by two major classifications: market capitalization and sector.


```r
library(gridExtra)
p1 <- ggplot(aes(x = MktCapType, y = MktPrice_Close), data = s2o_stocks) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  scale_y_log10() +
  ggtitle('Price by Market Cap')
p2 <- ggplot(aes(x = MktCapType, y = MktPrice_Close), data = subset(s2o_stocks, MktPrice_VolumeAvg > 64000)) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  ggtitle('Price by Market Cap (limited)')
grid.arrange(p1, p2, ncol=2)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

It definitely changed the picture - it almost wiped out market capitalization category "micro" and significantly reduced "small" stocks population, however it also eliminated big outliers with prices in $100,000 range.


```r
p1 <- ggplot(aes(x = substr(Sector,0,3), y = MktPrice_Close), data = s2o_stocks) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  scale_y_log10() +
  xlab("Sector") +
  ggtitle('Price by Market Sector')
p2 <- ggplot(aes(x = substr(Sector,0,3), y = MktPrice_Close), data = subset(s2o_stocks, MktPrice_VolumeAvg > 64000)) + 
  geom_point(alpha = 0.5, size = 1, position = 'jitter') +
  xlab("Sector") +
  ggtitle('Price by Market Sector (limited)')
grid.arrange(p1, p2, ncol=2)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 

Sector presentation seems OK and stocks that do not have sector classification are among those that disappeared the most from the plot. Perhaps not liquid stocks do not have as good data quality as those that traded a lot. 

## Assumptions and Data Transformations

The objective of this project is to discover relationship between stock price change and technical indicators. Each group of indicators usually used in a certain specific way by market technitians. In this project I will focus on Moving Averages, RSI and MACD. 

### Moving Averages (MA)

Data set contains information about 5 moving averages:

* short term moving averages: MA10 and MA30 (10 and 30 days moving averages)
* medium term: MA50
* long term: MA150 and MA200

In general we are not interested in absolute values of the MA, instead technical analysts are focusing on moving average relative to the price line or to other MAs. In other words, in order to identify the trend we want to know if the price is above or below the moving average and how moving averages are positioned against each other (above, below, crossed over). (source: [stock2own.com](http://www.stock2own.com/StockMarket/Theory/TechnicalAnalysis/Moving-Average))

Another important thing to consider is absolute values of the MA will not help much. We have to convert them to standard values - percent change, for example. 


```r
# -- MA changes as a percentage to the price
s2o_stocks$MA10_Price = round((s2o_stocks$MktPrice_Close - s2o_stocks$MA10) / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$MA30_Price = round((s2o_stocks$MktPrice_Close - s2o_stocks$MA30) / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$MA50_Price = round((s2o_stocks$MktPrice_Close - s2o_stocks$MA50) / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$MA150_Price = round((s2o_stocks$MktPrice_Close - s2o_stocks$MA150) / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$MA200_Price = round((s2o_stocks$MktPrice_Close - s2o_stocks$MA200) / s2o_stocks$MktPrice_Close, digits = 4)

# -- comparing shorter MA to longer MA between MA10-MA50, MA50-MA200
s2o_stocks$MA10_MA50 = round((s2o_stocks$MA10 - s2o_stocks$MA50) / s2o_stocks$MA10, digits = 4)
s2o_stocks$MA10_MA200 = round((s2o_stocks$MA10 - s2o_stocks$MA200) / s2o_stocks$MA10, digits = 4)
s2o_stocks$MA50_MA200 = round((s2o_stocks$MA50 - s2o_stocks$MA200) / s2o_stocks$MA50, digits = 4)
```

### RSI

"The RSI is classified as a momentum oscillator, measuring the velocity and magnitude of directional price movements. Momentum is the rate of the rise or fall in price. ... The RSI is most typically used on a 14 day timeframe, measured on a scale from 0 to 100, with high and low levels marked at 70 and 30, respectively. Shorter or longer timeframes are used for alternately shorter or longer outlooks. More extreme high and low levels — 80 and 20, or 90 and 10 — occur less frequently but indicate stronger momentum.

Traditionally, RSI readings greater than the 70 level are considered to be in overbought territory, and RSI readings lower than the 30 level are considered to be in oversold territory. In between the 30 and 70 level is considered neutral, with the 50 level a sign of no trend."
(source: [stock2own.com](http://www.stock2own.com/StockMarket/Theory/TechnicalAnalysis/RSI))

Therefore we will compute RSIV as a difference between RSI and 50:


```r
s2o_stocks$RSIV = round((s2o_stocks$RSI - 50) / 50, digits = 4)
```

### MACD

"The MACD-Histogram represents the difference between the MACD and its trigger line, the 9-day EMA of MACD. The plot of this difference is presented as a histogram, making centerline crossovers and divergences easily identifiable. A centerline crossover for the MACD-Histogram is the same as a moving average crossover for MACD." (source: (stock2own.com)[http://www.stock2own.com/StockMarket/Theory/TechnicalAnalysis/MACD])

The MACD value in a dataset is actually a MACD histogram value, therefore no modifications required for MACD.

### Weekly Price Change

Finally, we have to compute weekly price change for the two first weeks of January.


```r
# current price change
s2o_stocks$Price = round(s2o_stocks$MktPrice_Change / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$Volume = round((s2o_stocks$MktPrice_Volume - s2o_stocks$MktPrice_VolumeAvg) / s2o_stocks$MktPrice_VolumeAvg, digits = 4)
# future price change
s2o_stocks$Wk1_Price = round((s2o_stocks$Jan_07_MktPrice_Close - s2o_stocks$MktPrice_Close) / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$Wk1_Volume = round((s2o_stocks$Jan_07_MktPrice_Volume - s2o_stocks$MktPrice_VolumeAvg) / s2o_stocks$MktPrice_VolumeAvg, digits = 4)
s2o_stocks$Wk2_Price = round((s2o_stocks$Jan_14_MktPrice_Close - s2o_stocks$MktPrice_Close) / s2o_stocks$MktPrice_Close, digits = 4)
s2o_stocks$Wk2_Volume = round((s2o_stocks$Jan_14_MktPrice_Volume - s2o_stocks$MktPrice_VolumeAvg) / s2o_stocks$MktPrice_VolumeAvg, digits = 4)
```

### Final Recordset

Let's get rid of all unneccessary data and rename column names to make them shorter and easier to use. Note though that all values in this final dataset are not absolute values - they are percent of change of a value or percent of the difference between two values.


```r
# final data set
stocks <- subset(s2o_stocks, MktPrice_VolumeAvg > 64000, 
    select=c(InstrID, Sector, MktCapType, FS_EPS, FS_GrowthGrade, FS_GrowthGradeYOY,
        MA10_Price, MA30_Price, MA50_Price, MA150_Price, MA200_Price, 
        MA10_MA50, MA10_MA200, MA50_MA200, RSIV, MACD,  
        Price, Volume, Wk1_Price, Wk1_Volume, Wk2_Price, Wk2_Volume))
```

```
## Error in eval(expr, envir, enclos): object 'InstrID' not found
```

```r
# change headers
names(stocks) <- c('InstrID', 'Sector', 'MktCap', 'EPS', 'GrGrade', 'GrGradeYOY',
                   'MA10_Price', 'MA30_Price', 'MA50_Price', 'MA150_Price', 'MA200_Price', 
                   'MA10_MA50', 'MA10_MA200', 'MA50_MA200', 'RSI', 'MACD',  
                   'Price', 'Volume', 'Wk1_Price', 'Wk1_Volume', 'Wk2_Price', 'Wk2_Volume')
```

```
## Error in names(stocks) <- c("InstrID", "Sector", "MktCap", "EPS", "GrGrade", : object 'stocks' not found
```

Data Set Structure

```r
str(stocks)
```

```
## Error in str(stocks): object 'stocks' not found
```

Data Summary

```r
summary(stocks)
```

```
## Error in summary(stocks): object 'stocks' not found
```

## Analysis

## Final Plots and Summary

## Reflection
