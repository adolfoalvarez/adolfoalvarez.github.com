---
layout: post
title: "The basics, the classics, and the magics about lists"
modified: 2014-08-24 19:29:28 +0200
tags: [lists]
image:
  feature: post3.png
  credit: Luis Roca
  creditlink: https://www.flickr.com/photos/91693474@N03/8392688958/
comments: TRUE
share: 
---

I think lists are the fourth preferred class of objects to store data in R after vectors, data frames, and matrices (take that arrays!). Nevertheless, is one of the most flexible ways to manage our data since in lists we can combine several dimensions and classes in an elegant way.

In this post I will cover three aspects of the work with lists: the basics, including creation, subsetting and common operations; the classics, including the family of "*pply" functions over lists; and finally the magics, about a recent package to work with lists.

## The basics.

Creation. To create a list from a set of objects we use the command `list`

{% highlight r %}
  mylist <- list(cities=c("Poznan", "Getafe", "Curico"), numbers=rnorm(10), logicals=sample(c(T,F),5, rep=T), matrix=matrix(c(1,2,3,4,5,6),nrow=2))
mylist
## $cities
## [1] "Poznan" "Getafe" "Curico"
## 
## $numbers
##  [1]  1.0363  0.2903 -0.2158 -0.1061 -1.8350  0.0734  0.4121 -1.8915
##  [9] -0.8141 -1.8099
## 
## $logicals
## [1] FALSE FALSE  TRUE  TRUE FALSE
## 
## $matrix
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
  {% endhighlight %}

If we will use lists inside a function or we will populate it in a loop, is more efficient preallocate the list, i.e. create an empty list with the desired length, we can do it with the function `vector`(?!). This is the "phantom" 8.1.53 from the R-inferno:


{% highlight r %}
  emptylist <- vector("list", 3)
emptylist
## [[1]]
## NULL
## 
## [[2]]
## NULL
## 
## [[3]]
## NULL
  {% endhighlight %}

Single and double brackets to subset. To extract one element of the list we can use single or double brackets, single brackets returns the element as a list, and double brackets returns directly the element we are extracting


{% highlight r %}
  mylist[1]
## $cities
## [1] "Poznan" "Getafe" "Curico"
  {% endhighlight %}

{% highlight r %}
  mylist[[1]]
## [1] "Poznan" "Getafe" "Curico"
  {% endhighlight %}

{% highlight r %}
  class(mylist[1])
## [1] "list"
  {% endhighlight %}

{% highlight r %}
  class(mylist[[1]])
## [1] "character"
  {% endhighlight %}

Single brackets works in the same way as in the vector case

{% highlight r %}
  mylist[c(1,2)] #This returns a list with the two first elements of mylist
## $cities
## [1] "Poznan" "Getafe" "Curico"
## 
## $numbers
##  [1]  1.0363  0.2903 -0.2158 -0.1061 -1.8350  0.0734  0.4121 -1.8915
##  [9] -0.8141 -1.8099

  {% endhighlight %}
{% highlight r %}
  mylist[[c(1,2)]] # While this returns the second element of the first list component
## [1] "Getafe"
  {% endhighlight %}

## The classics: Apply family and plyr package

To do more advanced subsetting, or apply a function to all elements a list we can make use of the apply family. Specifically three commands are suitable for lists: lapply, sapply, and mapply.

Let's create first a list of matrices:

{% highlight r %}
  set.seed(2)
mylist <- list(matrix(c(1:9),nrow=3),matrix(runif(9),nrow=3),matrix(rnorm(9), nrow=3))
mylist
## [[1]]
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
## 
## [[2]]
##        [,1]   [,2]   [,3]
## [1,] 0.1849 0.1681 0.1292
## [2,] 0.7024 0.9438 0.8334
## [3,] 0.5733 0.9435 0.4680
## 
## [[3]]
##         [,1]    [,2]     [,3]
## [1,]  0.1256  1.0518 -0.28571
## [2,] -0.7099 -0.7527 -1.03429
## [3,] -0.9122 -1.4397 -0.02815

  {% endhighlight %}
  
* **lapply**. Apply a function to each element of a list and get a list.

{% highlight r %}
  lapply(mylist, nrow)
## [[1]]
## [1] 3
## 
## [[2]]
## [1] 3
## 
## [[3]]
## [1] 3
  {% endhighlight %}

* **sapply**. Apply a function to each element of a list and get a vector.

{% highlight r %}
  sapply(mylist, nrow)
## [1] 3 3 3
  {% endhighlight %}

