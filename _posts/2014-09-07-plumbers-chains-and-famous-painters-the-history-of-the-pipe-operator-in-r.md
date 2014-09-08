---
layout: post
title: "Plumbers, chains, and famous painters: The history of the pipe operator in R"
modified: 2014-09-07 13:34:20 +0200
tags: [dplyr, pipeR, magrittr]
image: 
  feature: post4.jpg
  credit: lewishamdreamer
  creditlink: https://www.flickr.com/photos/lewishamdreamer/4656709993
comments: true
share: 
---
Our story starts as many other R related stories... in <a href = "http://stackoverflow.com" target="_blank">stackoverflow</a>. On <a href = "http://stackoverflow.com/questions/8896820/how-to-implement-fs-forward-pipe-operator-in-r" target="_blank">January 17th, 2012</a>, an anonymous user "user4" asked the following question:

> How can you implement F#'s forward pipe operator in R? The operator makes it possible to easily chain a sequence of calculations. For example, when you have an input data and want to call functions foo and bar in sequence, you can write: 

> data |> foo |> bar

<a href = "http://ms.mcmaster.ca/~bolker/" target="_blank">Ben Bolker</a> answered <a href = "http://stackoverflow.com/a/8897778" target="_blank">same day</a> and gives what can be considered the first pipe in R:


{% highlight r %}
  "%>%" <- function(x,f) do.call(f,list(x))
  pi %>% sin %>% cos
  ##[1] 1
  {% endhighlight %}

## dplyr.

Nine months later, on <a href = "https://github.com/hadley/dplyr/commit/80dc69b144711ec095db1d62cf0b73e09560eaf0" target="_blank">October 28th, 2012</a>, <a href = "https://twitter.com/hadleywickham" target="_blank"> Hadley Wickham</a> started the `dplyr` project in <a href = "https://github.com/hadley/dplyr/" target="_blank">github</a> as an evolution of his data analysis package <a href = "https://github.com/hadley/plyr" target="_blank">`plyr`</a> (Initially the package was indeed called 'plyr2'). As he showed in three consecutive <a href = "http://bit.ly/bigrdata2" target="_blank">presentations</a> of `dplyr` during summer 2013 in Dublin, Albacete, and London, `ddply`, a function from data frames to data frames with the philosophy of Split - Apply - Combine, was the most popular function from `plyr`. 

![plot of chunk unnamed-chunk-3]({{ site.url }}/images/plyr.png)

`dplyr` was designed to focus also on data frames, but with the idea of being more efficient than plyr. The initial functions of dplyr in 2012 included arrange, mutate, summarise, and subset, but soon the package will evolve to its main verbs: 

- select: subset variables
- filter: subset rows
- mutate: add new columns
- summarise: reduce to a single row
- arrange: re-order the rows

Then, almost one year later, in <a href = "https://github.com/hadley/dplyr/commit/57f76ed560ac52590f7ded3d013db8fb19f7d627
" target="_blank">October 9, 2013</a>, the first pipe in dplyr appears. The function was denominated `chain`, but also the package introduced its first operator for the pipe: `%.%`. The idea behind the introduction of the chain was simplify notation for applying several functions to a data frame. Without the chain function, you need to read the verbs from inside out:


{% highlight r %}
  library(hflights)
library(dplyr)
filter(
   summarise(
     select(
       group_by(hflights, Year, Month, DayofMonth), 
       Year:DayofMonth, ArrDelay, DepDelay
     ), 
     arr = mean(ArrDelay, na.rm = TRUE),  
     dep = mean(DepDelay, na.rm = TRUE)
   ), 
   arr > 30 | dep > 30
 )

## Source: local data frame [14 x 5]
## Groups: Year, Month
## 
##    Year Month DayofMonth   arr   dep
## 1  2011     2          4 44.08 47.17
## 2  2011     3          3 35.13 38.20
## 3  2011     3         14 46.64 36.14
## 4  2011     4          4 38.72 27.95
## 5  2011     4         25 37.80 22.26
## 6  2011     5         12 69.52 64.52
## 7  2011     5         20 37.03 26.55
## 8  2011     6         22 65.52 62.31
## 9  2011     7         29 29.56 31.87
## 10 2011     9         29 39.20 32.50
## 11 2011    10          9 61.90 59.53
## 12 2011    11         15 43.68 39.23
## 13 2011    12         29 26.30 30.79
## 14 2011    12         31 46.48 54.17
  {% endhighlight %}

But with the chain function, the previous code is converted to:

{% highlight r %}
  chain(
   hflights,
   group_by(Year, Month, DayofMonth),
   select(Year:DayofMonth, ArrDelay, DepDelay),
   summarise(
     arr = mean(ArrDelay, na.rm = TRUE), 
     dep = mean(DepDelay, na.rm = TRUE)
   ),
   filter(arr > 30 | dep > 30)
 )

