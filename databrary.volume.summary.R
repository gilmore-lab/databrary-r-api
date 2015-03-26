databrary.volume.summary <- function(volume=4, plot.style="ggplot"){

  df <- databrary.download.csv(volume=volume)
    
  # Convert dates to ages in days
  if("session.date" %in% names(df)) df$session.date <- as.Date(df$session.date)
  if("participant.birthdate" %in% names(df)) df$participant.birthdate <- as.Date(df$participant.birthdate)
  df$age.days <- as.numeric( df$session.date - df$participant.birthdate )
  
  if (plot.style=="ggplot"){
    p <- qplot( data=df, y = age.days, x=participant.gender, geom=c("boxplot"), color=participant.race )    
  } else {
    par(mfrow=c(1,2))
    plot(df$participant.gender ~ df$participant.race, xlab="", ylab="Race")
    hist(na.omit(df$age.days), xlab="Age (days)", main="")
  }
  return(p)
}