databrary_login <- function( login.url = "/api/user/login", 
                             return.response = FALSE, save.session = TRUE,
                             stored.credentials = TRUE,
                             credentials.file = "~/api-keys/json/databrary-keys.json",
                             verbose = FALSE ) {
  # Logs in to Databrary using stored credentials (default) or email & password provided at command line.
  #
  # Args:
  #  login.url: URL for login API. Default is "/api/user/login".
  #  return.response: Flag specifying whether to return the HTTP response. Default is FALSE.
  #  save.session: Flag specifying whether to save session info in a cookie. Default is TRUE.
  #  stored.credentials: Flag specifying whether to look for stored credientials. Default is TRUE.
  #  credentials.file: File path where credentials are stored. Default is "~/api-keys/json/databrary-keys.json".
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  
  if (!exists("databrary_config_status")) {
    source("databrary_config.R")
    databrary.config(verbose = verbose)
  }
  
  if (stored.credentials) {
    require(jsonlite)
    email <- fromJSON(credentials.file)$email
    password <- fromJSON(credentials.file)$pw
  } else {
    # TODO(someone): Make login more secure.
    email <- readline( prompt="Email: " )
    password <- readline( prompt="Password: " )
    cat("\014")   # clear console
  }
  
  r <- POST(paste(databrary.url, login.url, sep = ""), body = list(email=email, password=password))
  
  # TODO(someone): Make login more secure.
  rm(email, password)
  
  if (status_code(r) == 200){
    if (verbose) cat( 'Login Successful.\n' )
    if (save.session){
      databrary.SESSION <- cookies(r)$value
      save(databrary.SESSION, file = ".databrary.RData")
    } else {
      rm(databrary.SESSION)      
    }
  } else if (verbose) cat( paste( 'Login Failed, HTTP status ', status_code(r), '\n', sep="" ) )
  
  if (return.response) return(r)
}