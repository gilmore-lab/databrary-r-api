# databrary.download.party( party=1, to.df=TRUE )
#
# Downloads info from specified Databrary party (individual/institution)
# and converts to R data frame if desired
#----------------------------------------------------------

databrary.download.party <- function( party=6, to.df=TRUE, return.response=FALSE ){

  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config()
  }
  
  databrary.authenticate()
  
  party.url <- paste("/api/party/", party, sep="")
  r = GET(paste(databrary.url, party.url, sep=""))
  
  if ( status_code(r) == 200 ){
    r.content <- content( r, 'text' )
    if( to.df == TRUE ){
      return(read.csv(text = r.content))
    } else {
      return(r.content)      
    }
  } else {
    cat( paste('Download Failed, HTTP status ', status_code(r), '\n', sep=""))
    return(r)
  }
}