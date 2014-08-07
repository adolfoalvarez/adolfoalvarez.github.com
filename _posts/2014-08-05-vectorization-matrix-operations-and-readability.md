---
layout: post
title: "Vectorization, matrix operations, and readability"
modified: 2014-08-05 21:25:18 +0200
tags: [Vectorization, matrix operations, readability]
image:
  feature: post1.png
  credit: Mrs. Thompson’s Art Class
  creditlink: http://thetravelingartist.wordpress.com/2011/05/13/picassos-faces/
comments: true
share: 
---
Vectorization, matrix operations, and readability
========================================================

Welcome to my **first** post about R! In this blog I will try to write on a regular basis to share thoughts, findings, or pieces of code that have been useful for me. I firmly believe that one way to fix your learning is to "spread the word" and share this knowledge with others, R itself is an example of that, so here we are! Please feel free to write here your comments, suggestions or improvements, and if you think that one post can be useful for you or someone in your network, please share it! 

After that introduction, please allow me to start again...

Vectorization, matrix operations, and readability
========================================================

One of the first words you start to listen after you already know the basics of R is **vectorization**. Vectorization is just to write your code in such a way that you avoid the use of loops and instead, you prefer vector operations. Why everybody will suggest you to vectorize your code? The answer is speed: Vector operations in R are faster. "What makes vectorization in R effective is that it provides a mechanism for moving computations into C, where a hidden layer of devectorization can do its magic" <a href="http://www.johnmyleswhite.com/notebook/2013/12/22/the-relationship-between-vectorized-and-devectorized-code/" target="_blank">as John Miles, creator of Julia points out.</a>


Vectorization is one of the circles of the highly recommended book "The R Inferno", freely available <a href="http://www.burns-stat.com/documents/books/the-r-inferno/" target="_blank">here</a>, from which we can extract this example for a code to apply the logarithm function to each element of a vector x and then get the sum of all of them.

**devectorized code**

{% highlight r %}
    lsum1 <- function(x) {
  lsum <- 0
  for (i in 1:length(x)) {
      lsum <- lsum + log(x[i])
  }
  return(lsum)
  }
    
  {% endhighlight %}


**vectorized code**
{% highlight r %}
    lsum2 <- function(x) sum(log(x))
  {% endhighlight %}


And we can compare the speed using `system.time`

{% highlight r %}
    x <- runif(1e+05, min = 0.1, max = 1)
system.time(lsum1(x))
##    user  system elapsed 
##    0.16    0.00    0.20
system.time(lsum2(x))
##    user  system elapsed 
##       0       0       0
  {% endhighlight %}


As you can see in this example, vectorized code is not only fast but also brief and elegant, two characteristics of "readability", which is a measure of how easy a code can be understood. We will come back to this topic later.

Matrix operations are your friends
-------------------------
Some times vectors are not enough, so we can use matrix operations to avoid loops. For example, if we want to center a matrix (i.e. subtract the global mean to each row) we can use the function `scale(x,center=T, scale=F)`, but imagine we don't have such function. What to do?


{% highlight r %}
  set.seed(2)
A <- matrix(sample(1:10), ncol = 2)
A
##      [,1] [,2]
## [1,]    2    8
## [2,]    7    1
## [3,]    5    3
## [4,]   10    4
## [5,]    6    9
colMeans(A)
## [1] 6 5
  {% endhighlight %}


The desired result is:

{% highlight r %}
  scale(A, center = T, scale = F)
##      [,1] [,2]
## [1,]   -4    3
## [2,]    1   -4
## [3,]   -1   -2
## [4,]    4   -1
## [5,]    0    4
## attr(,"scaled:center")
## [1] 6 5
  {% endhighlight %}


The "loop" way to do this is to setup an empty matrix and later fill it with the result of each row minus the mean:


{% highlight r %}
  function1 <- function(A) {
  result <- A * 0
  for (i in 1:nrow(A)) {
      themean <- colMeans(A)
      result[i, ] <- A[i, ] - themean
  }
  return(result)
}
function1(A)
##      [,1] [,2]
## [1,]   -4    3
## [2,]    1   -4
## [3,]   -1   -2
## [4,]    4   -1
## [5,]    0    4
  {% endhighlight %}


The first attempt to vectorize that function could be just subtract the vector of means to the matrix...

{% highlight r %}
  function2 <- function(A) {
  result <- A - colMeans(A)
  return(result)
}
function2(A)
##      [,1] [,2]
## [1,]   -4    3
## [2,]    2   -5
## [3,]   -1   -2
## [4,]    5   -2
## [5,]    0    4
  {% endhighlight %}


but, although elegant, this result is wrong because R tries to replicate the dimension of the matrix A repeating the vector `colMeans(A)`, and when the dimensions match each other, then subtract. But this repetition is done BY COLUMNS, as you can see doing:


{% highlight r %}
  matrix(colMeans(A), nrow = nrow(A), ncol = ncol(A))
##      [,1] [,2]
## [1,]    6    5
## [2,]    5    6
## [3,]    6    5
## [4,]    5    6
## [5,]    6    5
  {% endhighlight %}


