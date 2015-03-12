# download.csv( volume=1, to.df=TRUE )
#
# Downloads CSV spreadsheet from specified Databrary volume
# and converts to R data frame if desired
#----------------------------------------------------------

download.csv <- function( volume=1, to.df=TRUE ){
  require( httr )
  
  url.csv <- paste( "https://nyu.databrary.org/volume", volume, "csv", sep="/" )
  
  g = GET( url.csv )
  
  if ( status_code( g ) == 200 ){
    g.content <- content( g, 'text' )
    if( to.df == TRUE ){
      return( read.csv( text = g.content ) )
    } else {
      return( g.content )      
    }
  } else {
    cat( paste( 'Download Failed, HTTP status ', status_code(g), '\n', sep="" ) )
  }
}