# databrary.download.csv( volume=1, to.df=TRUE )
#
# Downloads CSV spreadsheet from specified Databrary volume
# and converts to R data frame if desired
#----------------------------------------------------------

databrary.download.csv <- function( volume=1, to.df=TRUE, return.response=FALSE ){

  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config()
  }
  
  databrary.authenticate()
  
  csv.url <- paste("/volume/", volume, "/csv", sep="")
  r = GET( paste(databrary.url, csv.url, sep="") )
  
  if ( status_code(r) == 200 ){
    r.content <- content( r, 'text' )
    if( to.df == TRUE ){
      return( read.csv( text = r.content ) )
    } else {
      return( r.content )      
    }
  } else {
    cat( paste( 'Download Failed, HTTP status ', status_code(r), '\n', sep="" ) )
    return( r )
  }
}