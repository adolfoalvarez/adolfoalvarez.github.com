---
layout: post
title: "The Hitchhiker's Guide to the Hadleyverse"
modified: 2015-02-19 00:00:00 +0100
tags: [Hadley, Wickham, Hadleyverse]
image:
  feature: post6.jpg
  credit: Hubblesite
  creditlink: http://hubblesite.org/gallery/album/galaxy/pr2015002a/warn/hires/true/
comments: true
share: 
---

<meta name="twitter:site" content="@adolfoalvarez">
<meta name="twitter:creator" content="@adolfoalvarez">
<meta name="twitter:url" content="http://adolfoalvarez.cl/the-hitchhikers-guide-to-the-hadleyverse/">
<meta name="twitter:title" content="The Hitchhiker's Guide to the Hadleyverse">
<meta name="twitter:description" content="What is the Hadleyverse, and why it is so important for R?">
<meta name="twitter:image" content="http://adolfoalvarez.cl/images/post6.jpg">

May I ask you something? How long have you been using R? If you are just starting with it there is a (small) chance you don't know who Hadley Wickham is. If this is not your case, feel free to jump to the third paragraph... ok, so where we were?, of course!, let me introduce you mr. Wickham:

<a href="http://had.co.nz/" target="_blank">Hadley Wickham</a>  is an adjunct assistant professor at <a href="http://statistics.rice.edu/feed/FacultyDisplay.aspx?FID=3340" target="_blank">Rice University</a>, and Chief Scientist at <a href="http://www.rstudio.com/" target="_blank">RStudio</a>. He is also a main contributor to R in several ways: as <a href="https://github.com/hadley" target="_blank">developer of packages</a>, as <a href="http://www.amazon.com/gp/search/ref=sr_adv_b/?search-alias=stripbooks&field-author=Hadley+Wickham" target="_blank">author of books</a>, as <a href="https://stat.ethz.ch/pipermail/r-announce/2014/000577.html" target="_blank">member of the R Foundation</a>, as participant in forums such as <a href="http://stackoverflow.com/users/16632/hadley" target="_blank">stackoverflow</a>, <a href="https://groups.google.com/forum/#!searchin/manipulatr/hadley$20wickham" target="_blank">google groups</a>, or <a href="http://r.789695.n4.nabble.com/template/NamlServlet.jtp?macro=user_nodes&user=124291" target="_blank">R mail lists</a>, as speaker in <a href="https://www.youtube.com/watch?v=wki0BqlztCo" target="_blank">many R related forums</a>, as intensive <a href="https://twitter.com/search?f=realtime&q=%40hadleywickham%20%23rstats" target="_blank">twitter user of the #rstats hashtag</a>, and a long etc.

### The Hadleyverse

The "Hadleyverse" is the collection of R packages developed by Hadley Wickham, including tools for data manipulation, plotting, creation of packages, etc. But be patient, we will see them in detail later. The "Hadleyverse" concept implies that by loading and working with those packages you can not only extend the features of base R, but even change the way you code and the strategy you follow to analyse your data (for example, both plyr and dplyr packages follow the <a href="http://www.jstatsoft.org/v40/i01/paper" target="_blank">"split-apply-combine"</a> rule).

Is not clear what is the origin of the word, since this is the kind of words that are usually born drinking a beer during a R Users meeting, but searching the web we see some of the first mentions <a href="http://ctrlq.org/first/1511-hadleyverse/" target="_blank">here (3 Oct 2013)</a>, <a href="http://hackerretreat.com/2014/04/07/" target="_blank">here (7 Apr 2014)</a>, or <a href="http://www.gettinggeneticsdone.com/2014/08/do-your-data-janitor-work-like-boss.html" target="_blank">here (20 aug 2014)</a>. Anyway, now is a well know concept among R users, and it has inspired a <a href="https://github.com/imanuelcostigan/hadleyverse" target="_blank">package</a>, a <a href="https://github.com/rocker-org/hadleyverse" target="_blank">docker</a>, a <a href="http://barryrowlingson.github.io/hadleyverse/" target="_blank">presentation</a>, and of course this post.


### A general map of the Hadleyverse

For this guide of the Hadleyverse we will consider all the packages authored by Hadley Wickham as main author or collaborator which are published on CRAN. A good source of information of the CRAN packages can be found in the "packages.rds" file, that we will download and process to get the packages of the Hadleyverse:


{% highlight r %}
  library(lazyeval)
library(dplyr)
library(igraph)

