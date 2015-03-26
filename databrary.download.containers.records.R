# download.containers.records( url.base = "https://nyu.databrary.org/api/volume", volume=2, convert.JSON = TRUE )
#
# Downloads container & record structure for given volume.
# Converts from JSON to native R structure if convert.JSON is true
#----------------------------------------------------------

databrary.download.containers.records <- function( url.base = "https://nyu.databrary.org/api/volume", volume=2, convert.JSON = TRUE, verbose=FALSE ){

  require( jsonlite )
  
  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config(verbose=verbose)
  }
  databrary.authenticate(verbose=verbose)
  
  url.cont.rec <- paste( url.base, "/", volume, "?", "containers&records", sep="" )
  
  g = GET( url.cont.rec )
  
  if ( status_code( g ) == 200 ){
    g.content <- content( g, 'text' )
    if( convert.JSON ){
      return( fromJSON( g.content ) )
    } else {
      return( g.content )       
    }
  } else if (verbose) cat( paste( 'Download Failed, HTTP status ', status_code(g), '\n', sep="" ) )
}
