databrary_download <- function(slot="12212/0,15046",
                               asset="46748", verbose=TRUE) {
  
  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config(verbose=verbose)
  }

  databrary.authenticate(verbose=verbose)
  
  asset.url <- paste0(databrary.url, "/slot/", slot, "/asset/", asset, "/download?inline=true")
  r = GET(asset.url)
  
  if ( status_code(r) == 200 ){
    if (verbose) cat("Success\n")
    contents <- content( r, 'raw' )
    return(contents)      
  } else {
    if (verbose) cat( paste( 'Download Failed, HTTP status ', status_code(r), '\n', sep="" ) )
    if (return.response) return( r )
  }
}