So in order to construct the matrix mean properly, we should set the parameter "byrow" to TRUE

{% highlight r %}
  matrix(colMeans(A), nrow = nrow(A), ncol = ncol(A), byrow = T)
##      [,1] [,2]
## [1,]    6    5
## [2,]    6    5
## [3,]    6    5
## [4,]    6    5
## [5,]    6    5
function2 <- function(A) {
  result <- A - matrix(colMeans(A), nrow = nrow(A), ncol = ncol(A),
  byrow = T)
  return(result)
}
function2(A)
##      [,1] [,2]
## [1,]   -4    3
## [2,]    1   -4
## [3,]   -1   -2
## [4,]    4   -1
## [5,]    0    4
  {% endhighlight %}


Another way is to use the fact that the repetition is done by columns, so we can subtract `colMeans(A)` from $$A^t$$ and then transpose again the result:

{% highlight r %}
  function3 <- function(A) {
  result <- t(t(A) - colMeans(A))
  return(result)
}
function3(A)
##      [,1] [,2]
## [1,]   -4    3
## [2,]    1   -4
## [3,]   -1   -2
## [4,]    4   -1
## [5,]    0    4
  {% endhighlight %}


**Trick** As Noam Ross mentions in <a href="http://www.noamross.net/blog/2014/4/16/vectorization-in-r--why.html" target="_blank"> this post</a> about vectorization, "Linear Algebra is a special case", because R can take advantage of optimized libraries to solve linear algebra operations. Then, the repetition process that R is performing to match the dimensions of the matrices can be improved with a simple matrix multiplication trick:

$$ 
\left[ {\begin{array}{c}
   1\\
   1\\
   1\\
   ...\\
   1\\
  \end{array} } \right]_{n \times 1}\times
  \left[ {\begin{array}{cc}
   x1 & x2 \\
   \end{array} } \right]_{1 \times 2} = 
   \left[ {\begin{array}{cc}
   x1 & x2 \\
   x1 & x2 \\
   x1 & x2 \\
   ...& ...\\
   x1 & x2 \\
   \end{array} } \right]_{n \times 2} 
$$

In R, we can perform this multiplication defining the proper dimensions of a matrix of ones and a matrix with the means, or, keep both as vectors and use the `crossprod` function (or her sister `tcrossprod`). So, we have:


{% highlight r %}
  tcrossprod(rep(1, nrow(A)), colMeans(A))

##      [,1] [,2]
## [1,]    6    5
## [2,]    6    5
## [3,]    6    5
## [4,]    6    5
## [5,]    6    5
  
function4 <- function(A) {
  result <- A - tcrossprod(rep(1, nrow(A)), colMeans(A))
  return(result)
}
function4(A)
##      [,1] [,2]
## [1,]   -4    3
## [2,]    1   -4
## [3,]   -1   -2
## [4,]    4   -1
## [5,]    0    4
  {% endhighlight r %}


Let's compare the speed of all the previous functions using the package `rbenchmark` with 10000 calls for each function:


{% highlight r %}
  library(rbenchmark)
benchmark(replications = rep(10000), scale(A, center = T, scale = F),
function1(A), function2(A), function3(A), function4(A), 
columns = c("test", "elapsed", "replications"))
    
##                              test elapsed replications
## 2                    function1(A)   1.410        10000
## 3                    function2(A)   0.373        10000
## 4                    function3(A)   0.626        10000
## 5                    function4(A)   0.373        10000
## 1 scale(A, center = T, scale = F)   1.571        10000
  {% endhighlight r %}



What if A is bigger? Let's try again with only 1000 replications


{% highlight r %}
  A <- set.seed(2)
A <- matrix(sample(1:10000), ncol = 2)
library(rbenchmark)
benchmark(replications = rep(1000), scale(A, center = T, scale = F),
function1(A), function2(A), function3(A), function4(A), 
columns = c("test", "elapsed", "replications"))
##                              test elapsed replications
## 2                    function1(A) 246.828         1000
## 3                    function2(A)   0.358         1000
## 4                    function3(A)   0.271         1000
## 5                    function4(A)   0.221         1000
## 1 scale(A, center = T, scale = F)   0.667         1000
  {% endhighlight r %}


We can see that not always speed go together with readability and elegancy. Probably the most readable solution is function 1 where we see that the mean is subtracted from each row, but this is very slow. Functions 2 and 3 have a good compromise between readability and speed, while base functions although easy to use, are not always the most efficient way. Finally, using matrix operations can make your code less readable but fast thanks to the Linear Algebra libraries running in the back.

If there is no way to avoid loops, one advice is to try always to loop over the smaller dimension, i.e. we can improve the efficiency of ``function1`` iterating by columns instead of by rows. Nevertheless, as Pablo Picasso said: "it took me a lifetime to paint like a child", probably when you will be a more advanced user you will come back to the cycles and then use <a href="http://www.rcpp.org/" target="_blank">Rcpp</a>, but I will speak about that in another post...