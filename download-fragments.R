#-- Script fragments to access Databrary resources

#--- Source external package
library( httr )
library( XML )
library( jpeg )

#--- Get input
user <- readline( prompt="Enter username: " )
pw <- readline( prompt="Password: " )
volume.n <- readline(prompt="Volume #: " )
volume.n <- "81"
slot.n <- "9"
asset.n <- "13"
segment.n <- "1013875"
query.type <- "download"
inline.val <- "true"

# Build URL
url.databrary = "https://databrary.org"
url.download <- paste( url.databrary, "slot", slot.n, "asset", asset.n, query.type, sep="/")

# 
add_headers("x-requested-with","httr client whatever")
POST("https://nyu.databrary.org/api/user/login", body = list("email" = user, "password" = pw))

#--- Download excerpt image as jpg
type = "raw"

get.resp <- GET(url.download,
                query=list(segment=segment.n, inline.val="false"),
                verbose() )

if( status_code( get.resp ) == 200 ){
  mp4 <- content( get.resp, type )
}

#--- Download video
segment.n <- "1013875%2C1191103"
segment.n <- gsub( "%2C", ",", segment.n )
inline.val <- "true"
type <- "raw"

get.resp <- GET(url.download,
                query=list(segment=segment.n, inline.val="false"),
                verbose() 
)

if( status_code( get.resp ) == 200 ){
  mp4 <- content( get.resp, type )
}

#--- Download spreadsheet
type <- "text"
add_headers("X-Requested-With","XMLHttpRequest")
POST("https://nyu.databrary.org/api/user/login", body = list("email" = user, "password" = pw))
url.download <- paste( url.databrary, "volume", volume.n, "csv", sep="/")
get.resp <- GET(url.download,
                verbose() 
)
if( status_code( get.resp ) == 200 ){
  csv <- content( get.resp, type )
  df <- read.csv( csv )
}


#---- Private data

p <- POST("https://nyu.databrary.org/api/user/login", 
          body = list(email=user, password=pw),
          verbose()
          )
g <- GET("https://nyu.databrary.org/volume/81/csv",
         verbose() )
