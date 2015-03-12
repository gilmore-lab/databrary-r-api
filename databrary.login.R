# databrary.login( url.login="https://nyu.databrary.org/api/user/login" )
#
# Queries for Databrary login credentials (email and password)
# then logs user in.
#----------------------------------------------------------

databrary.login <- function( url.login="https://nyu.databrary.org/api/user/login" ){
  require( httr )
  
  user.email <- readline( prompt="Email: " )
  user.pw <- readline( prompt="Password: " ) 
  post.body = list( "email"=user.email, "password"=user.pw )
  post.hdr = c("x-requested-with" = "true")
  
  p <- POST( url.login, 
             add_headers( .headers = post.hdr ), 
             body = post.body
  )
  
  if ( status_code(p) == 200 ){
    cat( 'Login Successful.\n' )
  } else
    cat( paste( 'Login Failed, HTTP status ', status_code(p), '\n', sep="" ) )
}