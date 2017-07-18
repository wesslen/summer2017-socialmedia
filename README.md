# Social Media Analytics Summer Workshop Series with R

## Sponsored by 

* [Project Mosaic](https://projectmosaic.uncc.edu/)

## Date, Time and Location

* July 18 (Part 1), July 20 (Part 2), and July 27 (Part 3) 

* 9:30 am - 12:30 pm

* Kennedy 234
 
## Instructor

* [Ryan Wesslen](http://wesslen.github.io)

This three part workshop series will cover three major tools for computational social scientist toolkit to analyze social media data. In addition to hands-on working materials, each workshop will include 2-3 important research papers and GitHub repositories. These workshops will use R and participants are required to bring their own laptops with R and R Studio pre-installed. Previous experience with R is required (e.g., setting up working directory, installing/loading packages, read/write flat files like CSV, and basic dataframe manipulation).

Many of the tools were created by political scientists and therefore most examples will focus on political-related events although they can easily be applied to other social sciences (e.g., geography, communications, management, sociology, public health).

## Schedule for the Workshops

| Day 1: Tues July 18 | Acquiring Social Media Data via APIs (Twitter and Facebook)  |
| ------------------- | ------------------------------------------------------- |
| Lecture             | [Introduction to Social Media Analytics](./slides/intro.pdf)              |
| Hands On Tutorial   | [Facebook API](./day1/facebook-api.Rmd)   |
| Hands On Tutorial   | [Twitter REST API](./day1/twitter-rest.Rmd) |
| Hands On Tutorial   | [Twitter Streaming API](./day1/twitter-streaming.Rmd) |

| Day 2: Thur July 20 | Querying, Handling and Visualizing Social Media Data    |
| ------------------- | ------------------------------------------------------- |
| Lecture             | [Data Management for Social Media](./slides/data-management.pdf)          |
| Hands On Tutorial   | [Querying Twitter Data](./day2/querying.Rmd) |
| Hands On Tutorial   | [Data Overview](./day2/overview.Rmd) |
| Hands On Tutorial   | [Visualizing using HTMLWidgets & Flexdashboard](./day2/visualization.Rmd) |

| Day 3: Thur July 27 | Text as data: Analyzing Social Media Content            |
| ------------------- | ------------------------------------------------------- |
| Lecture             | [Text as Data for Social Media]()                       |
| Case Study          | [TBD]()|

## Setup and Preparation

### R Knowledge

This workshop assumes you have basic knowledge of how to :

* Set your working directory
* Install R packages via CRAN
* Handle R dataframes with [`tidyverse`](http://tidyverse.org/) packages like [`ggplot`](http://ggplot2.tidyverse.org/), [`dplyr`](http://dplyr.tidyverse.org/), and [`readr`](http://readr.tidyverse.org/)
* [`rmarkdown`](http://rmarkdown.rstudio.com/articles_intro.html) knowledge

It's ok if you're not familiar with these tools, but if you are not, please look over Brooke Anderson's helpful [R Introduction Slides](https://github.com/geanders/RProgrammingForResearch/raw/master/slides/CourseNotes_Week1.pdf). This is the introduction to her great [R Programming for Research Workshop Materials](https://github.com/geanders/RProgrammingForResearch), which I strongly suggest if you're looking for R introduction materials.

### Preparation

You will need [R](https://cran.r-project.org/) and [RStudio](https://www.rstudio.com/) installed on your laptop. 

Also, please install these packages by running this code:

```{r}
packages <- c("tidyverse","Rfacebook","twitteR","streamR","rmarkdown","devtools",
              "quanteda","stm","tidytext","tidyr","wordcloud","reshape2")

install.packages(packages)
```

### Downloading Materials

To download the materials, please click the "Clone or Download" button in the top right of this page. Then save the materials as a zip file onto your computer (e.g., Desktop). 

