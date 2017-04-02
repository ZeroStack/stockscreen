## new environment for url_key
.url_key <- new.env(parent = emptyenv())

#' Set url key
#' Essential function to operate stock screen functions
#'
#' \code{set_urlkey} sets the url_key for stock screen functions
#'
#' The function takes a json filename and sets the url_key to the environent
#'
#' @importFrom jsonlite fromJSON
#'
#' @param filename a character vector of the json file
#'
#' @return NULL
#'
#' @export
set_url <- function(filename) {
  #check if file exists
  if(!file.exists(filename)) {
    stop('file ', filename, "does not exists")

  } else {
    url.key <- fromJSON(filename)
  }
}
#' set_url <- function(filename) {
#'   #check if file exists
#'   if(!file.exists(filename))
#'
#'
#' }
