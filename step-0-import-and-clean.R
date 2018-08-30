library( data.table )
library( bit64 )
library( lubridate )
library( dplyr )

tweets <- fread( 'data/tweets.csv', header = T, sep = ',', select=c( "created_at","text", "is_retweet") )
colnames( tweets )
tweets$is_retweet <- as.logical( tweets$is_retweet )
summary( tweets$is_retweet )
head( tweets$is_retweet )

# 05-04-2009 18:54:25
tweets$created_at <- as.Date( tweets$created_at, "%m-%d-%Y" )
summary( tweets )

tweets$year = year( tweets$created_at )
tweets$month = month( tweets$created_at )
tweets$day = day( tweets$created_at )

summary( tweets )
fwrite( tweets, file="data/tweets-clean.csv" )
