databrary_summarize_volume <- function(volume = 4, plot.style="ggplot", verbose=FALSE) {
  # Downloads volume CSV and plots summary data for participant race, ethnicity, and age
  #
  # Args:
  #  volume: Databrary volume (integer). Default is 4.
  #  plot.style: Type of plotting commands to use. Default is 'ggplot'.
  #  verbose: Flag specifying whether to provide verbose status messages. Default is FALSE.
  
  # Error handling
  if (length(volume) > 1) {
    stop("Volume must have length 1.")
  }
  if ((!is.numeric(volume)) || (volume <= 0)) {
    stop("Volume must be an integer > 0.")
  }
  
  require(ggplot2)
  source("databrary_download_csv.R")
  
  df <- databrary_download_csv(volume=volume, verbose=verbose)
  if (is.null(df)) {
    stop("Download failed.")
  }
  
  # Convert dates to ages in days
  if("session.date" %in% names(df)) {
    df$session.date <- as.Date(df$session.date)
  }
  if("participant.birthdate" %in% names(df)) {
    df$participant.birthdate <- as.Date(df$participant.birthdate)
    df$age.days <- as.numeric( df$session.date - df$participant.birthdate )
  }
  
  if (("participant.gender" %in% names(df)) & ("participant.race" %in% names(df))) {
    if (plot.style=="ggplot"){
      require(ggplot2)
      p <- qplot(data=df, y = age.days, x=participant.gender, geom=c("boxplot"), color=participant.race) + 
        ggtitle(paste("Participant Characteristics for Databrary Volume ", volume, sep=""))
      return(list("data.frame"=df,"plot"=p))  
    } else {
      par(mfrow=c(1,2))
      plot(df$participant.gender ~ df$participant.race, xlab="", ylab="Race")
      hist(na.omit(df$age.days), xlab="Age (days)", main="")
    }
  } else if (verbose) cat("Nothing to plot.\n")
  # TODO(someone): Add support for other types of plotting, e.g. base graphics
  return(list("data.frame"=df))  
}