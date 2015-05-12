---
layout: post
title: "Connect, Share, Enjoy: R communities"
modified: 2015-05-09 21:32:53 +0200
tags: [Communities, Maps]
image:
  feature: 
  credit: 
  creditlink: 
comments: 
share: 
---


## Introduction

22 years later R is still growing, and more than ever. What started as a project to provide a "decent statistical software for our undergraduate Macintosh lab", nowadays is a standard solution for data analysis around the world, and is becoming big, very big. 

There are more than <a href="http://cran.r-project.org/web/packages/" target="_blank">6500 official packages on CRAN</a>, and <a href="https://github.com/trending?l=r" target="_blank">many others in github</a>; is calling <a href="http://www.fastcompany.com/3030063/why-the-r-programming-language-is-good-for-business" target="_blank">the attention of the media</a>; students are massively signing up for <a href="http://www.r-bloggers.com/moocs-and-courses-to-learn-r/" target="_blank">online R courses</a>; new <a href="http://www.amazon.com/s/ref=nb_sb_ss_i_1_13?url=search-alias%3Dstripbooks&field-keywords=r+programming&sprefix=r+programming%2Cstripbooks%2C246&rh=n%3A283155%2Ck%3Ar+programming" target="_blank">R-related books</a>
 appear every week, and many R users are writing about it in <a href="http://www.r-bloggers.com/" target="_blank">their blogs</a>.

So, how to be involved in this development? How to share with others the passion you feel about R?, or if you are starting, where you can find a place where look for help and learn from others?, how to avoid getting lost in this big wave? Well, be part of a community!

### Worldwide community: The UseR! Conference

Next june, in Aalborg, Denmark, will be the next <a href="http://user2015.math.aau.dk/" target="_blank">UseR! International Conference</a>. This is a great opportunity to meet other users, <a href="http://user2015.math.aau.dk/invited_talks" target="_blank">learn from the experts</a>, share your experience, participate in <a href="http://user2015.math.aau.dk/tutorials" target="_blank">tutorials</a>, and <a href="http://user2015.math.aau.dk/social_programme" target="_blank">have fun</a>. Abstract submission is now closed, but if you have the chance to attend is totally worth the effort.

Since global R users community can be too big, there are plenty of smaller groups united by a specific topic, platform, language, or city. In this post I will review some of these communities, who they are, what they are doing and where you can find them. Welcome to the R communities!

## R local users groups

This can be the easiest way to interact face to face with other R users. There are more than 150 local groups, most of them meeting regularly. The first alternative to an official list of R users groups around the world is provided by Revolution Analytics, who mantains <a href="http://blog.revolutionanalytics.com/local-r-groups.html" target="_blank">a directory</a>, and also <a href="http://www.revolutionanalytics.com/news-events/r-user-group/" target="_blank">sponsors them</a>. 

Most of those groups have a webpage on <a href="http://www.meetup.com/" target="_blank">meetup.com</a>, where you can look for R groups by location, join for free, and receive their news and details about the next meetings. For example, this is the meetup page of the <a href="http://www.meetup.com/LondonR/" target="_blank">LondonR group</a>. Meetup also provide a list of R-related groups <a href="http://r-users-group.meetup.com/all/" target="_blank">here</a>. 

To complement that information I would like to make a visualization of R local groups based on the meetup list. Since there is one interesting map with the geolocalization of the groups in <a href="http://blog.revolutionanalytics.com/2015/04/revolution-analytics-microsoft.html" target="_blank">the blog of Revolution Analytics</a>, I will propose something different: Using <a href="https://github.com/hadley/rvest" target="_blank">rvest</a> for webscrapping, <a href="https://github.com/hadley/dplyr" target="_blank">dplyr</a> for data crunching and <a href="https://github.com/rstudio/leaflet" target="_blank">leaflet</a> for visualization, I want to create a choropleth map of R users per country, and obtain the top five groups by number of members. You can see similar choropleths maps generated in R <a href="http://rstudio-pubs-static.s3.amazonaws.com/58323_1911658f7b8841f1b14b349b3804540d.html" target="_blank">here</a> and <a href="http://rstudio-pubs-static.s3.amazonaws.com/52396_1455dccab1c3469a84171787db504502.html" target="_blank">here</a>

