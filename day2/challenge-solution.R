## Solution for Reply Network

replies <- subset(tweets, !is.na(in_reply_to_screen_name))

edges2 <- data.frame(
  node1 = replies$screen_name,
  node2 = replies$in_reply_to_screen_name,
  stringsAsFactors=F
)

g2 <- graph_from_data_frame(d=edges2, directed=TRUE)

visIgraph(g2) %>% 
  visInteraction(navigationButtons = TRUE) 