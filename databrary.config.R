databrary.config <- function(verbose=FALSE){
  if(!exists("databrary.config.status")){
    if (verbose) cat("Configuring for Databrary.\n")
    require(httr)
    source("databrary.login.R")
    source("databrary.authenticate.R")
    source("databrary.logout.R")
    assign('databrary.url', 'https://nyu.databrary.org', envir=.GlobalEnv)
    assign('databrary.config.status', 1, envir=.GlobalEnv)
    set_config(add_headers(.headers = c("X-Requested-With" = "databrary R client")))    
  } else if (verbose) cat("Already configured.\n")
}