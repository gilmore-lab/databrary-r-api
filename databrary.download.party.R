# databrary.download.party( party=1, to.df=TRUE )
#
# Downloads info from specified Databrary party (individual/institution)
# and converts to R data frame if desired
#----------------------------------------------------------

databrary.download.party <- function( party=6, to.df=TRUE, return.response=FALSE ){
  require(httr)
  databrary.url <- "https://nyu.databrary.org"
  set_config(add_headers(.headers = c("X-Requested-With" = "databrary R client")))
    
  if (".databrary.RData" %in% dir( all.files=TRUE ) ){
    load(".databrary.RData")
    set_config(config(cookie = paste("SESSION=\"", databrary.SESSION, "\"", sep = ""))) 
  } else {
    source("databrary.login.R")
    databrary.login()
  }
  
  party.url <- paste("/api/party/", party, sep="")
  r = GET( paste(databrary.url, party.url, sep="") )
  
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