#Import as data frame the RDS file with packages information. It can be obtained from CRAN,
download.file("http://cran.r-project.org/web/packages/packages.rds", "packages.rds")
rds <- readRDS(file="packages.rds")
data <- as.data.frame(rds, stringsAsFactors = FALSE)

# Clean column names
data <- data[,!duplicated(names(data))] #Eliminate duplicated names column
names(data) <- gsub(" ","_", names(data))
names(data) <- gsub("/","_", names(data))
names(data) <- gsub("@","_", names(data))

#And now we convert it to a tbl_df class to use it with dplyr
data <- tbl_df(data)
data

## Source: local data frame [6,333 x 40]
## 
##        Package Version Priority                                   Depends
## 1           A3   0.9.2       NA            R (>= 2.15.0), xtable, pbapply
## 2          abc     2.0       NA R (>= 2.10), nnet, quantreg, MASS, locfit
## 3  ABCanalysis     1.0       NA                               R (>= 2.10)
## 4     abcdeFBA     0.4       NA    Rglpk,rgl,corrplot,lattice,R (>= 2.10)
## 5  ABCExtremes     1.0       NA                 SpatialExtremes, combinat
## 6     ABCoptim 0.13.11       NA                                        NA
## 7        ABCp2     1.1       NA                                      MASS
## 8     abctools     1.0       NA   R (>= 2.10), abc, abind, parallel, plyr
## 9          abd   0.2-7       NA   R (>= 3.0), nlme, lattice, grid, mosaic
## 10        abf2   0.7-0       NA                                        NA
## ..         ...     ...      ...                                       ...
## Variables not shown: Imports (chr), LinkingTo (chr), Suggests (chr),
##   Enhances (chr), License (chr), License_is_FOSS (chr),
##   License_restricts_use (chr), OS_type (chr), Archs (chr), MD5sum (chr),
##   NeedsCompilation (chr), Authors_R (chr), Author (chr), BugReports (chr),
##   Contact (chr), Copyright (chr), Description (chr), Encoding (chr),
##   Language (chr), Maintainer (chr), Title (chr), URL (chr),
##   SystemRequirements (chr), Type (chr), Path (chr), Classification_ACM
##   (chr), Classification_JEL (chr), Classification_MSC (chr), Published
##   (chr), VignetteBuilder (chr), Additional_repositories (chr),
##   Reverse_depends (chr), Reverse_imports (chr), Reverse_linking_to (chr),
##   Reverse_suggests (chr), Reverse_enhances (chr)

# Filter all packages authored by Hadley Wickham, and select a subset of variables
hadley <- data %>%
  filter(grepl("Hadley Wickham|Hadley\nWickham", Author)) %>%
  select(Package, Author, Depends, Imports, Suggests, LinkingTo, Enhances)

#Vector of packages
packages <- unique(hadley$Package)
length(packages)

## [1] 55
  {% endhighlight %}
  
We see that the Hadleyverse is composed by 55 packages. To obtain a "map" of all of them we will analyse how they relate each other by four different ways: Depends, Imports, Suggests, LinkingTo, and Enhances. We obtain the relationships with the following code:


{% highlight r %}
  #Create a function to extract names of related packages in the form package1, package2
relations <- function(var){
  temp <- strsplit(var, ",") #Split string of dependences
  package2 <- unlist(temp) #
  #Eliminate some characters...
  package2 <- gsub(" ","", package2) 
  package2 <- gsub("\\(.*\\)","",package2)
  package2 <- gsub("\n","",package2)
  package1 <- rep(hadley$Package,unlist(lapply(temp,length))) #Obtain the corresponding id
  df <- data.frame(package1,package2, stringsAsFactors = FALSE)
  #We want only related packages created by H.W.
  df <- df %>%
    filter(package2%in%packages,
           package2!=package1
           )
  return(df)
}

#Apply the function to each variable and collapse the resulting list to a single data frame
hadley2 <- lapply(hadley, relations)
hadley2 <- do.call("rbind", hadley2)

#Eliminate possible duplicates
edges <- tbl_df(distinct(hadley2))  
edges

## Source: local data frame [139 x 2]
## 
##      package1   package2
## 1  clusterfly     rggobi
## 2       ggmap    ggplot2
## 3    nullabor    ggplot2
## 4    tourrGui      tourr
## 5   bigrquery       httr
## 6   bigrquery assertthat
## 7   bigrquery      dplyr
## 8       broom       plyr
## 9       broom      dplyr
## 10      broom      tidyr
## ..        ...        ...
  {% endhighlight %}

