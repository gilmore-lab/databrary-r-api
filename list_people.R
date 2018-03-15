list_people <- function(people.list = 7) {
  # Creates a list of Databrary people as data.frame
  #
  # Args:
  #  people.list: list or array of party indices. Default is 7.
  #
  # Returns:
  #  Data frame with institutional information
  
  # Error handling
  if (sum((people.list < 0))) {
    stop("Person indices must be > 0")
  }
  
  # Get one institution's data
  list_people <- function(party) {
    source("databrary_download_party.R")
    source("is_institution.R")
    if (is_person(party)) {
      databrary_download_party(party)
    }
  }
  
  if (length(people.list) == 1) {
    as.data.frame(list_people(inst.list))
  } else {
    l <- sapply(people.list, list_people)
    Reduce(function(x,y) merge(x,y, all=TRUE), l[-which(sapply(l, is.null))])
  }
}
