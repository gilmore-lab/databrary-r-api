databrary_list_assets <- function(base.url = "https://nyu.databrary.org/api/volume/",
                                  volume = 75, slot = 9825, return.response = FALSE, 
                                  convert.JSON = TRUE, verbose = FALSE) {
  # Lists the assets given a volume and slot (session).
  #
  # Args:
  #  url.base: Base URL for API. Default is "https://nyu.databrary.org/api/volume"
  #  volume: Volume number to query. Default is 75.
  #  slot: Databrary slot number (integer). Default is 9825.
  #  asset: Databrary asset number (integer). Default is 11643.
  #  return.response: Flag specifying whether to return the HTTP response. Default is FALSE.
  #  convert.JSON: Flag specifying whether to convert HTTP response to JSON. Default is TRUE.
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  #
  # Returns:
  #  A list of session assets and related metadata.
  # 
  #  $id: slot/session number
  #  $top: ??
  #  $name: session name
  #  $assets (list)
  #    id, format, classification, duration, name, permission, size
  #
  #  So, x <- databrary_download_asset()
  #  x$assets[1] or x$assets['id'] gives array of asset ids

  # Error handling
  if (length(volume) > 1) {
    stop("Volume must have length 1.")
  }
  if ((!is.numeric(volume)) || volume <= 0 ) {
    stop("Volume must be > 0.")
  }
  if (length(slot) > 1) {
    stop("Slot must have length 1.")
  }
  if ((!is.numeric(slot)) || slot <= 0 ) {
    stop("Slot must be > 0.")
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

  slot.url <- paste0(base.url, volume, "/slot/", slot, "?assets")
  if (verbose) {
    cat(slot.url, "\n")
  }
  g <- GET(slot.url)
  if (status_code(g) == 200) {
    g.content <- content(g, 'text')
    if(convert.JSON) {
      return(fromJSON(g.content))
      } else {
      return(g.content)
      }
  } else if (verbose) {
    cat( paste( 'Download Failed, HTTP status ', status_code(g), '\n', sep="" ) )
  }
}