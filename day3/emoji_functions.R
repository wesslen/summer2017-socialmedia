## ---- utility functions ----
# this function outputs the emojis found in a string as well as their occurences
count_matches <- function(string, matchto, description, sentiment = NA) {
  
  vec <- str_count(string, matchto)
  matches <- which(vec != 0)
  
  descr <- NA
  cnt <- NA
  
  if (length(matches) != 0) {
    
    descr <- description[matches]
    cnt <- vec[matches]
    
  } 
  
  df <- data.frame(text = string, description = descr, count = cnt, sentiment = NA)
  
  if (!is.na(sentiment) & length(sentiment[matches]) != 0) {
    
    df$sentiment <- sentiment[matches]
    
  }
  
  return(df)
  
}

# this function applies count_matches on a vector o texts and outputs a data.frame
emojis_matching <- function(texts, matchto, description, sentiment = NA) {
  
  texts %>% 
    lapply(count_matches, matchto = matchto, description = description, sentiment = sentiment) %>%
    bind_rows
  
}

# function that separates capital letters hashtags
hashgrep <- function(text) {
  hg <- function(text) {
    result <- ""
    while(text != result) {
      result <- text
      text <- gsub("#[[:alpha:]]+\\K([[:upper:]]+)", " \\1", text, perl = TRUE)
    }
    return(text)
  }
  unname(sapply(text, hg))
}

# tweets cleaning pipe
cleanPosts <- function(text) {
  clean_texts <- text %>%
    gsub("<.*>", "", .) %>% # remove emojis
    gsub("&amp;", "", .) %>% # remove &
    gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", .) %>% # remove retweet entities
    gsub("@\\w+", "", .) %>% # remove at people
    hashgrep %>%
    gsub("[[:punct:]]", "", .) %>% # remove punctuation
    gsub("[[:digit:]]", "", .) %>% # remove digits
    gsub("http\\w+", "", .) %>% # remove html links
    iconv(from = "latin1", to = "ASCII", sub="") %>% # remove emoji and bizarre signs
    gsub("[ \t]{2,}", " ", .) %>% # remove unnecessary spaces
    gsub("^\\s+|\\s+$", "", .) %>% # remove unnecessary spaces
    tolower
  return(clean_texts)
}

# function that outputs a df of emojis with their top 5 words (by frequency)
wordFreqEmojis <- function(df, text = df$text, description = df$description, top = 5) {
  
  
  lapply(unique(description), function(x) {
    
    dat <- df %>% 
      filter(description == x)
    
    myCorpus <- Corpus(VectorSource(dat$text)) %>%
      tm_map(removePunctuation) %>%
      tm_map(stripWhitespace) %>%
      tm_map(removeWords, stopwords("english"))
    
    dtm <- DocumentTermMatrix(myCorpus)
    # find the sum of words in each Document
    rowTotals <- apply(dtm , 1, sum)
    dtm.new   <- dtm[rowTotals> 0, ]
    # collapse matrix by summing over columns
    freq <- colSums(as.matrix(dtm))
    # create sort order (descending)
    ord <- order(freq, decreasing=TRUE)
    
    list(emoji = rep(x, top), words = names(freq[ord][1:top]), frequency = freq[ord][1:top]) 
    
  }) %>% 
    bind_rows
  
}