## Warning: Chain is deprecated. Please use %>%
## Source: local data frame [14 x 5]
## Groups: Year, Month
## 
##    Year Month DayofMonth   arr   dep
## 1  2011     2          4 44.08 47.17
## 2  2011     3          3 35.13 38.20
## 3  2011     3         14 46.64 36.14
## 4  2011     4          4 38.72 27.95
## 5  2011     4         25 37.80 22.26
## 6  2011     5         12 69.52 64.52
## 7  2011     5         20 37.03 26.55
## 8  2011     6         22 65.52 62.31
## 9  2011     7         29 29.56 31.87
## 10 2011     9         29 39.20 32.50
## 11 2011    10          9 61.90 59.53
## 12 2011    11         15 43.68 39.23
## 13 2011    12         29 26.30 30.79
## 14 2011    12         31 46.48 54.17
  {% endhighlight %}

And with the operator `%.%` :

{% highlight r %}
  hflights %.%
   group_by(Year, Month, DayofMonth) %.%
   select(Year:DayofMonth, ArrDelay, DepDelay) %.%
   summarise(
     arr = mean(ArrDelay, na.rm = TRUE), 
     dep = mean(DepDelay, na.rm = TRUE)
   ) %.%
   filter(arr > 30 | dep > 30)

## Source: local data frame [14 x 5]
## Groups: Year, Month
## 
##    Year Month DayofMonth   arr   dep
## 1  2011     2          4 44.08 47.17
## 2  2011     3          3 35.13 38.20
## 3  2011     3         14 46.64 36.14
## 4  2011     4          4 38.72 27.95
## 5  2011     4         25 37.80 22.26
## 6  2011     5         12 69.52 64.52
## 7  2011     5         20 37.03 26.55
## 8  2011     6         22 65.52 62.31
## 9  2011     7         29 29.56 31.87
## 10 2011     9         29 39.20 32.50
## 11 2011    10          9 61.90 59.53
## 12 2011    11         15 43.68 39.23
## 13 2011    12         29 26.30 30.79
## 14 2011    12         31 46.48 54.17
  {% endhighlight %}

## magrittr

Nevertheless, the `%.%` pipe would not stay in `dplyr` package for long time, on <a href = "http://stackoverflow.com/revisions/20828881/1" target="_blank">December 29th, 2013</a>, <a href = "http://www.stefanbache.dk/" target="_blank"> Stefan Bache </a> revisited the old stackoverflow question proposing an alternative to the original answer:

> How about

{% highlight r %}
  `%>%` <-
   function(e1, e2)
   {
     cl <- match.call()
     e  <- do.call(substitute, list(cl[[3]], list(. = cl[[2]])))
     eval(e)
   }
  {% endhighlight %}
  
> which allows a chain like:

{% highlight r %}
  iris %>% 
  subset(., Species == "setosa", select = -Species) %>% 
  colMeans(.)

## Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
##        5.006        3.428        1.462        0.246
  {% endhighlight %}

Stefan continued working on this pipe operation, and on <a href = "http://stackoverflow.com/revisions/20828881/4" target="_blank">December 30th, 2013</a>, he implemented in github the `plumbr` package which included the `%>%` operator. <a href = "http://stackoverflow.com/revisions/20828881/5" target="_blank">Two days later</a>, `plumbr` would be renamed as <a href = "https://github.com/smbache/magrittr" target="_blank">`magrittr`</a>, its current name, in a clear reference of the famous painting <a href = "http://en.wikipedia.org/wiki/The_Treachery_of_Images" target="_blank">"The Treachery of Images"</a> of the Belgian painter René Magritte. 

<a href = "http://en.wikipedia.org/wiki/The_Treachery_of_Images" target="_blank">![Magritte]({{ site.url }}/images/MagrittePipe.jpg) </a>

The `dplyr` package was being developed in parallel but these two developments were intended to converge. On <a href = "https://github.com/hadley/dplyr/commit/3c91ba370286025c31f624317ebce421d1c70caa" target="_blank">March 19th, 2014 </a>, the `chain` function was  deprecated on dplyr, and finally on <a href = "https://github.com/hadley/dplyr/commit/89aaa9a8b386d7e3705ffb682d89dc5bebe823c0" target="_blank">April 14th, 2014</a>, `dplyr` incorporated the `%>%` operator of magrittr, recommending it in substitution of the original `%.%`, because the former is more easy to type holding down the Shift key. Both operators are still in use by `dplyr`, although on <a href = "https://github.com/hadley/dplyr/commit/67183e2771f24f59330fdaae1bb58b627a58a8ff" target="_blank">August 1st, 2014</a>, `%.%`  was deprecated.