Now that we have a list of relations, we will use the igraph package to obtain our map. First we will create the igraph object, define the graphical properties of the network and discover communities (Clusters of nodes). A node will be bigger when is more connected to other packages, and the communities will be identified with colours.


{% highlight r %}
  #We create the igraph object
g <- graph.data.frame(edges, vertices= packages,  directed = F) # We create the igraph object based on the "edges" data frame

# Edges Properties

E(g)$arrow.width <- 0 # I don't want end of arrows to be displayed but that can change in the future
E(g)$curved <- 0.2 #Make edges curved
E(g)$color  <- "#BFBFBF"
E(g)$width  <- 10

# Vertex Properties
V(g)$label.family <- "sans" #Label font family
V(g)$label.cex <- 3 # Label font size proportional to 12
V(g)$label.color <- "#333333" # Label font color
V(g)$label.font <- 2 #1 plain, 2 bold, 3 italic, 4 bold and italic
V(g)$size <- degree(g, mode = "in", loops = F) #Size proportional to degree
cl <- optimal.community(g) #Find communities in the network

#Color of vertices based on communities
V(g)$color <- unlist(c("#E2D200", "#BFBFBF", "#46ACC8", "#E58601", rep("#BFBFBF",6))[cl$membership])
V(g)$frame.color <- unlist(c("#E2D200", "#BFBFBF", "#46ACC8", "#E58601", rep("#BFBFBF",6))[cl$membership])
set.seed(123)
layout <- layout.kamada.kawai(g)
  {% endhighlight %}

There are several possible layouts to plot the network, I choose one which seems to correctly separate the communities, but you can try different configurations by checking <a href="http://www.inside-r.org/packages/cran/igraph/docs/layout" target="_blank">this</a>. Finally we save the plot in a png file which I reproduce below:


{% highlight r %}
  png(filename="hadleyverse.png", width=2*1920, height=2*1080) #call the png writer
plot(g, margin=-0.1, layout=layout)
dev.off()
  {% endhighlight %}

<a href = "{{ site.url }}/images/hadleyverse.png" target="_blank">![hadleyverse]({{ site.url }}/images/hadleyverse.png) </a>


We detected three communities or groups of packages, let me call them "systems" of the Hadleyverse, and some set of isolated dots representing those packages which are not related to any other, so I will call them "comets". 

### The "1st generation of graphics and data transformation" system.

**Main stars: ggplot2, plyr**

This is the system of the "classic" tools of the Hadleyverse, with two main groups, the graphical tools leaded by "ggplot2", and the data transformation leaded by "plyr". Both plyr and ggplot2 have several years of development, and they are well documented and widely used by the community, although recently both packages have evolved into "dplyr" and "ggvis", so there is less development efforts over them, and can be expected that they will be completely replaced by the new generation in the medium term.

**Tools for graphics:**

- <a href="https://github.com/hadley/classifly" target="_blank">classifly</a>: Visualise high-dimensional classification boundaries with GGobi.
- <a href="https://github.com/hadley/clusterfly" target="_blank">clusterfly</a>: Visualising high-dimensional clustering algorithms.
- <a href="https://github.com/ggobi/DescribeDisplay" target="_blank">DescribeDisplay</a>: Turn GGobi graphics into publication quality R graphics.
- <a href="https://github.com/cran/geozoo" target="_blank">geozoo</a>: Zoo of Geometric Objects.
- <a href="https://github.com/ggobi/ggally" target="_blank">Ggally</a>: Ally to ggplot2.
- <a href="https://github.com/dkahle/ggmap" target="_blank">ggmap</a>: Plotting maps in R with ggplot2.
- <a href="https://github.com/hadley/ggplot2" target="_blank">ggplot2</a>: An implementation of the Grammar of Graphics in R.
- <a href="https://github.com/garrettgman/ggsubplot" target="_blank">ggsubplot</a>: Embed subplots in ggplot2 graphics in R.
- <a href="https://github.com/hadley/gtable/" target="_blank">gtable</a>: Tools to make it easier to work with "tables" of grobs.
- <a href="https://github.com/hadley/meifly" target="_blank">meifly</a>: An R package for exploring ensembles of (generalised) linear models.
- <a href="https://github.com/ggobi/nullabor" target="_blank">nullabor</a>: Easy graphical inference for R.
- <a href="https://github.com/hadley/profr" target="_blank">profr</a>: An alternative profiling package for R.
- <a href="https://github.com/ggobi/rggobi" target="_blank">rggobi</a>: Interface between R and GGobi.
- <a href="https://github.com/hadley/scales" target="_blank">scales</a>: Graphical scales.
- <a href="https://github.com/ggobi/tourr" target="_blank">tourr</a>: An implementation of tour algorithms in R.
- <a href="https://github.com/cran/tourrGui" target="_blank">tourrGui</a>: A Tour GUI using gWidgets.
- <a href="https://github.com/karthik/wesanderson" target="_blank">wesanderson</a>: A Wes Anderson color palette for R.

