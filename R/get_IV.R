#' Get Historical Values of an INDEX
#'
#' Given a valid index code, this function returns the corresponding historical data
#' for the specified period (\code{from} until \code{to}). The returned dataframe
#' includes Date and Value columns.
#'
#' @param index_code a character vector of length one. Use \code{listed_symbols(type = "index")}
#' to list all valid indexes in CSE.
#' @param from a character vector of length one matching the format 'yyyy-mm-dd'
#' @param to a character vector of length one matching the format 'yyyy-mm-dd'
#'
#' @return a dataframe
#'
#' @note The difference between \code{to} and \code{from} should be less than or
#' equal 3 years.
#'
#' @importFrom httr GET
#' @importFrom httr POST
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#' @importFrom rvest html_node
#' @importFrom rvest html_nodes
#' @importFrom rvest html_table
#' @importFrom rvest html_attr
#' @importFrom xml2 read_html
#' @importFrom stringr str_replace_all
#' @importFrom dplyr rename
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{get_IV('MASI', '2014/01/01', '2016/12/31')}
#' \dontrun{get_IV('MADEX', '2017/01/01', '2017/06/30')}
#'
#'
get_IV <- function(index_code, from, to) {

    request <- GET(URL_INDEXES, add_headers('User-Agent' = 'Mozilla'))

    view_state <- request %>%
        read_html() %>%
        html_node(xpath = VIEW_STATE_XPATH) %>%
        html_attr('value')

    params <- list(
        '__EVENTTARGET' = 'IndiceHistorique1$LinkButton1',
        '__VIEWSTATE' = view_state,
        'IndiceHistorique1$historique' = 'RBSearchDate',
        'IndiceHistorique1$DDLIndice' = index_code,
        'IndiceHistorique1$DateTimeControl1$TBCalendar' = from,
        'IndiceHistorique1$DateTimeControl2$TBCalendar' = to
    )

    response <- POST(URL_INDEXES, body = params, add_headers('User-Agent' = 'Mozilla'))

    tryCatch({
        table <- response %>%
            read_html() %>%
            html_table() %>%
            .[[1]]

        names(table) <- table[1, ]
        table %<>% tail(n = -1L)
        table %<>% sapply(function(x) str_replace_all(x, ',', '.')) %>%
            as.data.frame(stringsAsFactors = FALSE)

        table$Session %<>% as.Date('%d/%m/%Y')
        table$Value %<>% as.numeric()

        table$Change <- NULL

        table %<>% dplyr::rename(Date = 'Session')

        return(
            table %>%
                tibble::as_tibble()
        ) # Already arranged in asc order
    },
    error = function(e) {
        #warning('Your query result is empty. Verify that you specified a valid symbol name or that the symbol was listed in CSE during the requested dates interval')
        return(data.frame())
    }
    )
}
