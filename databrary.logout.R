# databrary.logout( url.login="https://nyu.databrary.org/api/user/logout" )
#
# Logs out user.
#----------------------------------------------------------

databrary.logout <- function( url.logout="https://nyu.databrary.org/api/user/logout" ){
  require( httr )
  
  post.hdr = c("x-requested-with" = "true")
  
  p <- POST( url.logout, 
             add_headers( .headers = post.hdr )
)
  
  if ( status_code(p) == 200 ){
    cat( 'Logout Successful.\n' )
  } else
    cat( paste( 'Logout Failed, HTTP status ', status_code(p), '\n', sep="" ) )
}