**Tools for data manipulation:**

- <a href="https://github.com/cran/itertools/" target="_blank">itertools</a>: Iterator Tools.  
- <a href="https://github.com/hadley/plyr" target="_blank">plyr</a>: Splitting, applying and combining large problems into simpler problems.
- <a href="https://github.com/hadley/reshape" target="_blank">reshape</a>: Flexible rearrange, reshape and aggregate data.
- <a href="https://github.com/cran/reshape2" target="_blank">reshape2</a>: Flexibly reshape data: a reboot of the reshape package.

**Data packages:**

- <a href="https://github.com/rforge/histdata" target="_blank">HistData</a>: A collection of data sets that are interesting and important in the history of statistics and data visualization.


### The "tools for programmers and reproducibility" system

**Main stars: testthat, knitr**

This is the system of the R programmers, where the big star is "testthat", developed in the <a href="http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf" target="_blank">words of Hadley Wickham</a> "because I discovered I was spending too much time recreating bugs that I had previously fixed. While I was writing the original code or fixing the bug, I’d perform many interactive tests to make sure the code worked, but I never had a system for retaining these tests and running them, again and again."

In this system you will find four main groups: Tools to help developing R packages, to simplify writing good code, to manipulate specific classes of data, and for reproducibility.


**Tools to make your life easier while creating R packages:**

- <a href="https://github.com/hadley/devtools" target="_blank">devtools</a>: Tools to make an R developer's life easier.
- <a href="https://github.com/hadley/rappdirs" target="_blank">rappdirs</a>: A port of AppDirs for R.
- <a href="https://github.com/yihui/Rd2roxygen" target="_blank">Rd2roxygen</a>: package documentation.
- <a href="https://github.com/yihui/roxygen2" target="_blank">roxygen2</a>: In-source documentation for R.
- <a href="https://github.com/rstudio/rstudioapi" target="_blank">rstudioapi</a>: Safely access rstudio's api (when available).

**Tools to make your life easier while coding in general:**

- <a href="https://github.com/hadley/evaluate" target="_blank">evaluate</a>: A version of eval for R that returns more information about what happened.
- <a href="https://github.com/hadley/testthat" target="_blank">testthat</a>: An R package to make testing fun.
- <a href="https://github.com/smbache/magrittr" target="_blank">magrittr</a>: R package to bring forward-piping features ala F#'s \|> operator. Ceci n'est pas un pipe.
- <a href="https://github.com/hadley/memoise" target="_blank">memoise</a>: Easy memoisation for R.
- <a href="https://github.com/ggobi/plumbr" target="_blank">plumbr</a>: Mutable dynamic data structures for R.
- <a href="https://github.com/hadley/pryr" target="_blank">pryr</a>: Pry open the covers of R.

**Tools to manipulate specific classes of data:**

- <a href="https://github.com/hadley/httr" target="_blank">httr</a>: A friendly http package for R.
- <a href="https://github.com/hadley/lubridate" target="_blank">lubridate</a>: Make working with dates in R just that little bit easier.
- <a href="https://github.com/hadley/rvest" target="_blank">rvest</a>: Simple web scraping for R.
- <a href="https://github.com/hadley/stringr" target="_blank">stringr</a>: Wrapper for R string functions to make them more consistent, simpler and easier to use.

**Tools for reproducibility:**

- <a href="https://github.com/yihui/knitr" target="_blank">knitr</a>: A general-purpose tool for dynamic report generation in R.
- <a href="https://github.com/rstudio/rmarkdown" target="_blank">rmarkdown</a>: Dynamic Documents for R.

### The "Data manipulation" system: 

**Main star: dplyr**

This is the system to ease the data processing, it includes the new generation versions of reshape2 and plyr, called tidyr and dplyr, allowing <a href="http://vita.had.co.nz/papers/tidy-data.html" target="_blank">to stop suffering with messy data</a> and bringing new verbs to analyse data such as filter, select, mutate, arrange and summarise. In combination with magrittr's "%>%" pipe it can completely change the way you work with data frames in R.