I believe a blog post with R code is funnier than one without, except if that code is too long. So, forgive me that this time I will provide the code in a <a href="http://adolfoalvarez.cl/code/users.html" target="_blank">separate page</a> 

<figure>
<p data-height="350" data-theme-id="97" data-slug-hash="4d4fc4b2cb6a777aa6f015813cc41ad4" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/katydecorah/pen/4d4fc4b2cb6a777aa6f015813cc41ad4'>Mapbox -- Testing</a> by Katy DeCorah (<a href='http://codepen.io/katydecorah'>@katydecorah</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<figcaption>Demonstration with multiple locations.</figcaption>
</figure>

Notice that the meetup list is not comprehensive so there are some R users groups not included, for example the <a href="https://www.linkedin.com/grp/home?gid=3984607" target="_blank">Argentina R users group</a>, or the community where I am actively participating: the <a href="http://thinking-in-r.blogspot.com/" target="_blank">Poznan R users (PAZUR)</a>. Even if we are not in meetup we exist as you can see in this picture from the last meeting :)

![](/home/adolfo/Mis proyectos/blog/adolfoalvarez.github.com/images/pazur11_1.jpg) 

Besides those regular meetings from local communities, in some countries there is also a national R users conference. As an example, this year there are planned conferences in <a href="http://r2015-grenoble.sciencesconf.org/?lang=en" target="_blank">France</a> (24-26 June) and <a href="http://r-es.org/7jornadasR/" target="_blank">Spain</a>(5-6 November)

## Special interest R communities

<a href="https://ropensci.org/" target="_blank">**R Open Science**</a>

As its name says, in this community you can find enthusiastics about R and Open Science. The goal of this community is to provide tools to extract, analyze and reproduce scientific data. Their <a href="https://ropensci.org/packages/" target="_blank">R packages</a> can be classified into six categories: data, full-text of journal articles, altmetrics, data-publication, reproducibility and data visualization. You <a href="https://ropensci.org/community/" target="_blank">can contribute</a> to ROpenSci <a href="https://github.com/ropensci/onboarding#-ropensci-onboarding-" target="_blank"> with code</a>, <a href="http://github.com/ropensci/wishlist" target="_blank">new ideas</a>, by <a href="https://ropensci.org/ambassadors/" target="_blank">being an ambassador</a>, or attending <a href="https://ropensci.org/community/events.html" target="_blank">their meetings</a>. Their <a href="http://unconf.ropensci.org/" target="_blank">last "Unconf" meeting</a> in San Francisco was a big success bringing together developers from academics, industry and government. Similar meetings are expected for this year in London, and Australia.

<a href="http://www.bioconductor.org" target="_blank">**Bioconductor**</a>

More specific than the previous one, Bioconductor is a community of developers for the analysis of genomic data. They provide more than <a href="http://www.bioconductor.org/packages/release/BiocViews.html#___Software" target="_blank">1000 R packages</a>, and they organize an anual meeting, <a href="http://www.bioconductor.org/help/course-materials/2015/BioC2015/" target="_blank">this year in Seattle (July 21-22)</a>. They also maintain a <a href="https://stat.ethz.ch/mailman/listinfo/bioc-devel" target="_blank">mail list</a> and their own package <a href="http://www.bioconductor.org/developers/package-submission/" target="_blank">submission process</a>.

<a href="**EARL**" target="_blank">http://www.earl-conference.com</a>

