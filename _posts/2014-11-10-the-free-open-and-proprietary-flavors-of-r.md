---
layout: post
title: "The free, open, and proprietary flavors of R"
modified: 2014-11-10 16:43:16 +0100
tags: [licenses, FOSS, commercial]
image:
  feature: post5.png
  credit: lonelyradio
  creditlink: https://www.flickr.com/photos/lonelyradio/8415908840/
comments: true
share: 
---
<meta name="twitter:card" content="summary">
<meta name="twitter:site" content="@adolfoalvarez">
<meta name="twitter:creator" content="@adolfoalvarez">
<meta name="twitter:url" content="http://adolfoalvarez.cl/the-free-open-and-proprietary-flavors-of-r/">
<meta name="twitter:title" content="The free, open, and proprietary flavors of R">
<meta name="twitter:description" content="In this fifth entry of my blog about R and analytics, I write about the origins of R as a free software project, an analysis of the several licenses used by packages in CRAN (including the use of rvest, dplyr, and ggvis packages), and a list of other commercial or open projects derived from R.">
<meta name="twitter:image" content="http://adolfoalvarez.cl/images/post5.png">

## R: A free software project.

R was announced to the world on August 4th, 1993, when Ross Ihaka sent the following email to the "S-news" email list:

> About a year ago Robert Gentleman and I considered the problem of obtaining decent statistical software for our undergraduate Macintosh lab. After considering the options, we decided that the most satisfactory alternative was to write our own. We started by writing a small lisp interpreter. Next we expanded its data structures with atomic vector types and altered its evaluation semantics to include lazy evaluation of closure arguments and argument binding by tag as well as order. Finally we added some syntactic sugar to make it look somewhat like S. We call the result "R".

As referred by prof. Ihaka in the <a href="https://www.stat.auckland.ac.nz/~ihaka/downloads/Interface98.pdf" target="_blank">"R: Past and future"</a> article, only in june of 1995 R became Free Software, when the source code was released under the <a href="http://www.r-project.org/COPYING" target="_blank">GNU General Public License (GPL)</a>, from the <a href="http://www.fsf.org/" target="_blank">Free Software Foundation</a>. Following the FSF definition, "a program is free software, for you, a particular user, if:

- You have the freedom to run the program as you wish, for any purpose.
- You have the freedom to modify the program to suit your needs. (To make this freedom effective in practice, you must have access to the source code, since making changes in a program without having the source code is exceedingly difficult.)
- You have the freedom to redistribute copies, either gratis or for a fee.
- You have the freedom to distribute modified versions of the program, so that the community can benefit from your improvements."

## Free and non-free extensions (a.k.a Packages)

Following the conditions of the GPL, to create a commercial (i.e. non free) package is perfectly possible, as long as you are not modifiyng or including code from another package which is licensed under GPL. The R Foundation clarify their position respects to non free packages in <a href="https://stat.ethz.ch/pipermail/r-devel/2009-May/053248.html" target="_blank">this statement</a>. 

Nevertheless, the use of FOSS (Free or open source software) is <a href="http://cran.r-project.org/doc/manuals/r-release/R-exts.html#Licensing" target="_blank">encouraged in CRAN</a>, and some of the common options for developers are the <a href="http://cran.r-project.org/web/licenses/" target="_blank">GPL, MIT, or BSD licenses</a>. A similar guideline is followed by <a href="http://www.bioconductor.org/developers/package-guidelines/#license" target="_blank"> Bioconductor</a>, and <a href="https://help.github.com/articles/open-source-licensing/" target="_blank">Github</a>. 

Let's write some code to analyze the different licenses used by the packages submitted to CRAN:


{% highlight r %}
  library(rvest)
library(dplyr)
library(ggvis)
url <- "http://cran.r-project.org/web/packages/available_packages_by_date.html"
page <- html(url)
packages <- html_table(page)
packages <- tbl_df(packages[[1]])
packages

