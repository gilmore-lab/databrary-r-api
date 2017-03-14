# databrary.download.csv( volume=1, to.df=TRUE )
#
# Downloads CSV spreadsheet from specified Databrary volume
# and converts to R data frame if desired
#----------------------------------------------------------

databrary.download.csv <- function( volume=1, to.df=TRUE, return.response=FALSE, verbose=FALSE ){

  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config(verbose=verbose)
  }
  
  databrary.authenticate(verbose=verbose)
  
  csv.url <- paste("/volume/", volume, "/csv", sep="")
  r = GET( paste(databrary.url, csv.url, sep="") )
  
  if ( status_code(r) == 200 ){
    r.content <- content( r, 'text' )
    if( to.df == TRUE ){
      r.df <- read.csv( text = r.content )
      if (class(r.df)=="data.frame") {
        return( r.df )
      } else {
        if (verbose) cat("Can't coerce to data frame. Skipping.\n")
        return( NULL )
      }
    } else {
      return( r.content )      
    }
  } else {
    if (verbose) cat( paste( 'Download Failed, HTTP status ', status_code(r), '\n', sep="" ) )
    if (return.response) return( r )
  }
}