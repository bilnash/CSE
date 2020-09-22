#' Get Indexes Codes and Associated HTML Names (Description)
#'
#' This helper function extracts the names and HTML values (options values) of all
#' available indexes in Casablanca Stock Exchange.
#'
#' @param request The object returned by an HTTP GET request. \code{NULL} by default.
#' @param with_description Boolean vector of length one indicating if the description
#' (HTML names) should be returned or not. \code{TRUE} by default.
#'
#' @return A character vector containing all available indexes codes.
#' If \code{with_description} is true, a data frame with INDEX_CODE and DESCRIPTION
#' columns is returned.
#'
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes
#' @importFrom rvest html_attr
#' @importFrom rvest html_text
#' @importFrom xml2 read_html
#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom stringr str_trim
#'
#' @examples
#' \dontrun{indexes_metadata()}
#' \dontrun{indexes_metadata(with_description = FALSE)}
#' \dontrun{indexes_metadata(get_request, FALSE)}
#'
#'
indexes_metadata <- function(request = NULL, with_description = TRUE) {

    if (is.null(request)) {
        request <- GET(URL_INDEXES, add_headers('User-Agent' = 'Mozilla'))
    }

    options <- request %>%
        read_html() %>%
        html_nodes(xpath = INDEXES_XPATH)

    indexes_values <- options %>%
        html_attr('value')

    if (!with_description) return(indexes_values)

    indexes_description <- options %>%
        html_text() %>%
        str_trim()

    return(data.frame(INDEX_CODE = indexes_values,
                      DESCRIPTION = indexes_description,
                      stringsAsFactors = FALSE))

}