## Source: local data frame [6,050 x 3]
## 
##          Date    Package
## 1  2014-11-10         BH
## 2  2014-11-10  DepthProc
## 3  2014-11-10   EBglmnet
## 4  2014-11-10       GSIF
## 5  2014-11-10   ionflows
## 6  2014-11-10        ips
## 7  2014-11-10       ISBF
## 8  2014-11-10 lpSolveAPI
## 9  2014-11-10      mixlm
## 10 2014-11-10  ModelGood
## ..        ...        ...
## Variables not shown: Title (chr)
{% endhighlight %}

Now we have a data frame with the information of the available packages on CRAN. We included a "License" column where we will store the information about the package


{% highlight r %}
  obtainLicenses <- function(x){
  output <- rep("license", length(x))
  for (i in 1:length(x)){
    Licenses <- readLines(paste0("http://cran.r-project.org/web/packages/",x[i], "/DESCRIPTION"))
    Licenses <- License[grep("^License", Licenses)]
    Licenses <- gsub("License: ", "", Licenses)
    output[i] <- Licenses
  }
  return(output)
}
packages <- mutate(packages, Licenses=obtainLicenses(Package)) #Warning: Very slow!
packages %>%
  select(Package, Licenses)

## Source: local data frame [6,044 x 2]
## 
##              Package                  Licenses
## 1  EntropyEstimation                GPL (>= 3)
## 2         extraTrees        Apache License 2.0
## 3        MetaLandSim                GPL (>= 2)
## 4               nCal                GPL (>= 2)
## 5            rugarch                     GPL-3
## 6              spaMM                  CeCILL-2
## 7              dummy                GPL (>= 2)
## 8           geometry GPL (>= 3) + file LICENSE
## 9             LinCal                     GPL-2
## 10          miceadds              GPL (>= 2.0)
## ..               ...                       ...
{% endhighlight %}

I am not particularly proud of that code, since it hides a for loop, and is quite slow. Nevertheless, the "ReadLines" function is not vectorized, then I need to open one connection (text file) at a time. If somebody knows a better way to do, keep it for your self... or better share it in the comments :).

We can find out how many different licenses are used in CRAN:

{% highlight r %}
  length(unique(packages$Licenses))

## [1] 121
{% endhighlight %}

Or check the most common ones...

{% highlight r %}
  packages %>%
  group_by(Licenses) %>%
  summarise(n=n()) %>%
  arrange(-n)

## Source: local data frame [121 x 2]
## 
##                       Licenses    n
## 1                   GPL (>= 2) 2468
## 2                        GPL-2 1308
## 3                        GPL-3  562
## 4                          GPL  377
## 5                   GPL (>= 3)  282
## 6           MIT + file LICENSE  157
## 7                GPL-2 | GPL-3  132
## 8                 GPL (>= 2.0)   71
## 9                       LGPL-3   66
## 10 BSD_3_clause + file LICENSE   49
## ..                         ...  ...
{% endhighlight %}

We can group some licenses into a reduced set. To do so, we consider just the first word of each License:


{% highlight r %}
  group_lic <- function(x){
  gsub("(^[a-zA-Z]+).*","\\1",x)
  }
packages <- packages %>%
  mutate(LicenseGroup=group_lic(Licenses))
{% endhighlight %}

We make some corrections with acronyms...
  

{% highlight r %}
  packages <- packages %>%
  mutate(LicenseGroup=ifelse(LicenseGroup=="GNU", "GPL", LicenseGroup),
         LicenseGroup=ifelse(LicenseGroup=="Mozilla", "MPL", LicenseGroup),
         LicenseGroup=ifelse(LicenseGroup=="Common", "CPL", LicenseGroup),
         LicenseGroup=ifelse(LicenseGroup=="FreeBSD", "BSD", LicenseGroup)
         )
{% endhighlight %}

And we plot.

{% highlight r %}
  all_values <- function(x) {
  if(is.null(x)) return(NULL)
  paste0(c("License", "Packages"), ": ", format(x)[c(1,3)], collapse = "<br/>")
}

