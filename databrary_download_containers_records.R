# download.containers.records( url.base = "https://nyu.databrary.org/api/volume", volume=2, convert.JSON = TRUE )
#
# Downloads container & record structure for given volume.
# Converts from JSON to native R structure if convert.JSON is true
#----------------------------------------------------------

databrary_download_containers_records <- function( url.base = "https://nyu.databrary.org/api/volume", volume=2, convert.JSON = TRUE, verbose=FALSE ){

  require(jsonlite)
  
  if (!databrary_config_status){
    source("databrary_config.R")
    databrary_config(verbose=verbose)
  }
  databrary_authenticate(verbose=verbose)
  
  url.cont.rec <- paste( url.base, "/", volume, "?", "containers&records", sep="" )
  
  g = GET( url.cont.rec )
  
  if ( status_code( g ) == 200 ){
    g.content <- content( g, 'text' )
    if( convert.JSON ){
      return(fromJSON( g.content ))
    } else {
      return(g.content)       
    }
  } else if (verbose) cat( paste( 'Download Failed, HTTP status ', status_code(g), '\n', sep="" ) )
}