databrary_download_csv <- function(volume=1, to.df=TRUE, return.response=FALSE, verbose=FALSE) {
  # Downloads a Databrary session spreadsheet as a CSV.
  #
  # Args:
  #  volume: Databrary volume number (integer). Default is 1.
  #  to.df: Flag specifying whether to convert CSV to a data.frame. Default is TRUE.
  #  return.response: Flag specifying whether to return the HTTP response. Default is FALSE.
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  #
  # Returns:
  #  A CSV or data frame if available or the HTTP response if requested.

  # Error handling
  if (length(volume) > 1) {
    stop("Volume must have length 1.")
  }
  if ((!is.numeric(volume)) || (volume <= 0)) {
    stop("Volume must be an integer > 0.")
  }
  
  if ((!exists("databrary_config_status")) || (!databrary_config_status)) {
    source("databrary_config.R")
    databrary_config(verbose=verbose)
  }
  
  source("databrary_authenticate.R")
  databrary_authenticate(verbose=verbose)
  
  csv.url <- paste("/volume/", volume, "/csv", sep="")
  r = GET(paste(databrary.url, csv.url, sep=""))
  
  if (status_code(r) == 200){
    r.content <- content(r, 'text')
    if(to.df == TRUE){
      r.df <- read.csv(text = r.content)
      if (class(r.df)=="data.frame") {
        return(r.df)
      } else {
        if (verbose) cat("Can't coerce to data frame. Skipping.\n")
        return(NULL)
      }
    } else {
      return(r.content)      
    }
  } else {
    if (verbose) cat(paste('Download Failed, HTTP status ', status_code(r), '\n', sep="" ))
    if (return.response) return(r)
  }
}