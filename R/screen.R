#' Screen for stocks
#'
#'@importFrom stringr str_c
#'
#'@export
screen <- function(exchange) {
  temp.req <- str_c(get('url_key', envir = .url_key),
    #open square bracket
    "%5B",
    exchange,


    #closing square bracket
    "%5D"

  )

}



