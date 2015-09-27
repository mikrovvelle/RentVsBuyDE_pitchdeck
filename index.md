---
title       : Renting vs. Buying in Germany
subtitle    : A financial scenario comparison tool
author      : daniel
job         : expatriot
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---



## Renting vs. Buying

This is the most significant financial decision most people make.

Inspired by the New York Times' ["Is It Better to Rent or Buy?"](http://www.nytimes.com/interactive/2014/upshot/buy-rent-calculator.html?_r=0),
using different terms which are typical to the German market.


> * Some based their decision on wisdom, aphorisms, advice
> * I want to look at the numbers


--- .class #id

## Buying scenario in Germany:

The 30-year fixed rate mortgage isn't typical for Germany. Loans are usually 5, 10 or 15 years, and only pay off a portion of the principle.

The "Tilgung" is the yearly percent reduction of the principle, usually 1-5%.


```r
price <- 500000       # half-million EUR
downPayment <- 25000  # 5%
interest <- 0.028     # 2.8%
tilgung <- 0.02       # 2% principle reduction each year
years <- 10           # 10 years fixed-rate
```


Homeowners bear additional costs, both at the time of purchase, and as recurring maintenance and taxes (included in calculations). 




But they also get the upside if the home value appreciates:


```r
appreciation <- 0.02  # 2% increase in German real-estate, historically
```

---

## Renting scenario, with investment

Renting is cheaper up front.


```r
rent <- 1500
annualRentHike <- 0.01       # Maybe 2% one year, 0 the next
```

That leaves some money left over which you can invest:


```r
monthlyContribution <- 500   # A rough estimate on what I have left over
marketReturn <- 0.04         # A somewhat sober prediction of 4%
```

---



## Final comparison: total net loss/gain:

### Renting:


```
##   Total.Spent Monthly.Cost Total.Value Net.Gain
## 1      248320         2069       73897  -174423
```

### Buying:


```
##   Total.Spent Monthly.Cost Total.Value Net.Gain
## 1      442530         3688      122140  -320390
```

Renting looks better to me, by about 146000€,
but you should try out your own scenario [in the app](https://www.shinyapps.io/admin/#/application/61979).














