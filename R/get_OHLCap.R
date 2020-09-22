#' Get Open, High, Low and Capitalisation
#'
#' Given a valid stock name listed in CSE, this function returns the corresponding financial
#' data for the specified period (\code{start_date} until \code{end_date}). The returned
#' dataframe includes Date, Open, High, Low and Capitalisation.
#'
#' @param stock_name a character vector of length one. Use \code{listed_symbols(type = "stock")}
#' to list all valid stocks names listed in CFM.
#' @param from a character vector of length one matching the format 'yyyy-mm-dd'
#' @param to a character vector of length one matching the format 'yyyy-mm-dd'
#'
#' @return a dataframe
#'
#' @note The difference between \code{to} and \code{from} dates should be less than or
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
#' @importFrom dplyr arrange_
#' @importFrom dplyr rename_
#'
#' @examples
#' \dontrun{get_OHLCap('COSUMAR', '2014/01/01', '2016/12/31')}
#' \dontrun{get_OHLCap('ATLANTA', '2017/01/01', '2017/06/30')}
#'
#'
get_OHLCap <- function(stock_name, from, to) {

    request <- GET(URL, add_headers('User-Agent' = 'Mozilla'))

    view_state <- request %>%
        read_html() %>%
        html_node(xpath = VIEW_STATE_XPATH) %>%
        html_attr('value')

    stock_value <- stocks_metadata(request, with_values = TRUE) %>%
        .[stock_name]

    params <- list(
        '__VIEWSTATE' = view_state,
        'HistoriqueNegociation1$HistValeur1$historique' = 'RBSearchDate',
        'HistoriqueNegociation1$HistValeur1$DDValeur' = stock_value,
        'HistoriqueNegociation1$HistValeur1$DateTimeControl1$TBCalendar' = from,
        'HistoriqueNegociation1$HistValeur1$DateTimeControl2$TBCalendar' = to
    )

    response <- POST(URL, body = params, add_headers('User-Agent' = 'Mozilla'))

    tryCatch(
        {
            table <- response %>%
                read_html() %>%
                html_nodes(xpath = '//*[@id="arial11bleu"]') %>%
                .[[3]] %>%
                html_table() %>%
                .[, seq(2, 16, by = 2)]

            names(table) <- table[2, ]
            table %<>% tail(n = -3L)

            table %<>% sapply(function(x) str_replace_all(x, ',', '.')) %>%
                as.data.frame(stringsAsFactors = FALSE)

            table %<>% sapply(function(x) str_replace_all(x, '\u00C2', '')) %>%
                as.data.frame(stringsAsFactors = FALSE)  ## unicode for accentued A

            table %<>% sapply(function(x) str_replace_all(x, '[[:blank:]]', '')) %>%
                as.data.frame(stringsAsFactors = FALSE)

            table$`+Intraday high` %<>% str_replace_all('-', 'NAN')
            table$`+ Intraday low` %<>% str_replace_all('-', 'NAN')

            table$`Last price` <- NULL
            table$`Number of shares traded` <- NULL
            table$Security <- NULL

            table$Session %<>% as.Date('%d/%m/%Y')
            table$`Reference price` %<>% as.numeric()
            table$`+Intraday high` %<>% as.numeric()
            table$`+ Intraday low`%<>% as.numeric()
            table$Capitalisation %<>% as.numeric()

            table %<>% dplyr::rename_(Date = 'Session',
                                      Open = '`Reference price`',
                                      High = '`+Intraday high`',
                                      Low = '`+ Intraday low`')

            return(table %>%
                       dplyr::arrange_('Date'))
        },
        error = function(e) {
            #warning('Your query result is empty. Verify that you specified a valid symbol name or that the symbol was listed in CSE during the requested dates interval')
            return(data.frame())
        }
    )

}
