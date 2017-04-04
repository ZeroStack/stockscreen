#' Screen for stocks
#'
#'@importFrom stringr str_c
#'
#'@export
screen <- function(exchange) {
  str_c(
    #open square bracket
    "%5B",
    exchange



    #closing square bracket
    "%5D"

  )

}

