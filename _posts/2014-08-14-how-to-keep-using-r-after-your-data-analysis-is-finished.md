---
layout: post
title: "How to keep using R after your data analysis is finished"
modified: 2014-08-14 22:25:12 +0200
tags: [R, fun]
image:
  feature: 
  credit: 
  creditlink: 
comments: true
share: 
---

If you are reading this blog, probably you already know how wonderful is R to prepare, analyse, and visualise data, that's the reason why we use it and we love it. But after a long day (or even night) of hard work, your data analysis is finally ready, and you still have time and energy for something to disconnect... So what to do? You can still use R! Today we will review some code or libraries to do several things beyond torturing your data.

* **Alarm**. The library <a href="https://github.com/rasmusab/beepr" target="_blank">beepr</a> can play a sound to let you know is time to stop your break, or for example, you can include it at the end of a long iteration process so your function warns you when is finished.


{% highlight r %}
  library(beepr)
beep("mario", print("Well done!"))
{% endhighlight %}

* **Sound synthesizer**. Speaking about music, have you ever wondered how your favourite data set sounds? Now you can find out with the package <a href= "http://playitbyr.org/" target= "_blank"> playitbyr</a>. You will need to install first the `csound` library, and the instructions are <a href="http://playitbyr.org/csound.html"  target="_blank">here</a> 


{% highlight r %}
  library(playitbyr)
sonify(iris, sonaes(time = Petal.Length, pitch = Petal.Width)) + shape_scatter()
{% endhighlight %}

* **Optical Illusions**. If you feel creative after that, maybe you can try your artistic talent and create some optical illusions with R and ggplot. You can find the following example and others <a href="http://rpubs.com/kohske/R-de-illusion" target="_blank">here</a> :


{% highlight r %}
  library(grid)
library(plyr)
grid.newpage()
n <- 10; ny <- 8; L <- 0.01; c <- seq(0, 1, length = n); d <- 1.2*diff(c)[1]/2
col <- c("black", "white")
x <- c(c-d, c, c+d, c)
y <- rep(c(0, -d, 0, d), each = n)
w <- c(c-d, c-d+L, c+d, c+d-L)
z <- c(0, L, 0, -L)
ys <- seq(0, 1, length = ny)
grid.rect(gp = gpar(fill = gray(0.5), col = NA))
l_ply(1:ny, function(i) {
  if (i%%2==0) {
    co <- rev(col)
    z <- -z
  } else {
    co <- col
  }  
  grid.polygon(x, y + ys[i], id = rep(1:n, 4), gp = gpar(fill = co, col = NA))
  grid.polygon(w, rep(z, each = n) + ys[i], id = rep(1:n, 4), gp = gpar(fill = rev(co), col = NA))
})
{% endhighlight %}

![plot of chunk unnamed-chunk-3]({{ site.url }}/images/unnamed-chunk-3.png) 

* **Fortune**. What about acquiring some wisdom or predict your fortune? You can now do it with the package <a href="http://cran.r-project.org/web/packages/fortunes/index.html" target="_blank">fortunes</a>


{% highlight r %}
  library(fortunes)
fortune(298)

## 
## Don't do as I say, do as Hadley does.
##    -- Barry Rowlingson (in a discussion about the workflow for writing R
##       packages, see also fortune(128))
##       R-devel (September 2011)
{% endhighlight %}

* **Games**. Maybe R is not as good as your game console, but is also possible to play a few games in your favorite language (I mean R, not spanish!). You can play <a href="http://cran.r-project.org/web/packages/sudoku/index.html" target="_blank">sudoku</a>, <a href="http://cran.r-project.org/web/packages/fun/index.html" target="_blank">mine sweeper</a>, or <a href="http://cran.r-project.org/web/packages/fun/index.html" target="_blank">gomoku</a> (Gomoku? I've never played that...). These two last games are from the library `fun`, where you can also find other utilities such as a random password generation, an alzheimer test, or a command to shutdown the computer from R.


{% highlight r %}
library(sudoku)
playSudoku()
library(fun)
if (.Platform$OS.type == "windows") x11() else x11(type = "Xlib")
mine_sweeper()
if (.Platform$OS.type == "windows") x11() else x11(type = "Xlib")
gomoku()
{% endhighlight %}
![sudoku]({{ site.url }}/images/sudoku.png)

* **Meme generator**. If you have been too busy writing R packages during the last years maybe you didn't notice that nowadays the internet is full of "memes" (those images combining a picture and a 'funny' message, although the concept is wider than that). Now is possible to create memes directly from R with the <a href="https://github.com/leeper/meme" target="_blank">meme</a> package (Requires installation from github using the devtools package):


{% highlight r %}
#library("devtools")
#install_github("leeper/meme")
library("meme")
templates <- get_templates("memecaptain")
plot(simply <- create_meme(templates[[10]], "One does not simply", "load a package using require()"))
{% endhighlight %}

![plot of chunk unnamed-chunk-6]({{ site.url }}/images/unnamed-chunk-6.png) 

* **Tweet**. Share with the world the happiness of being an UseR!, and publish something in twitter using the #rstats hashtag. The `twitteR` package will allow you to do it, but you need first go to <a href="https://apps.twitter.com/" target="_blank">https://apps.twitter.com/</a>, log in with your user and password, and create a new app with permissions to read, write and send direct messages. From that site get the "API key" and "API secret" values.


{% highlight r %}
  library(twitteR)
library(ROAuth)

consumerKey <- "your API key "
consumerSecret <- "your API secret"
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

twitCred$handshake()
registerTwitterOAuth(twitCred)
tweet("This tweet has been written using #rstats")
{% endhighlight %}

The last version of the twitteR package is located <a href="https://github.com/geoffjentry/twitteR" target="_blank">here</a>. You can also update your Facebook status using the <a href="https://github.com/pablobarbera/Rfacebook#updating-your-facebook-status-from-r" target="_blank">Rfacebook package</a>

* **Send an email**. To finish, you can also send an email from R, for example, to make your algorithm to send you an email when is ready, and including the main results. I'm sorry I said before that we will not speak about "serious" work, but hey! you can send an email to anyone :). The package is called <a href="https://github.com/rpremraj/mailR" target="_blank">mailR</a>, and you need to know the smtp server of your email. In the case of gmail, the code is:


{% highlight r %}
  install.packages("mailR", dep = T)
library(mailR)
send.mail(from = "USERNAME@gmail.com",
          to = "DESTINATION@mailprovider.com",
          subject = "Subject of the email",
          body = "Body of the email",
          smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "USERNAME", passwd = "PASSWORD", ssl = TRUE),
          authenticate = TRUE,
          send = TRUE)
{% endhighlight %}

Alarms, tweets, or emails can make your work in R more productive while you can also have some fun playing sudoku or creating a meme. What other uses of R not related with data analysis do you know? Please share them!
