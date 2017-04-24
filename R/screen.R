#' Screen for stocks
#'
#'@importFrom stringr str_c
#'@importFrom httr GET add_headers
#'@importFrom jsonlite fromJSON
#'
#'@export
screen <- function(market_cap = list(), pe_ratio = list(),
                   dividend_yield = list(), price_change_52week = list(),
                   price_to_book = list(),
                   current_assets_to_liabilities_ratio_year = list(),
                   longterm_debt_to_equity_year = list(),
                   return_on_equity_5years = list(),
                   net_income_growth_rate_5years = list(),
                   revenue_growth_rate_10years = list(),
                   eps_growth_rate_10years = list(),
                   interest_coverage_year = list(),
                   max_results = 1000
                   ) {
  
  #Lookup for temp.url
  lookup <- c('[' = '%5B', ']' = '%5D', '(' = '%28', ')' = '%29', '>' = '>', '<' = '<', '=' = '%3D', '&' = '%26')
  
  print(lookup)
  # Build the json request
  temp.url <- str_c(get('url_key', envir = .url_key),
    #open square bracket
    lookup[['[']],
    stringr::str_c(formulate_criteria('market_cap', market_cap, lookup),
                   formulate_criteria('pe_ratio', pe_ratio, lookup),
                   formulate_criteria('dividend_yield', dividend_yield, lookup),
                   formulate_criteria('price_change_52week', price_change_52week, lookup),
                   formulate_criteria('price_to_book', price_to_book, lookup),
                   formulate_criteria('current_assets_to_liabilities_ratio_year', current_assets_to_liabilities_ratio_year, lookup),
                   formulate_criteria('longterm_debt_to_equity_year', longterm_debt_to_equity_year, lookup),
                   formulate_criteria('return_on_equity_5years', return_on_equity_5years, lookup),
                   formulate_criteria('net_income_growth_rate_5years', net_income_growth_rate_5years, lookup),
                   formulate_criteria('revenue_growth_rate_10years', revenue_growth_rate_10years, lookup),
                   formulate_criteria('eps_growth_rate_10years', eps_growth_rate_10years, lookup),
                   formulate_criteria('interest_coverage_year', interest_coverage_year, lookup),
                   sep = str_c('+', lookup[['&']], '+')
                   ),
    #closing square bracket
    lookup[[']']],
    #'&restype=company&output=json&noIL=1&ei=-RPuWKGMMIuc0AT0tL6IBQ'
    '&restype=company&noIL=1&num=', max_results ,'&output=json&ei=57VwWOnoM4mi0wTw_oagBA'

  )


  # request the data
  url.data <- try(httr::GET(temp.url, add_headers("user-agent" = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36", "Cache-Control" = "no-cache")))

  url.extract <- gsub("\\", "", url.data, fixed = TRUE)

  url.parse <- jsonlite::fromJSON(url.extract, flatten=TRUE)
}


formulate_criteria <- function(criteria_name, criteria, lookup) {
  
  options(scipen = 999)
  # temporary environment
  formulateEnv <- new.env()
  
  # Assign switch
  assign(x = 'i',
         value = 1,
         envir = formulateEnv
  )
   
  
  temp <- purrr::map(criteria, function(x) {
    
    # Get i
    i <- get(x = 'i',
             envir= formulateEnv
    )
    print(i)
    
  
    if(i == 1) {
      print('here')
      operator <- lookup[['>']]
      
      assign(x = 'i',
             value = 2,
             envir = formulateEnv
      )
    } else {
      print('here 2')
      operator <- lookup[['<']]
    }
    print(x)
    stringr::str_c(lookup[['(']], criteria_name, '+', operator , lookup[['=']], '+',  x, lookup[[')']] )
  })
  
  rm(formulateEnv)
  temp <- str_c(temp, collapse = stringr::str_c('+', lookup[['&']], '+') )
}

