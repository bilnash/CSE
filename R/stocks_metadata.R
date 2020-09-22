#' Get Stocks Names and Associated HTML Values
#'
#' This helper function extracts names and HTML values (options values) of all
#' listed stocks in Casablanca Stock Exchange.
#'
#' @param request The object returned by an HTTP GET request. \code{NULL} by default.
#' @param with_values Boolean vector of length one indicating if the HTML values should be
#' returned or not. \code{TRUE} by default.
#'
#' @return A character vector containing all listed stocks. If \code{with_value} is true, a
#' named vector of HTML values is returned.
#'
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes
#' @importFrom rvest html_attr
#' @importFrom rvest html_text
#' @importFrom xml2 read_html
#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom utils tail
#'
#' @examples
#' \dontrun{stocks_metadata()}
#' \dontrun{stocks_metadata(with_values = FALSE)}
#' \dontrun{stocks_metadata(get_request, FALSE)}
#'
stocks_metadata <- function(request = NULL, with_values = TRUE) {

    if (is.null(request)) {
        request <- GET(URL, add_headers('User-Agent' = 'Mozilla'))
    }

    options <- request %>%
        read_html() %>%
        html_nodes(xpath = LISTED_SEC_XPATH)

    stocks_names <- options %>%
        html_text() %>%
        tail(n = -1L)

    if (!with_values) return(stocks_names)

    stocks_values <- options %>%
        html_attr('value') %>%
        tail(n = -1L)

    names(stocks_values) <- stocks_names
    return(stocks_values)

}
