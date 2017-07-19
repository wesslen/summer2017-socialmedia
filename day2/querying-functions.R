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