**Tools to manipulate data:**
              
- <a href="https://github.com/hadley/assertthat" target="_blank">assertthat</a>: User friendly assertions for R.
- <a href="https://github.com/hadley/bigrquery" target="_blank">bigrquery</a>: An interface to Google's bigquery from R.
- <a href="https://github.com/dgrtwo/broom" target="_blank">broom</a>: Convert statistical analysis objects from R into tidy format.
- <a href="https://github.com/hadley/dplyr" target="_blank">dplyr</a>: Plyr specialised for data frames: faster & with remote datastores, .
- <a href="https://github.com/hadley/lazyeval" target="_blank">lazyeval</a>: A strategy for doing non-standard evaluation (NSE) in R.
- <a href="https://github.com/rstats-db/RMySQL" target="_blank">RMySQL</a>: An R interface for MySQL.
- <a href="https://github.com/rstats-db/RSQLite" target="_blank">RSQLite</a>: R interface for SQLite.
- <a href="https://github.com/hadley/tidyr" target="_blank">tidyr</a>: Easily tidy data with spread and gather functions.  

**Data packages:**

- <a href="https://github.com/hadley/fueleconomy" target="_blank">fueleconomy</a>: EPA fuel economy data in an R package.
- <a href="https://github.com/hadley/nycflights13" target="_blank">nycflights13</a>: All out-bound flights from NYC in 2013 + useful metadata.
                         
### Comets of the Hadleyverse

These are packages which doesn't belong to any of the other systems, where three of them are data packages:
                    
- <a href="https://github.com/hadley/babynames" target="_blank">babynames</a>: All baby names data from the SSA.
- <a href="https://github.com/cran/fda" target="_blank">fda</a>: Functional Data Analysis.
- <a href="https://github.com/hadley/hflights" target="_blank">hflights</a>: Flights departing Houston in 2011.
- <a href="http://cran.r-project.org/web/packages/namespace/index.html" target="_blank">namespace</a>: Provide namespace management functions not (yet) present in base R.
- <a href="https://github.com/hadley/nasaweather" target="_blank">nasaweather</a>: Data from the 2006 ASA data expo.
- <a href="https://github.com/edenduthie/plotrix" target="_blank">plotrix</a>: Plotrix library for R.
                         
### In progress work

Besides those packages in CRAN, taking a look into the github repositories of Hadley Wickham and RStudio we can find out what packages he is currently working in that maybe soon we can see in CRAN. Some promising examples are:

- <a href="https://github.com/hadley/fastread" target="_blank">fastread</a>: Faster ways to read data.
- <a href="https://github.com/hadley/haven" target="_blank">haven</a>: Read SPSS, Stata and SAS files from R.
- <a href="https://github.com/hadley/lineprof" target="_blank">lineprof</a>: Visualise line profiling results in R.
- <a href="https://github.com/hadley/purrr" target="_blank">purrr</a>: A FP package for R in the spirit of underscore.js.
- <a href="https://github.com/hadley/rv2" target="_blank">rv2</a>: Simple rv package to practice developing packages with.
- <a href="https://github.com/hadley/tanglekit" target="_blank">tanglekit</a>: R bindings for Brett Victor's tangle.js.
- <a href="https://github.com/hadley/xml2" target="_blank">xml2</a>: Bindings to libxml2.

### Conclusions

I hope you have enjoyed this short guide to the Hadleyverse, and I wish you can now travel with more confidence through it. For sure you will find a package which suits your needs or will make your life more easy, just give them a chance!. And in case you are asking how is possible for a single person to develop so many packages, maybe is because <a href="http://hadley.wickham.usesthis.com/" target="_blank">he uses this</a>, or maybe because he understands <a href="https://twitter.com/hadleywickham/status/565516733516349441" target="_blank">the power of frustration</a>, or maybe because he just wants <a href="http://bulletin.imstat.org/2014/12/hadley-wickham-impact-the-world-by-being-useful/" target="_blank">to impact the world by being useful</a>. But maybe is better to let himself to answer that question <a href="http://www.quora.com/How-is-Hadley-Wickham-able-to-contribute-so-much-to-R-particularly-in-the-form-of-packages" target="_blank">here</a>. 

Thank you for reading and thanks Hadley Wickham for the Hadleyverse!

42.

