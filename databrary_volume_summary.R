databrary_volume_summary <- function(volume=4, plot.style="ggplot", verbose=FALSE){

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
      p <- qplot(data=df, y = age.days, x=participant.gender, geom=c("boxplot"), color=participant.race ) + 
        ggtitle(paste("Participant Characteristics for Databrary Volume ", volume, sep=""))
      return(list("data.frame"=df,"plot"=p))  
    } else {
      par(mfrow=c(1,2))
      plot(df$participant.gender ~ df$participant.race, xlab="", ylab="Race")
      hist(na.omit(df$age.days), xlab="Age (days)", main="")
    }
  } else if (verbose) cat("Nothing to plot.\n")
  return(list("data.frame"=df))  
}