* **mapply**. Apply a function to each element of several lists and get a list. Is the multivariate version of sapply so it will return a vector when is possible. To return a list use the argument `SIMPLIFY=FALSE`

{% highlight r %}
  indexlist <- list(1,2,3)
mapply(function(index,x) return(sum(x[index,])) , indexlist, mylist, SIMPLIFY=F)
## [[1]]
## [1] 12
## 
## [[2]]
## [1] 2.48
## 
## [[3]]
## [1] -2.38
  {% endhighlight %}

This last example takes one list of indexes, and a list of matrices, then returns the sum of the first row of the first matrix, the sum of the second row of the second matrix, and so on. `mapply` accept multiple lists as inputs, just be careful that the function accepts also multiple inputs in the desired order.

And speaking about functions and lists, the subsetting `[` is also a <a href = "http://stackoverflow.com/questions/19260951/using-square-bracket-as-a-function-for-lapply-in-r" target="_blank">function</a> and can be used in lapply to make more complex subsettings. For example if we want to select the element `[2,3]` of each matrix:


{% highlight r %}
  lapply(mylist, function(x) x[2,3])
## [[1]]
## [1] 8
## 
## [[2]]
## [1] 0.8334
## 
## [[3]]
## [1] -1.034
  {% endhighlight %}
is equivalent to:

{% highlight r %}
  lapply(mylist, '[', 2,3)
## [[1]]
## [1] 8
## 
## [[2]]
## [1] 0.8334
## 
## [[3]]
## [1] -1.034
  {% endhighlight %}

Since in `lapply`, after the function we can write the corresponding parameters, in this case `x[2,3]` is equivalent to `'['(x,2,3)`

Finally, the package <a href= "http://plyr.had.co.nz/" target="_blank">`plyr`</a> makes more flexible the input and output of the apply family:

* `lapply` returns an array, `ldply` returns a data frame, `llply` returns a list, and `l_ply` returns... nothing. (But is useful to use intermediate results inside functions, such as plots)


{% highlight r %}
  library(plyr)
laply(mylist, nrow)
## [1] 3 3 3
  {% endhighlight %}

{% highlight r %}
  ldply(mylist, nrow)
##   V1
## 1  3
## 2  3
## 3  3
  {% endhighlight %}

{% highlight r %}
  llply(mylist, nrow)
## [[1]]
## [1] 3
## 
## [[2]]
## [1] 3
## 
## [[3]]
## [1] 3
  {% endhighlight %}

{% highlight r %}
  l_ply(mylist, nrow)
  {% endhighlight %}
  
## The magics: rlist

Recently, <a href="http://renkun.me" target="_blank">Kun Ren</a> developed <a href="http://renkun.me/rlist/" target="_blank">`rlist`</a>, a new package with several utilities oriented to lists. In a similar way as `dplyr` is an upgrade of `plyr` focused in data frames, we can think in `rlist` as an upgrade for lists, that can also be used together with pipes as those provided by `magrittr` or `pipeR` (I will write about pipes in another post). Here are just some of the functions included in `rlist`, where `x ~ x[2,1]<0` is the way `rlist` have to note an  element `x` of the list such that `x[2,1]<0` :


{% highlight r %}
  #devtools::install_github("rlist","renkun-ken")
library(rlist)
list.all(mylist, x ~ x[2,1]<0 ) #Get whether all list members satisfy the condition
## [1] FALSE

list.any(mylist, x ~ x[2,1]<0 ) #Get whether any list member satisfies the condition
## [1] TRUE

list.count(mylist, x ~ x[2,1]<0 ) #Count the number of members that meet the condition
## [1] 1

list.exclude(mylist, x ~ x[2,1]<0 ) #Exclude members of a list that meet the condition.
## [[1]]
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
## 
## [[2]]
##        [,1]   [,2]   [,3]
## [1,] 0.1849 0.1681 0.1292
## [2,] 0.7024 0.9438 0.8334
## [3,] 0.5733 0.9435 0.4680

list.filter(mylist, x ~ x[2,1]<0 ) #Filter a list by a condition.
## [[1]]
##         [,1]    [,2]     [,3]
## [1,]  0.1256  1.0518 -0.28571
## [2,] -0.7099 -0.7527 -1.03429
## [3,] -0.9122 -1.4397 -0.02815

list.findi(mylist, x ~ x[2,1]<0 ) #Find the indices that meet the condition
## [1] 3

