databrary_download_containers_records <- function(url.base = "https://nyu.databrary.org/api/volume", 
                                                  volume = 2, convert.JSON = TRUE, verbose = FALSE ) {
  # Downloads container and record structure for a given Databrary volume
  # Converts from JSON to a native R structure if requested.
  #
  # Args:
  #  url.base: The base URL for the Databrary volume API. Default is "https://nyu.databrary.org/api/volume"
  #  volume: The Databrary volume (integer) to download. Default is 2.
  #  convert.JSON: Flag specifying whether to convert JSON to R data structure. Default is TRUE.
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  #
  # Returns:
  #  The containers and record structure for a specified volume as JSON or as an R list.
  
  # Error handling
  if (length(volume) > 1) {
    stop("Volume must have length 1.")
  }
  if ((!is.numeric(volume)) || (volume <= 0)) {
    stop("Volume must be an integer > 0.")
  }
  
  require(jsonlite)
  if ((!exists("databrary_config_status")) || (!databrary_config_status)){
    source("databrary_config.R")
    databrary_config(verbose=verbose)
  }
  databrary_authenticate(verbose=verbose)
  
  url.cont.rec <- paste(url.base, "/", volume, "?", "containers&records", sep="")
  
  g = GET(url.cont.rec)
  
  if (status_code( g ) == 200){
    g.content <- content(g, 'text')
    if(convert.JSON){
      return(fromJSON(g.content))
    } else {
      return(g.content)       
    }
  } else if (verbose) cat( paste( 'Download Failed, HTTP status ', status_code(g), '\n', sep="" ) )
}
