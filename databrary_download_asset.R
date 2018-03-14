databrary_download_asset <- function(file.name = "test.mp4", slot = 9825, asset = 11643,
                                     return.response=FALSE, verbose=FALSE) {
  # Downloads a Databrary asset given a volume, slot, asset and segment.
  #
  # Args:
  #  slot: Databrary slot number (integer). Default is 9825.
  #  asset: Databrary asset number (integer). Default is 11643.
  #  return.response: Flag specifying whether to return the HTTP response. Default is FALSE.
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  #
  # Returns:
  #  A specified (video or audio) asset.

  # Error handling
  if (!is.character(file.name)) {
    stop("File.name must be character string.")
  }
  if (length(slot) > 1) {
    stop("Slot must have length 1.")
  }
  if ((!is.numeric(slot)) || slot <= 0 ) {
    stop("Slot must be > 0.")
  }
  if (length(asset) > 1) {
    stop("Asset must have length 1.")
  }
  if ((!is.numeric(asset)) || asset <= 0 ) {
    stop("Asset must be > 0.")
  }
  
  require(rvest)
  query.type <- "download"
  # inline.val <- "true"

  if ((!exists("databrary_config_status")) || (!databrary_config_status)) {
    source("databrary_config.R")
    databrary_config(verbose=verbose)
  }

  source("databrary_authenticate.R")
  databrary_authenticate(verbose=verbose)

  asset.url <- paste("/slot", slot, "-", "asset", asset, query.type, sep="/")
  url.download <- paste0(databrary.url, asset.url)

  webpage <- html_session(url.download)
  if (webpage$response$status_code == 200) {
    content.type <- webpage$response$headers$`content-type`
    if (verbose) {
      cat("Successful HTML GET query\n")
      cat(paste0("Content-type is ", content.type, ".\n"))
    }
    # TODO(somebody): Add support for other content types
    if (content.type == "video/mp4") {
      if (file.name == "test.mp4") {
        if (verbose) {
          cat("File name unspecified. Generating unique name.\n")
        }
        file.name <- paste0(slot, "-", asset, "-", format(Sys.time(), "%F-%H%M-%S"), ".mp4")
      }
      if (verbose) {
        cat(paste0("Downloading video as ", file.name, "\n"))
      }
      download.file(webpage$handle$url, file.name, mode = "wb")
    }
  } else {
    if (verbose) cat(paste('Download Failed, HTTP status ', webpage$response$status_code, '\n', sep="" ))
    if (return.response) return(webpage$response)
  }
}