list.group(mylist, x ~ x[2,1]<0) #Group the list by the condition
## $`FALSE`
## $`FALSE`[[1]]
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
## 
## $`FALSE`[[2]]
##        [,1]   [,2]   [,3]
## [1,] 0.1849 0.1681 0.1292
## [2,] 0.7024 0.9438 0.8334
## [3,] 0.5733 0.9435 0.4680
## 
## 
## $`TRUE`
## $`TRUE`[[1]]
##         [,1]    [,2]     [,3]
## [1,]  0.1256  1.0518 -0.28571
## [2,] -0.7099 -0.7527 -1.03429
## [3,] -0.9122 -1.4397 -0.02815

list.is(mylist, x ~ x[2,1]<0) #Logical indicating if the member satisfies the condition
## [1] FALSE FALSE  TRUE

list.order(mylist, x ~ x[2,1]) #Reorder the list by the element [2,1]
## [1] 3 2 1

list.parse("a") #Convert an object into a list
## [[1]]
## [1] "a"

list.rbind(mylist) #Bind all list members by row
##          [,1]    [,2]     [,3]
##  [1,]  1.0000  4.0000  7.00000
##  [2,]  2.0000  5.0000  8.00000
##  [3,]  3.0000  6.0000  9.00000
##  [4,]  0.1849  0.1681  0.12916
##  [5,]  0.7024  0.9438  0.83345
##  [6,]  0.5733  0.9435  0.46802
##  [7,]  0.1256  1.0518 -0.28571
##  [8,] -0.7099 -0.7527 -1.03429
##  [9,] -0.9122 -1.4397 -0.02815

list.remove(mylist,1) #Remove the first element of the list
## [[1]]
##        [,1]   [,2]   [,3]
## [1,] 0.1849 0.1681 0.1292
## [2,] 0.7024 0.9438 0.8334
## [3,] 0.5733 0.9435 0.4680
## 
## [[2]]
##         [,1]    [,2]     [,3]
## [1,]  0.1256  1.0518 -0.28571
## [2,] -0.7099 -0.7527 -1.03429
## [3,] -0.9122 -1.4397 -0.02815

list.reverse(mylist) #Reverse the order of the list
## [[1]]
##         [,1]    [,2]     [,3]
## [1,]  0.1256  1.0518 -0.28571
## [2,] -0.7099 -0.7527 -1.03429
## [3,] -0.9122 -1.4397 -0.02815
## 
## [[2]]
##        [,1]   [,2]   [,3]
## [1,] 0.1849 0.1681 0.1292
## [2,] 0.7024 0.9438 0.8334
## [3,] 0.5733 0.9435 0.4680
## 
## [[3]]
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9

list.table(mylist, x ~ x[2,1]<0) #A table for the list by expression
## 
## FALSE  TRUE 
##     2     1

list.ungroup(mylist) #Ungroup a list
##  [1]  1.00000  2.00000  3.00000  4.00000  5.00000  6.00000  7.00000
##  [8]  8.00000  9.00000  0.18488  0.70237  0.57333  0.16805  0.94384
## [15]  0.94347  0.12916  0.83345  0.46802  0.12562 -0.70986 -0.91224
## [22]  1.05177 -0.75267 -1.43968 -0.28571 -1.03429 -0.02815

subset(mylist, x ~ x[2,1]<0) #Another way to subset a list by condition
## [[1]]
##         [,1]    [,2]     [,3]
## [1,]  0.1256  1.0518 -0.28571
## [2,] -0.7099 -0.7527 -1.03429
## [3,] -0.9122 -1.4397 -0.02815

summary(mylist) #Summary
## List: mylist
## Length: 3
## ------
## - - 1
##   - 2
##   - 3
##   - 4
##   - 5
##   - 6
##   - 7
##   - 8
##   - 9
## - - 0.1849
##   - 0.7024
##   - 0.5733
##   - 0.1681
##   - 0.9438
##   - 0.9435
##   - 0.1292
##   - 0.8334
##   - 0.468
## - - 0.1256
##   - -0.7099
##   - -0.9122
##   - 1.0518
##   - -0.7527
##   - -1.4397
##   - -0.2857
##   - -1.0343
##   - -0.0281
  {% endhighlight %}

In conclusion, lists are another way to manage our data inside R, and sometimes there are not too many alternatives (For example, for unstructured data bases as in the example of <a href="http://renkun.me/rlist/" target="_blank">the `rlist` webpage</a>). Lists provides a flexible way of dealing with data of different classes and dimensions, and a knowing the basics, the classics and the magics, can save us time and headaches.

Greetings! Saludos! Pozdrawiam!



