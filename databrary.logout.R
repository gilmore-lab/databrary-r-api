# databrary.logout( logout.url="/api/user/logout" )
#
# Logs out user.
#----------------------------------------------------------

databrary.logout <- function(logout.url="/api/user/logout", return.response=FALSE){
  require(httr)
  databrary.url <- "https://nyu.databrary.org"
  set_config(add_headers(.headers = c("X-Requested-With" = "databrary R client")))
    
  r <- POST( paste(databrary.url, logout.url, sep = ""))
  
  if ( status_code(r) == 200 ){
    cat( 'Logout Successful.\n' )
    if (file.exists(".databrary.RData")) file.remove(".databrary.RData")
  } else cat( paste('Logout Failed, HTTP status ', status_code(r), '\n', sep="" ))
  if (return.response) return(r)
}