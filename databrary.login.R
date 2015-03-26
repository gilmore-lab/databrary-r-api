# databrary.login( url.login="https://nyu.databrary.org/api/user/login", save.credentials=TRUE )
#
# Queries for Databrary login credentials (email and password)
# then logs user in.
#----------------------------------------------------------

databrary.login <- function( login.url="/api/user/login", return.response=FALSE, save.session=TRUE ){
  
  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config()
  }
  
  email <- readline( prompt="Email: " )
  password <- readline( prompt="Password: " )
  cat("\014")   # clear console
  
  r <- POST(paste(databrary.url, login.url, sep = ""), body = list(email=email, password=password))
  
  rm(email, password)
  
  if ( status_code(r) == 200 ){
    cat( 'Login Successful.\n' )
    if (save.session){
      databrary.SESSION <- cookies(r)$SESSION
      save(databrary.SESSION, file = ".databrary.RData")
    }
    rm( databrary.SESSION )
  } else cat( paste( 'Login Failed, HTTP status ', status_code(r), '\n', sep="" ) )
  
  if (return.response) return(r)
}