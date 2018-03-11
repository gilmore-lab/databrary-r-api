databrary_authenticate <- function(verbose=FALSE) {
  if (!exists("databrary_config_status")) {
    source("databrary_config.R")
    databrary_config(verbose = verbose)
  }

  # This gives 405 Method Not Allowed. Has method changed?
  if (".databrary.RData" %in% dir( all.files=TRUE ) ){
    load(".databrary.RData")
    set_config(config(cookie = paste("session=\"", databrary.SESSION, "\"", sep = "")))
    r <- HEAD(paste(databrary.url, "/volume/1", sep=""))
    if (status_code(r) != 200){
      if (verbose) {
        cat(sprintf("\nStatus %i. Must login again.\n", status_code(r)))
      }
      source("databrary_login.R")
      databrary_login()
    } else if(verbose) {
      cat("Authenticated to Databrary.\n")
    }
  } else {
    source("databrary_login.R")
    databrary_login()
  }
}