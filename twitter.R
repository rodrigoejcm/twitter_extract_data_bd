library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)


## TWEETS FILTERED BY: '8802752','9317502','14594813'
#ESTADÃO #https://twitter.com/intent/user?user_id=9317502 
#G1 #https://twitter.com/intent/user?user_id=8802752 
#FOLHA DE SÃO PAULO #https://twitter.com/intent/user?user_id=14594813 

tweet <-  read_tsv("tweet.csv")
user <-  read_tsv("user.csv")
hashtag <-  read_tsv("hashtag.csv")
url <-  read_tsv("url.csv")
user_mention <-  read_tsv("user_mention.csv")
place <-  read_tsv("place.csv")

head(tweet)
head(user)
head(hashtag)
head(url)
head(user_mention)
head(place)

# Number of Tweets for each News Portal

tweet %>% 
  filter(user %in% c(8802752,9317502,14594813)) %>% 
  group_by(user) %>% 
  summarise(tweets = n())

# Number of Reply Tweets for each News Portal

tweet %>% 
  filter(in_reply_to_user_id %in% c(8802752,9317502,14594813)) %>% 
  group_by(in_reply_to_user_id) %>% 
  summarise(reply_tweets = n())

# Number of Retweets

tweet %>% 
  filter(retweet_from_tweet_id == "NULL") %>% 
  summarise(reply_tweets = n())


# Tweets / Time




tweets_time = tweet %>% 
  group_by(created_at) %>% 
  mutate(created_at <- ymd_hms(created_at)) %>%
  summarise(total = n())

tweets_time = tweets_time %>% 
  mutate("created_at_time" = paste(paste(year(created_at),month(created_at),day(created_at), sep = "-"),hour(created_at)))


ggplot(tweets_time, aes(created_at_time, total)) + geom_line() 


#mutate(created_at_hora <-  ) %>%