<a href="http://www.mango-solutions.com/wp/" target="_blank">Mango Solutions</a> reunites business R users from several industries in the "Effective Applications of the R Language" conferences. This year there will be two editions: <a href="http://www.earl-conference.com/_London/index.html" target="_blank">London EARL</a> in September 14-16, and <a href="http://www.earl-conference.com/_Boston/index.html" target="_blank">Boston EARL</a>
 in November 2-4. For now the EARL community is focused on the conferences, but can be interesting to develop a stronger community of business users proposing packages or mail lists as Biocondutor and ROpenSci.

<a href="https://www.rmetrics.org/" target="_blank">**Rmetrics and Finances/Insurance community **</a>

<a href="https://www.rmetrics.org/" target="_blank">Rmetrics</a> is a community devoted to the development and documentation of R packages in optimization and risk management for financial and insurance applications. They also organize a <a href="https://www.rmetrics.org/zurich2015" target="_blank">summer workshop</a> on this topics in Zurich.

There are also two other options to meet useRs interested on finances and insurance: <a href="http://www.rinfinance.com/" target="_blank">Rinfinance</a> at the end of May in Chicago, and <a href="http://www.rininsurance.com/" target="_blank">Rininsurance</a> in June in Amsterdam. And if you can't make it you can also join the <a href="https://stat.ethz.ch/mailman/listinfo/r-sig-insurance" target="_blank">R-insurance</a> and <a href="https://stat.ethz.ch/mailman/listinfo/r-sig-finance" target="_blank">R-finance</a> mailing lists.

<a href="http://r-project.ro/conference2015/index.html" target="_blank">**Official Statistics**</a>

Users interested on official statistics will meet this year in Romania, for the third international conference "New challenges for statistical software - The use of R in official statistics". Although this is a nice oportunity to meet useRs in the field, it can be better to develop a stronger community in terms of regular or online meetings and the joint development of packages.

**Other meetings/conferences**

There are also many other options to meet R users in conferences not devoted exclusively to R. <a href="https://twitter.com/revojoe" target="_blank">Joseph Rickert</a> wrote a list of these events <a href="http://blog.revolutionanalytics.com/2015/02/r-conferences-in-2015.html" target="_blank">here</a>.  

<a href="https://twitter.com/rcatladies" target="_blank">**Special mention: Rcatladies**</a>

R and cats!

## Communities by platform

Now is time for virtual communities. Depending on the platform or application of your preference you can find a nice community of users to interact with.

<a href="http://www.r-project.org/mail.html" target="_blank">**Mailing lists**</a>

A classic source of information, discussion, and help about R. There are four main lists: <a href="http://stat.ethz.ch/mailman/listinfo/r-announce" target="_blank">R-announce</a> for major announcements, <a href="http://stat.ethz.ch/mailman/listinfo/r-packages" target="_blank">R-packages</a> for packages announcements, <a href="http://stat.ethz.ch/mailman/listinfo/r-help" target="_blank">R-help</a> is the main support list, and <a href="http://stat.ethz.ch/mailman/listinfo/r-devel" target="_blank">R-devel</a> for discussions about code development. There is also an official spanish language support list: <a href="https://stat.ethz.ch/mailman/listinfo/r-help-es" target="_blank">r-help-es</a>. Besides those, there are lists for <a href="http://www.r-project.org/mail.html#special-interest-groups" target="_blank">special interest groups</a> from varied topics such as <a href="https://stat.ethz.ch/mailman/listinfo/r-sig-geo" target="_blank">geographical data</a>, <a href="https://stat.ethz.ch/mailman/listinfo/r-sig-mixed-models" target="_blank">mixed models</a>, or <a href="https://stat.ethz.ch/mailman/listinfo/r-sig-teaching" target="_blank">teaching statistics</a> . 

<a href="https://twitter.com/hashtag/rstats" target="_blank">**Twitter**</a>

This is quickly becoming a primary source of information for new packages, support, interaction between users, etc. Just use the #rstats hashtag on twitter and you are in. Recently Tony Fischetti https://twitter.com/tonyfischetti published a post http://www.onthelambda.com/2015/02/28/playing-around-with-rstats-twitter-data/ analysing this hashtag, finding some of the related languages (python, d3js, and sas), the most tweeted packages (ggplot2, dplyr, and shiny), and the most prolific users (<a href="https://twitter.com/Rbloggers" target="_blank">@Rbloggers</a>, <a href="https://twitter.com/hadleywickham" target="_blank">@hadleywickham</a>, <a href="https://twitter.com/timelyportfolio" target="_blank">@timelyportfolio</a>)