packages %>%
  group_by(LicenseGroup) %>%
  summarise(n=n()) %>%
  mutate(LG2=factor(LicenseGroup),
         LG2=reorder(LG2, n, FUN=function(x) -x)
         ) %>%
  ggvis(~LG2, ~n) %>%
  layer_bars() %>% add_tooltip(all_values, "hover")

## Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
## Generating a static (non-dynamic, non-interactive) version of the plot.
{% endhighlight %}

![ggvis_plot]({{ site.url }}/images/plot_617598888.png)

The vast majority of packages chose GPL, LGPL, or other free software licenses. Although there are some with restrictions, such as those who use the NC (NonCommercial) option of the Creative Commons license:


{% highlight r %}
  packages %>%
  filter(LicenseGroup=="CC",
         grepl("NC",Licenses)) %>%
  select(Package, Licenses)

## Source: local data frame [15 x 2]
## 
##                    Package                       Licenses
## 1                sdcTarget                   CC BY-NC 4.0
## 2                 nettools                CC BY-NC-SA 4.0
## 3                RTriangle                CC BY-NC-SA 4.0
## 4       gettingtothebottom                CC BY-NC-SA 4.0
## 5                cvxclustr                CC BY-NC-SA 4.0
## 6                      FGN                CC BY-NC-SA 3.0
## 7             spikeSlabGAM                CC BY-NC-SA 3.0
## 8                     isa2                CC BY-NC-SA 3.0
## 9            spatialkernel CC BY-NC-SA 3.0 + file LICENSE
## 10            DATforDCEMRI                CC BY-NC-SA 3.0
## 11                nutshell             CC BY-NC-ND 3.0 US
## 12 nutshell.audioscrobbler                CC BY-NC-SA 3.0
## 13           nutshell.bbdb             CC BY-NC-ND 3.0 US
## 14                    tnet    CC BY-NC 3.0 + file LICENSE
## 15                   r2stl                CC BY-NC-SA 3.0
{% endhighlight %}

Other special license cases are those given by a "file License", where the license is specified in a file (<a href="http://cran.r-project.org/web/packages/sparseHessianFD/LICENSE" target="_blank">Example</a>), or the "Unlimited" license(<a href="http://cran.r-project.org/web/packages/learningr/" target="_blank">Example</a>), which is actually not unlimited, but restricted to national laws (where most cases "All rights reserved" is implied). For those packages is better to contact the authors to modify the code or use it for commercial purposes.

## The other open and commercial flavors of R

Two of the problems that companies can found when using R for business are its lack of commercial support, and that it is not ready to use with big data (At least not directly). Then, a few firms offer enterprise oriented modified versions of R, generally under commercial licenses.

Some of these versions are:

- <a href="http://www.revolutionanalytics.com/revolution-r-open" target="_blank">Revolution R Open</a>. This is the Open Source version of Revolution R. It includes the <a href="http://en.wikipedia.org/wiki/Math_Kernel_Library" target="_blank">MKL library</a> for faster computation (specially in Windows), <a href="http://projects.revolutionanalytics.com/documents/rrt/rrtpkgs/" target="_blank">the Reproducible R Toolkit</a>(a set of tools to ensure reproducibility), and support.

- <a href="http://www.revolutionanalytics.com/plus" target="_blank">Revolution R Plus</a>. Available via an annual subscription, it includes Revolution R Open, and some open source packages developed by Revolution: <a href="http://projects.revolutionanalytics.com/deployr/" target="_blank">DeployR</a>, <a href="http://projects.revolutionanalytics.com/parallelr/" target="_blank">ParallelR</a>, and <a href="https://github.com/RevolutionAnalytics/RHadoop/wiki" target="_blank">RHadoop</a>; plus technical support service.

- <a href="http://www.revolutionanalytics.com/revolution-r-enterprise" target="_blank">Revolution R Enterprise</a>. This version is oriented to big data analytics, including all the previous versions plus the licensed packages <a href="http://deployr.revolutionanalytics.com/" target="_blank">RRE DeployR</a>, <a href="http://www.revolutionanalytics.com/revolution-r-enterprise-scaler" target="_blank">RRE ScaleR</a>, and <a href="http://www.revolutionanalytics.com/revolution-r-enterprise-distributedr" target="_blank">RRE DistributedR</a>.

