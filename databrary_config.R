databrary_config <- function(verbose=FALSE) {
  # Determines if local environment has been configured for Databrary. If not,
  # sources required packages and commands and adds relevant defaults to .GlobalEnv
  #
  # Args:
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  
  if(!exists("databrary_config_status")){
    if (verbose) cat("Configuring for Databrary.\n")
    
    require(httr)
    source("databrary_login.R")
    source("databrary_authenticate.R")
    source("databrary_logout.R")
    
    assign('databrary.url', 'https://nyu.databrary.org', envir=.GlobalEnv)
    assign('databrary_config_status', 1, envir=.GlobalEnv)
    set_config(add_headers(.headers = c("X-Requested-With" = "databrary R client")))
    # TODO(someone): Check to see if there is a valid credentials file
  } else if (verbose) cat("Already configured.\n")
}
