list_institutions <- function(inst.list = 8) {
  # Creates a list of Databrary institutions as data.frame
  #
  # Args:
  #  inst.list: list or array of party indices. Default is 8.
  #
  # Returns:
  #  Data frame with institutional information
  
  # Error handling
  if (sum((inst.list < 0))) {
    stop("Institution indices must be > 0")
  }
  
  # Get one institution's data
  list_inst <- function(party) {
    source("databrary_download_party.R")
    source("is_institution.R")
    if (is_institution(party)) {
      databrary_download_party(party)
    }
  }
  
  if (length(inst.list) == 1) {
    as.data.frame(list_inst(inst.list))
  } else {
    l <- sapply(inst.list, list_inst)
    Reduce(function(x,y) merge(x,y, all=TRUE), l[-which(sapply(l, is.null))])
  }
}
