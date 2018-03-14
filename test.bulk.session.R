# compile session summaries
databrary.session.summary <- function(){
  max_vols <- 100
  volumes <- c(1:max_vols)
  
  l = lapply( volumes, databrary.download.csv )
  
  df.all <- NULL
  for (v in volumes){
    this.v <- l[v]
    if (!is.null(unlist(this.v))){
      df <- do.call( rbind, lapply(this.v, data.frame, stringsAsFactors=FALSE) )
      birthdate.ok <- ("participant.birthdate" %in% names(df))
      gender.ok <- ("participant.gender" %in% names(df))
      session.date.ok <- ("session.date" %in% names(df))
      if( gender.ok && birthdate.ok && session.date.ok ) {
        includes <- c("participant.birthdate", "participant.gender", "session.date")
        df$volume.id <- rep(v, dim(df)[1])
        df.all <- rbind( df.all[,includes], df[,includes])
      }
    }
  }
  
  df.all$session.date <- as.Date(df.all$session.date)
  df.all$participant.birthdate <- as.Date(df.all$participant.birthdate)
  df.all$age.days <- as.numeric( df.all$session.date - df.all$participant.birthdate )
  hist( na.omit( df.all$age.days) )  
}

max_vols <- 100
volumes <- c(1:max_vols)

l = lapply( volumes, databrary.download.csv )

df.all <- NULL
for (v in volumes){
  this.v <- l[v]
  if (!is.null(unlist(this.v))){
    df <- do.call( rbind, lapply(this.v, data.frame, stringsAsFactors=FALSE) )
    birthdate.ok <- ("participant.birthdate" %in% names(df))
    gender.ok <- ("participant.gender" %in% names(df))
    session.date.ok <- ("session.date" %in% names(df))
    if( gender.ok && birthdate.ok && session.date.ok ) {
      includes <- c("participant.birthdate", "participant.gender", "session.date")
      df$volume.id <- rep(v, dim(df)[1])
      df.all <- rbind( df.all[,includes], df[,includes])
    }
  }
}

df.all$session.date <- as.Date(df.all$session.date)
df.all$participant.birthdate <- as.Date(df.all$participant.birthdate)
df.all$age.days <- as.numeric( df.all$session.date - df.all$participant.birthdate )
hist( na.omit( df.all$age.days) )