- <a href="http://spotfire.tibco.com/discover-spotfire/what-does-spotfire-do/predictive-analytics/tibco-enterprise-runtime-for-r-terr" target="_blank">TIBCO Enterprise Runtime for R (TERR)</a>. A TIBCO version of R to be integrated on their TIBCO Spotfire analytics software.

- <a href="http://www.oracle.com/technetwork/database/database-technologies/r/r-distribution/overview/index.html" target="_blank">Oracle R Distribution</a>. This free version offers support for dynamic loading of linear algebra libraries (<a href="http://software.intel.com/en-us/intel-mkl" target="_blank">MKL</a>, <a href="http://developer.amd.com/tools-and-sdks/cpu-development/amd-core-math-library-acml/" target="_blank">ACML</a>, and <a href="http://www.oracle.com/technetwork/server-storage/solarisstudio/documentation/computing-jsp-140290.html" target="_blank">SPL</a>)

- <a href="http://www.oracle.com/technetwork/database/database-technologies/r/r-enterprise/overview/index.html" target="_blank">Oracle R Enterprise</a>.  This version integrates R with the Oracle data base.

- <a href="http://www.oracle.com/technetwork/database/database-technologies/bdc/r-advanalytics-for-hadoop/overview/index.html" target="_blank">Oracle R Advanced Analytics for Hadoop</a>. Equivalent to R Enterprise but to be integrated with Hadoop.

- <a href="http://www.renjin.org/" target="_blank">Renjin</a>. This is an Open Source implementation of R for the Java Virtual Machine (JVM). Commercial support is available.

- <a href="http://www.pqr-project.org/" target="_blank">pqR</a>. A "pretty quick version" of R, based on R-2.15.0 and licensed under GPL.

- <a href="https://bitbucket.org/allr/fastr/wiki/Home" target="_blank">FastR</a>. This version is an Open Source implementation of the R Language in Java.

- <a href="https://github.com/jtalbot/riposte/blob/master/README.md" target="_blank">Riposte</a>. C++ JIT Open Source implementation of R.

- <a href="http://xlsolutions-corp.com/order.aspx" target="_blank">R-Plus</a>. This company claims their product is the "Real R", but no detailed information can be found in their webpage. 

- Other commercial software using R as engine: <a href="http://www.informationbuilders.com/products/webfocus/predictivemodeling" target="_blank">WebFOCUS RStat</a>, <a href="http://www.statconn.com/" target="_blank">Statconn</a>.

## To finish

The fact that R is a free software has been crucial to its development and adoption among the data analysis community. When the code is open, anybody can verify that a certain algorithm is well implemented, collaborate with improvements, or correct bugs in a fast way. This spirit of collaboration promoted by open source/free software licences is inherited by R users, which have contributed to improve the characteristics of the software, developing packages making that any theoretical development of statistics or data analysis is almost immediately available to the world.

Nevertheless, those who require technical support or flawless integration with big data implementations can find high standard solutions provided by reputed companies such as Revolution R or Oracle. The adoption of R in the business world is now a reality, and besides the referred examples, many other big IT/analytics firms are recommending to integrate R with their systems. But we will speak about that integration in a further post...

Thank you for reading, and if you like the post please let your best friends know!

*Edit 2014-11-10* 

- Thanks to <a href="https://twitter.com/hadleywickham" target="_blank">Hadley Wickham </a> for mentioning that there is available a <a href="http://cran.R-project.org/web/packages/packages.rds" target="_blank">.rds file</a> with information of CRAN packages .

- Thanks to <a href="https://twitter.com/noamross" target="_blank">Noam Ross</a> for mentioning some R versions not included in the first version of this post. A comparison of some R versions can be found <a href="http://blog.revolutionanalytics.com/2014/07/dsc-2014.html" target="_blank">here</a> 