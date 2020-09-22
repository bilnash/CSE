#' Get IPO Date of a Stock
#'
#' @param symbol character string. Use \code{listed_symbols(type = "stock")}
#' to get all valid stock names in CSE
#'
#' @return Date
#'
#' @importFrom stringr str_trim
#' @importFrom stringr str_c
#' @importFrom httr GET
#' @importFrom httr POST
#' @importFrom httr add_headers
#' @importFrom xml2 read_html
#' @importFrom rvest html_node
#' @importFrom rvest html_attr
#' @importFrom rvest html_text
#' @importFrom lubridate dmy
#'
#' @export
#'
#' @examples
#' \dontrun{ipo_date('SNEP')}
#'
ipo_date <- function(symbol) {
    symbol_value <- stocks_metadata()[symbol] %>%
        stringr::str_trim()
    url <- KEY_INDICATORS_BASE_URL %>%
        stringr::str_c(symbol_value)
    get_request <- httr::GET(url, httr::add_headers('User-Agent' = 'Mozilla'))
    view_state <- get_request %>%
        xml2::read_html() %>%
        rvest::html_node(xpath = VIEW_STATE_XPATH) %>%
        rvest::html_attr('value')
    params <- list(
        '__VIEWSTATE' = view_state,
        '__EVENTTARGET' = 'SocieteCotee1$LBFicheTech'
    )
    Sys.sleep(1)
    post_request <- httr::POST(url,
                               body = params,
                               httr::add_headers('User-Agent' = 'Mozilla'))
    Sys.sleep(1)
    post_request %>%
        xml2::read_html() %>%
        rvest::html_node(xpath = IPO_DATE_XPATH) %>%
        rvest::html_text() %>%
        lubridate::dmy()
}
