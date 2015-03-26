databrary.authenticate <- function() {

  if (!databrary.config.status){
    source("databrary.config.R")
    databrary.config()
  }
    
  if (".databrary.RData" %in% dir( all.files=TRUE ) ){
    load(".databrary.RData")
    set_config(config(cookie = paste("SESSION=\"", databrary.SESSION, "\"", sep = "")))
    r <- HEAD(paste(databrary.url, "/volume/1", sep=""))
    if (status_code(r) != 200){
      cat("Bad cookie. Login again.\n")
      databrary.login()
    } else cat("Authenticated to Databrary.\n")
  } else {
    source("databrary.login.R")
    databrary.login()
  }
}

