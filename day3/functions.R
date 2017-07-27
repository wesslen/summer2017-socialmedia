timePlot<-
  function (x, smooth = FALSE, spn = 0.4)
  {
    library(ggplot2)
    library(dplyr) 
    x$Tweet_PostDate <- as.Date( x$postedTime)
    x$Tweet_Count <- 1
    
    by_time <- group_by(x, Tweet_PostDate)
    time.count <- summarise(by_time,Tweet_Count = sum(Tweet_Count))
    
    if (smooth) {
    ggplot( data = time.count, aes(x = Tweet_PostDate,y = Tweet_Count)) + 
      geom_line() + 
      ggtitle("Tweet Count per Day") +
      theme(axis.title = element_text(size = 22)) + 
      theme(plot.title = element_text(size = 22)) +
      theme(axis.text = element_text(size = 12)) +
      expand_limits(y = 0) + 
      geom_smooth(span = spn) +
      labs(x = "Tweet Posted Date", y = "Count of Tweets") 
    }
    
    else {
      ggplot( data = time.count, aes(x = Tweet_PostDate,y = Tweet_Count)) + 
        geom_line() + 
        ggtitle("Tweet Count per Day") +
        theme(axis.title = element_text(size = 22)) + 
        theme(plot.title = element_text(size = 22)) +
        theme(axis.text = element_text(size = 12)) +
        expand_limits(y = 0) + 
        labs(x = "Tweet Posted Date", y = "Count of Tweets") 
    }
  }

getCommonHashtags <- function(text, n=20){
  hashtags <- regmatches(text, gregexpr("#(\\d|\\w)+",text))
  hashtags <- unlist(hashtags)
  tab <- table(hashtags)
  return(head(sort(tab, dec=TRUE), n=n))
}

getCommonHandles <- function(text, n=20){
  handles <- regmatches(text, gregexpr('@([0-9_A-Za-z]+)',text, perl=TRUE))
  handles <- unlist(handles)
  tab <- table(handles)
  return(head(sort(tab, dec=TRUE), n=n))
}

mapPlot <-
  function (x, size = 2)
  {
    library(ggplot2)
    library(grid)
    library(maps)

    # keeping only geolocated tweets with precise long/lat information
    tweets <- x[!is.na(x$point_long),]
    
    ## Now we create a data frame with the map data 
    map <- map_data("county")
    nc <- subset(map, region %in% c("south carolina","north carolina"))
    
    # And finally we use ggplot2 to draw the map:
    # 1) map base
    ggplot(nc) + geom_map(aes(map_id = region), map = nc, fill = "grey90", 
                          color = "grey50", size = 0.25) + expand_limits(x = nc$long, y = nc$lat) + 
      # 2) limits for x and y axis
      scale_x_continuous(limits=c(-81.2,-80.5)) + scale_y_continuous(limits=c(35,35.5)) +
      # 3) adding the dot for each tweet
      geom_point(data = tweets, 
                 aes(x = point_lat, y = point_long), size = 2, alpha = 1/5, color = "darkblue") +
      # 4) removing unnecessary graph elements
      theme(axis.line = element_blank(), 
            axis.text = element_blank(), 
            axis.ticks = element_blank(), 
            axis.title = element_blank(), 
            panel.background = element_blank(), 
            panel.border = element_blank(), 
            panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(), 
            plot.background = element_blank()) 
  }


heatmapPlot <-
  function (x)
  {
    library(ggplot2)
    library(ggmap)
    library(RColorBrewer)
    library(ggrepel)  
    library(dplyr)
    
      CltMap <- qmap("charlotte", zoom = 12)

    xx <- x[!is.na(x$point_long),]
    
    temp <- xx %>% group_by(point_long,point_lat) %>% summarise(cnt = n())
    
    CltMap <- CltMap + 
                  stat_density2d(data = temp,
                     aes(x = point_lat, y = point_long, fill=..level.., alpha = ..level..),
                     size = 0.5, bins = 16, geom = "polygon") + 
                  theme(legend.position="none") + 
                  scale_fill_gradient(low = "green", high = "red") + 
                  scale_alpha(range = c(0, 0.5), guide = FALSE)
    CltMap <- CltMap +
      geom_point(aes(x = point_lat, y = point_long, size = cnt),
                 size = 0.5,
                 data = xx)
    CltMap

  }


topicmodels_json_ldavis <- function(fitted, dfm, dtm){
  # Required packages
  library(topicmodels)
  library(dplyr)
  library(stringi)
  library(quanteda)
  library(LDAvis)
  library(tm)
  
  # Find required quantities
  phi <- posterior(fitted)$terms %>% as.matrix
  theta <- posterior(fitted)$topics %>% as.matrix
  vocab <- colnames(phi)
  
  doc_length <- ntoken(dfm[rownames(dtm)])
  
  temp_frequency <- inspect(dtm)
  freq_matrix <- data.frame(ST = colnames(temp_frequency),
                            Freq = colSums(temp_frequency))
  rm(temp_frequency)
  
  # Convert to json
  json_lda <- LDAvis::createJSON(phi = phi, theta = theta,
                                 vocab = vocab,
                                 doc.length = doc_length,
                                 term.frequency = freq_matrix$Freq)
  
  return(json_lda)
}
