library( data.table )
library( dplyr )
library( ggplot2 )
library( scales )

tweets <- fread( 'data/tweets-clean.csv', header = T, sep = ',' )
#tweets$date <- as.Date( tweets$date )
summary( tweets )
str( tweets )

tweets_grp <- dplyr::group_by( tweets, year, month )
tweets_sum <- dplyr::summarise( tweets_grp, count=n() )
tweets_ord <- dplyr::arrange( tweets_sum, year, month )
head( tweets_ord )
nrow( tweets_ord )

# months abbreviation courtesy of: 
# https://stackoverflow.com/questions/22058393/convert-a-numeric-month-to-a-month-abbreviation
tweets_ord$month_abb <- paste( tweets_ord$year, month.abb[ tweets_ord$month ] )

tweets_ord$date <- as.Date( paste( tweets_ord$year, formatC( tweets_ord$month, width=2, format="d", flag="0" ), "01", sep="-" ) )
str( tweets )
class( tweets$date )
head( tweets_ord )
max( tweets_ord$count )

#ggplot( tweets_ord, aes( x=date ) ) + stat_count( geom='line', aes( y=count ) )

# Need to add group=1
# https://stackoverflow.com/questions/27082601/ggplot2-line-chart-gives-geom-path-each-group-consist-of-only-one-observation

# TODO: Find a way to include more ticks on x axis, say every other month in a year?
ggplot( tweets_ord, aes( date, count, group=1 ) ) + 
    geom_line() +
    #scale_x_date( format = "%b-%Y") + 
    xlab( "Date" ) + 
    ylab( "Tweets per Month" ) +
    theme( axis.text.x = element_text( angle=60, hjust=1 ) ) +
    scale_y_continuous( limits = c( 0, 1000), breaks=seq( 0, 1000, 100 ) ) #+ 
    #scale_x_date( date_breaks = "months" , date_labels = "%b-%y" )


# add more precision to hour of tweet
tweets$hour_minute <- tweets$hour + ( tweets$minute / 60.0 )

# scatter plot of hour of tweets (y) by date
ggplot( tweets, aes( x = created_at, y = hour_minute ) ) +
    geom_point()