Two weeks later, on <a href = "http://www.rstudio.com/products/rstudio/release-notes/" target="_blank">August 14th, 2014</a> , the Rstudio IDE version v0.98.1028 incorporated a shortcut for the `dplyr`/`magrittr` pipe operator `%>%` to make even more easy its use (Shift+Alt+.), although is possible that in the near future the operator shortcut <a href = "http://htmlpreview.github.io/?https://github.com/rstudio/rstudio/blob/master/src/gwt/www/docs/keyboard.htm" target="_blank"> will be changed to Ctrl+Shift+M</a>

## PipeR

The last iteration of the pipe implementation in R started on April 7th, 2014, when <a href = "https://twitter.com/renkun_ken" target="_blank">Kun Ren </a>  published on github <a href = "https://github.com/renkun-ken/pipeR/" target="_blank"> the `pipeR` package </a>, incorporating a different pipe operator `%>>%`to add more flexibility to the piping process.

From the package webpage we can find examples of the several uses of the `pipeR` operator:

* As first argument to a function:
{% highlight r %}
  rnorm(100) %>>%
  mean

## [1] -0.06422
  {% endhighlight %}

* As argument in an expression (Using `.`):
{% highlight r %}
  mtcars %>>%
  ( lm(mpg ~ cyl + wt, data = .) )
## 
## Call:
## lm(formula = mpg ~ cyl + wt, data = .)
## 
## Coefficients:
## (Intercept)          cyl           wt  
##       39.69        -1.51        -3.19
  {% endhighlight %}

* By using a formula (To avoid confussion with `.`):

{% highlight r %}
  mtcars %>>%
  (df ~ lm(mpg ~ ., data = df))

## 
## Call:
## lm(formula = mpg ~ ., data = df)
## 
## Coefficients:
## (Intercept)          cyl         disp           hp         drat  
##     12.3034      -0.1114       0.0133      -0.0215       0.7871  
##          wt         qsec           vs           am         gear  
##     -3.7153       0.8210       0.3178       2.5202       0.6554  
##        carb  
##     -0.1994
  {% endhighlight %}

* To save intermediate results (using `~`):

{% highlight r %}
  mtcars %>>%
  (lm(formula = mpg ~ wt + cyl, data = .)) %>>%
  (~ lm_mtcars) %>>%
  summary
## 
## Call:
## lm(formula = mpg ~ wt + cyl, data = .)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.289 -1.551 -0.468  1.574  6.100 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   39.686      1.715   23.14  < 2e-16 ***
## wt            -3.191      0.757   -4.22  0.00022 ***
## cyl           -1.508      0.415   -3.64  0.00106 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.57 on 29 degrees of freedom
## Multiple R-squared:  0.83,  Adjusted R-squared:  0.819 
## F-statistic: 70.9 on 2 and 29 DF,  p-value: 6.81e-12
  {% endhighlight %}

* Or to extract element by names (using `()`):

{% highlight r %}
  mtcars %>>%
  (lm(mpg ~ wt + cyl, data = .)) %>>%
  (~ lm_mtcars) %>>%
  summary %>>%
  (r.squared)
## [1] 0.8302
  {% endhighlight %}

Pipes in R are here to stay and change completely the way how we code in R, making it more simple and readable. Simple and readable means that our daily work in R will be more easy and also it can encourage new people to use our favourite language. Have you tried R piping? 

**Edited September 08, 2014**
Notes (Thanks to Hadley Wickham comments):

- On April 5, 2012, <a href = "https://twitter.com/perisaccadic" target="_blank">Peter Meilstrup</a> started the package `ptools` as a way to collect "various data manipulation and programming utilities". One of those utilities was the function `chain`, implementing a way to pipe the arguments. The current function of the `chain` function can be found in the <a href = "https://github.com/crowding/vadr" target="_blank">`vadr` package</a> from the same author. 

- On  <a href = "http://www.r-statistics.com/2014/08/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/" target="_blank">this post</a>, <a href = "http://www.stefanbache.dk/" target="_blank">Stefan Bache</a> gives his version about how he created `magrittr` and the convergence of the pipe operators between `dplyr` and `magrittr`.

- In the first comment of the <a href = "http://blog.rstudio.org/2014/01/17/introducing-dplyr/" target="_blank">announcing post</a> of `dplyr` by the RStudio blog, Stefan Bache let Hadley Wickham know about magrittr operator.

- The `%>%` operator should be <a href = "https://twitter.com/hadleywickham/status/507643720401842176" target="_blank">pronounced "then"</a>.



   
