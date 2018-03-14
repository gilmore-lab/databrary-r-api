# From https://stackoverflow.com/questions/36202414/r-download-image-using-rvest

library(rvest); library(dplyr)
url <- "http://www.calacademy.org/explore-science/new-discoveries-an-alaskan-butterfly-a-spider-physicist-and-more"
webpage <- html_session(url)
link.titles <- webpage %>% html_nodes("img")
img.url <- link.titles %>% html_attr("src")
download.file(img.url, "test1.jpg", mode = "wb")

url <- "https://nyu.databrary.org/slot/9825/-/asset/11643/download?inline=true"
webpage <- html_session(url)

if (webpage$response$status_code == 200) {
  cat("Whoohoo! ")
  if (webpage$response$headers$`content-type` == "video/mp4") {
    cat("It's a video!")
  }
}
download.file(webpage$handle$url, "test-video.mp4", mode = "wb")