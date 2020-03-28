install.packages("rtweet")
install.packages("tidytext")
install.packages("dplyr")
install.packages("stringr")
require(devtools)
install_github("lchiffon/wordcloud2")

library(tidytext)
library(dplyr)
library(stringr)
library(rtweet)
library(wordcloud2)

create_token(
  app = "PLACE YOUR APP NAME HERE",
  consumer_key = "PLACE YOUR CONSUMER KEY HERE",
  consumer_secret = "PLACE YOUR CONSUMER SECRET HERE")

#Grab tweets - note: reduce to 1000 if it's slow
hmt <- search_tweets(
  "#HandmaidsTale", n = 2000, include_rts = FALSE
)

# have a look at the data
head(hmt)
dim(hmt)
hmt$text

# Unnest the words - code via Tidy Text
hmtTable <- hmt %>% 
  unnest_tokens(word, text)

# remove stop words - aka typically very common words such as "the", "of" etc
data(stop_words)
hmtTable <- hmtTable %>%
  anti_join(stop_words)