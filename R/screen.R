#' Screen for stocks
#'
#'@importFrom stringr str_c
#'@importFrom httr GET
#'@importFrom jsonlite fromJSON
#'
#'@export
screen <- function(exchange) {
  # Build the json request
  temp.url <- str_c(get('url_key', envir = .url_key),
    #open square bracket
    "%5B",
    exchange,


    #closing square bracket
    "%5D"

  )

  # request the data
  url.data <- try(httr::GET(temp.url, add_headers("user-agent" = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36", "Cache-Control" = "no-cache")))

  url.extract <- gsub("\\", "", url.data, fixed = TRUE)

  url.parse <- jsonlite::fromJSON(url.extract, flatten=TRUE)
}



