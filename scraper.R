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

#Create twitter token
#replace with your values
create_token(
  app = "PLACE YOUR APP NAME HERE",
  consumer_key = "PLACE YOUR CONSUMER KEY HERE",
  consumer_secret = "PLACE YOUR CONSUMER SECRET HERE")

############# Handmaiden's Tale Tweets #############

#Grab tweets - note: reduce to 1000 if it's slow
?search_tweets
hmt <- search_tweets(
  "#5G", n = 2000, include_rts = FALSE, lang = "en"
)

#Look at tweets
head(hmt)
dim(hmt)
hmt$text

#Unnest the words - code via Tidy Text

hmtTable <- hmt %>% 
  unnest_tokens(word, text)

#remove stop words - aka typically very common words such as "the", "of" etc

data(stop_words)

hmtTable <- hmtTable %>%
  anti_join(stop_words)

#do a word count

hmtTable <- hmtTable %>%
  count(word, sort = TRUE) 
hmtTable 

#Remove other nonsense words
hmtTable <-hmtTable %>%
  filter(!word %in% c('t.co', 'https', 'de', 'la', "it's", 'el', 'en',
                      'je', 'ep', 'week', 'amp'))


#wordcloud2
wordcloud2(hmtTable, size=8, backgroundColor = "black", color = "random-light")
