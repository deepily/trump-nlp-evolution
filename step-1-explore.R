library( data.table )
library( dplyr )
library( ggplot2 )

tweets <- fread( 'data/tweets-clean.csv', header = T, sep = ',' )
summary( tweets )

tweets_grp <- dplyr::group_by( tweets, year, month )
tweets_sum <- dplyr::summarise( tweets_grp, count=n() )
tweets_ord <- dplyr::arrange( tweets_sum, year, month )
head( tweets_ord )
nrow( tweets_ord )

# months abbreviation courtesy of: 
# https://stackoverflow.com/questions/22058393/convert-a-numeric-month-to-a-month-abbreviation
# tweets_ord$x <- paste( tweets_ord$year, month.abb[ tweets_ord$month ] )
tweets_ord$x <- paste( tweets_ord$year, formatC( tweets_ord$month, width=2, format="d", flag="0" ), sep="-" )



head( tweets_ord )
max( tweets_ord$count )

#ggplot( tweets_ord, aes( x=x ) ) + stat_count( geom='line', aes( y=count ) )

# Need to add group=1
# https://stackoverflow.com/questions/27082601/ggplot2-line-chart-gives-geom-path-each-group-consist-of-only-one-observation
ggplot( tweets_ord, aes( x, count, group=1 ) ) + 
    geom_line() +
    #scale_x_date( format = "%b-%Y") + 
    xlab( "Date" ) + 
    ylab( "Tweets per Month" ) +
    theme( axis.text.x = element_text( angle=60, hjust=1 ) )

