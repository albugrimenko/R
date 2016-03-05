\name{S2O_Stocks}1
\alias{US Stock prices and technical indicators}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
The data give the list of the majority of US stocks traded on US Stock Exchanges as of December 31st, 2015. The data includes some basic fundamental characteristics as well as prices and technical indicators as of market close on December 31st, 2015.
}
\usage{data("S2O_Stocks")}
\format{
  A data frame with 2,831 observations on the following 53 variables.
  \describe{
    \item{\code{InstrID}}{unique stock identifier (int)}
    \item{\code{CountryCode}}{country code (ISO standard 2 character code)}
    \item{\code{Identifier}}{stock unique identifier, ticker or symbol (str)}
    \item{\code{Name}}{business name (str)}
    \item{\code{Exchange}}{stock exchange, where stock is registered (str)}
    \item{\code{Sector}}{market sector (str)}
    \item{\code{SPDRIndx}}{SPDR industry symbol, if stock included into SPDR index (str)}
    \item{\code{MktCapType}}{market capitalization category (str)}
    \item{\code{FS_AsOfDate}}{date of the latest available financial statement (date)}
    \item{\code{FS_BVPS}}{book value per share (float)}
    \item{\code{FS_EPS}}{earnings per share (float)}
    \item{\code{FS_DivRate}}{dividend rate (float). Empty if company does not pay dividends}
    \item{\code{FS_GrowthGrade}}{weights historical growth rate for five major financial metrics (Equity, EPS, Sales, Free Cash Flow, Cash from Operating Activity and ROIC) and year (float in a range 0..100)}
    \item{\code{FS_GrowthGradeYOY}}{weights year-over-year growth rate for five major financial metrics (Equity, EPS, Sales, Free Cash Flow, Cash from Operating Activity and ROIC) and year (float in a range 0..100)}
    \item{\code{Ratio_PE}}{price per earnings (float)}
    \item{\code{Ratio_Beta}}{beta - a measure of a stock's price volatility (float)}
    \item{\code{Ratio_PEG}}{price-to-earnings ratio divided by the growth rate of its earnings (float)}
    \item{\code{Ratio_PEGY}}{price-to-earnings ratio divided by the growth rate of its earnings plus dividend yield (float)}
    \item{\code{Ratio_Current}}{current (float)}
    \item{\code{Ratio_Quick}}{quick ratio (float)}
    \item{\code{Ratio_DebtToFCF}}{debt to free cash flow ratio (float)}
    \item{\code{Ratio_ROIC}}{return on invested capital (float)}
    \item{\code{Eval_ValuePrice_M}}{stock2own's value price computed using moderate projection (float, USD)}
    \item{\code{Eval_IRT_M}}{investment recovery time computed using moderate projection (float, years)}
    \item{\code{Eval_GrahamNumber}}{Graham's number (float, USD)}
    \item{\code{MktPrice_Date}}{market price date (date)}
    \item{\code{MktPrice_Close}}{close market price as of MktPrice_Date (float, USD)}
    \item{\code{MktPrice_Change}}{close market price change from the previous day market close (float, USD)}
    \item{\code{MktPrice_Volume}}{trade volume as of MktPrice_Date (int, shares)}
    \item{\code{MktPrice_VolumeAvg}}{average trade volume (int, shares)}
    \item{\code{MktPrice_52Wk_Lo}}{lowest price for the last 52 weeks (float, USD)}
    \item{\code{MktPrice_52Wk_Hi}}{highest price for the last 52 weeks (float, USD)}
    \item{\code{MA10}}{10 days moving average as of MktPrice_Date (float, USD)}
    \item{\code{MA10_ChangePcnt}}{10 days moving average change from the previous day market close (float, percent as a fraction)}
    \item{\code{MA30}}{30 days moving average as of MktPrice_Date (float, USD)}
    \item{\code{MA30_ChangePcnt}}{30 days moving average change from the previous day market close (float, percent as a fraction)}
    \item{\code{MA50}}{50 days moving average as of MktPrice_Date (float, USD)}
    \item{\code{MA50_ChangePcnt}}{50 days moving average change from the previous day market close (float, percent as a fraction)}
    \item{\code{MA150}}{150 days moving average as of MktPrice_Date (float, USD)}
    \item{\code{MA150_ChangePcnt}}{150 days moving average change from the previous day market close (float, percent as a fraction)}
    \item{\code{MA200}}{200 days moving average as of MktPrice_Date (float, USD)}
    \item{\code{MA200_ChangePcnt}}{200 days moving average change from the previous day market close (float, percent as a fraction)}
    \item{\code{RSI}}{relative strength index as of MktPrice_Date (float, USD)}
    \item{\code{RSI_ChangePcnt}}{relative strength index change from the previous day market close (float, percent as a fraction)}
    \item{\code{SlowStoch_K}}{slow stochastic K as of MktPrice_Date (float, USD)}
    \item{\code{SlowStoch_D}}{slow stochastic D as of MktPrice_Date (float, USD)}
    \item{\code{SlowStoch_ChangePcnt}}{slow stochastic change from the previous day market close (float, percent as a fraction)}
    \item{\code{MACD}}{MACD (Moving Average Convergence Divergence) histogram as of MktPrice_Date (float, USD)}
    \item{\code{MACD_ChangePcnt}}{MACD histogram change from the previous day market close (float, percent as a fraction)}
    \item{\code{Jan_07_MktPrice_Close}}{close market price as of January 7 '16 (float, USD)}
    \item{\code{Jan_07_MktPrice_Volume}}{trade volume as of January 7 '16 (int, shares)}
    \item{\code{Jan_14_MktPrice_Close}}{close market price as of January 14 '16 (float, USD)}
    \item{\code{Jan_14_MktPrice_Volume}}{trade volume as of January 14 '16 (int, shares)}
  }
}
\details{
Last 4 columns show prices as of market close on the first two Fridays of 2016, i.e. as of January 7th and January 14th of 2016. It allows to compute weekly gain or loss for the first two weeks of 2016.

All fundamental characteristics provided as of latest available financial statement.
}
\source{
Data extracted directly from the stock2own.com database. Daily updated data is available at \url{http://www.stock2own.com}
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(S2O_Stocks)
## maybe str(S2O_Stocks) ; ...
}
\keyword{datasets}
