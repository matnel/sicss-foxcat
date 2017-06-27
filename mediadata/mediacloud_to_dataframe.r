library('jsonlite')

data <- fromJSON( 'collected.json', simplifyDataFrame=T )

## clean up some variables
data$publish_date <- as.POSIXct( data$publish_date, format="%Y-%m-%d %H:%M:%S" )
data$collect_date <- as.POSIXct( data$collect_date, format="%Y-%m-%d %H:%M:%S" )

data$media_name <- as.factor( data$media_name )


## basic descriptives
table( data$media_name )

save( data, file = 'collected.rdata' )
