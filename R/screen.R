#' Screen for stocks
#'
#'@importFrom stringr str_c
#'@importFrom httr GET add_headers
#'@importFrom jsonlite fromJSON
#'
#'@export
screen <- function(market_cap = list()) {
  
  #Lookup for temp.url
  lookup <- c('[' = '%5B', ']' = '%5D', '(' = '%28', ')' = '%29', '>' = '>', '<' = '<', '=' = '%3D', '&' = '%26')
  
  # Build the json request
  temp.url <- str_c(get('url_key', envir = .url_key),
    #open square bracket
    lookup[['[']],
    


    #closing square bracket
    lookup[[']']]

  )


  # request the data
  url.data <- try(httr::GET(temp.url, add_headers("user-agent" = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36", "Cache-Control" = "no-cache")))

  url.extract <- gsub("\\", "", url.data, fixed = TRUE)

  url.parse <- jsonlite::fromJSON(url.extract, flatten=TRUE)
}


formulate_criteria <- function(criteria_name, criteria) {
  # initalise counter
  i <- 1
  temp <- purrr::map(criteria, function(x) {
    if(i == 1) {
      operator <- lookup[['<']]
    } else {
      operator <- lookup[['<']]
    }
    
    #increment counter
    i <- i + 1
    stringr::str_c(lookup[['(']], criteria_name, '+', operator , lookup[['=']], '+',  x, lookup[[')']] )
  })
  
  temp <- str_c(temp, collapse = stringr::str_c('+', lookup[['&']], '+') )
}

