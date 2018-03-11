# databrary.logout( logout.url="/api/user/logout", verbose=TRUE )
#
# Logs out user.
#----------------------------------------------------------

databrary_logout <- function(logout.url="/api/user/logout", return.response=FALSE, verbose=TRUE){

  if (!exists("databrary_config_status")) {
    source("databrary_config.R")
    databrary.config(verbose = verbose)
  }
  
  r <- POST( paste(databrary.url, logout.url, sep = ""))
  
  if (status_code(r) == 200){
    if (verbose) cat( 'Logout Successful.\n' )
    if (file.exists(".databrary.RData")) file.remove(".databrary.RData")
  } else if (verbose) cat( paste('Logout Failed, HTTP status ', status_code(r), '\n', sep="" ))
  if (return.response) return(r)
}
