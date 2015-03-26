databrary.authenticate <- function(verbose=FALSE) {

  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config(verbose=verbose)
  }
    
  if (".databrary.RData" %in% dir( all.files=TRUE ) ){
    load(".databrary.RData")
    set_config(config(cookie = paste("SESSION=\"", databrary.SESSION, "\"", sep = "")))
    r <- HEAD(paste(databrary.url, "/volume/1", sep=""))
    if (status_code(r) != 200){
      if (verbose) cat("Bad cookie. Login again.\n")
      databrary.login()
    } else if(verbose) cat("Authenticated to Databrary.\n")
  } else {
    source("databrary.login.R")
    databrary.login()
  }
}

