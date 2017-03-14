# databrary.login( url.login="https://nyu.databrary.org/api/user/login", save.credentials=TRUE )
#
# Queries for Databrary login credentials (email and password)
# then logs user in.
#----------------------------------------------------------

databrary.login <- function( login.url="/api/user/login", return.response=FALSE, save.session=TRUE, verbose=FALSE ){
  
  if (!exists("databrary.config.status")) {
    source("databrary.config.R")
    databrary.config(verbose = verbose)
  }
  
  email <- readline( prompt="Email: " )
  password <- readline( prompt="Password: " )
  cat("\014")   # clear console
  
  r <- POST(paste(databrary.url, login.url, sep = ""), body = list(email=email, password=password))
  
  rm(email, password)
  
  if ( status_code(r) == 200 ){
    if (verbose) cat( 'Login Successful.\n' )
    if (save.session){
      databrary.SESSION <- cookies(r)$value
      save(databrary.SESSION, file = ".databrary.RData")
    } else {
      rm( databrary.SESSION )      
    }
  } else if (verbose) cat( paste( 'Login Failed, HTTP status ', status_code(r), '\n', sep="" ) )
  
  if (return.response) return(r)
}