<a href="https://plus.google.com/communities/117681470673972651781" target="_blank">**Google plus**</a>

With more than 11500 members, this is a very active community. It works as a news aggregator, their posts are organized into 10 categories including visualization, blog posts, or big data, and users can like ("+1"), comment, or "reshare" the content. You can also look for help and publish questions (but as it administrator claims: "Providing a minimally reproducible example").

<a href="http://stackoverflow.com/questions/tagged/r" target="_blank">**Stackoverflow**</a>

The king of the the Q&A website for programmers, Stackoverflow, allows anybody to ask a question, to answer it, and the best answers are voted by the community. If you don't know so much about this site I recommend you to start <a href="http://stackoverflow.com/tour" target="_blank">here</a>, but you can know in advance that the first "rule" is to learn <a href="http://stackoverflow.com/help/how-to-ask" target="_blank">asking a good question</a>, the second "rule" is <a href="http://stackoverflow.com/help/be-nice" target="_blank">to be nice!</a> 

SO includes a <a href="http://stackoverflow.com/questions/tagged/r" target="_blank">section for R</a>, which can be also accessed <a href="http://stackoverflow.com/feeds/tag/r" target="_blank">as RSS</a>. <a href="http://stackoverflow.com/tags/r/info" target="_blank">Here</a> you can find more info about the R community in SO, for example that it has more than 90k questions, or that the top five answerers are <a href="http://stackoverflow.com/users/143305/dirk-eddelbuettel" target="_blank">Dirk Eddelbuettel</a>, <a href="http://stackoverflow.com/users/1855677/bondeddust" target="_blank">BondedDust</a>, <a href="http://stackoverflow.com/users/429846/gavin-simpson" target="_blank">Gavin Simpson</a>, <a href="http://stackoverflow.com/users/1270695/ananda-mahto" target="_blank">Ananda Mahto</a>, and <a href="http://stackoverflow.com/users/602276/andrie" target="_blank">Andrie de Vries</a>. Other nice features are the two R chats one for advanced users http://chat.stackoverflow.com/rooms/106/r and one for beginners http://chat.stackoverflow.com/rooms/25312/r-public

Complementing the more general rule to ask a good question that I mentioned before, you can follow <a href="http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example" target="_blank">these guidelines</a> to include "a great R reproducible example" on it, so there is more easy for others to answer. If you want to answer there is even a R <a href="https://github.com/mrdwab/oveRflow" target="_blank">package</a> for that!  

<a href="https://www.linkedin.com/grp/home?gid=77616" target="_blank">**LinkedIn**</a>

Founded in 2008, "The R Project for Statistical Computing" group counts with more than 48k LinkedIn members, and as any other LinkedIn group there are three main categories: <a href="https://www.linkedin.com/grp/home?gid=77616" target="_blank">Discussions</a> where you can post and comment R related content, including questions, <a href="https://www.linkedin.com/groups?promosList=&gid=77616" target="_blank">Promotions</a> where announcements are made (Conferences, workshops, etc.) and <a href="https://www.linkedin.com/groups?jobs=&gid=77616" target="_blank">Jobs</a> where your R skills can make you jump in your career. Another advantage of being a member of a LinkedIn group is that allows you to connect with other members so you can enlarge your academic or business network.

## Conclusions

No matter if you are a <a href="http://www.r-project.org/foundation/members.html" target="_blank">member of the R foundation</a> (By the way, another community), or you are just starting with R, your progress on it will be funnier and better if you do it in community. Do it online, do it face to face, do it locally or globally, but do it since a community is also a great opportunity to know people, share, learn and collaborate. See you in one of them!

