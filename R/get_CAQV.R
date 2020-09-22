#' Get Close Price, Adjusted Price, Quantity & Volume
#'
#' Given a valid stock name listed in CSE, this function returns the corresponding financial
#' data including the ADJUSTED PRICES for the specified period (\code{from} until \code{to}).
#' The returned dataframe includes Date, Close, Adjusted, Quantity and Volume.
#'
#' @param stock_name a character vector of length one. Use \code{listed_symbols(type = 'stock')}
#' to list all valid stocks names listed in CSE.
#' @param from a character vector of length one matching the format 'yyyy-mm-dd'
#' @param to a character vector of length one matching the format 'yyyy-mm-dd'
#'
#' @return a dataframe.
#'
#' @note The difference between \code{to} and \code{from} dates should be less than or
#' equal 3 years.
#'
#' @importFrom httr GET
#' @importFrom httr POST
#' @importFrom xml2 read_html
#' @importFrom rvest html_node
#' @importFrom rvest html_attr
#' @importFrom rvest html_table
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#' @importFrom stringr str_replace_all
#' @importFrom utils tail
#' @importFrom dplyr arrange
#' @importFrom dplyr rename
#'
#' @examples
#' \dontrun{get_CAQV('COSUMAR', '2014/01/01', '2016/12/31')}
#' \dontrun{get_CAQV('ATLANTA', '2017/01/01', '2017/06/30')}
#'
get_CAQV <- function(stock_name, from, to) {

    request <- GET(URL, add_headers('User-Agent' = 'Mozilla'))

    view_state <- request %>%
        read_html() %>%
        html_node(xpath = VIEW_STATE_XPATH) %>%
        html_attr('value')

    stock_value <- stocks_metadata(request, with_values = TRUE) %>%
        .[stock_name]

    params <- list(
        '__VIEWSTATE' = view_state,
        '__EVENTTARGET' = 'HistoriqueNegociation1$HistValeur1$LinkButton1',
        'HistoriqueNegociation1$HistValeur1$historique' = 'RBSearchDate',
        'HistoriqueNegociation1$HistValeur1$DDValeur' = stock_value,
        'HistoriqueNegociation1$HistValeur1$DateTimeControl1$TBCalendar' = from,
        'HistoriqueNegociation1$HistValeur1$DateTimeControl2$TBCalendar' = to
    )

    response <- POST(URL, body = params, add_headers('User-Agent' = 'Mozilla'))

    tryCatch(
        {
            data_table <- response %>%
                read_html() %>%
                html_table() %>%
                .[[1]]

            names(data_table) <- data_table[1, ]

            data_table %<>% tail(n = -1L)

            f <- function(x) {
                str_replace_all(x, ',', '.')
            }

            data_table %<>% sapply(f) %>% as.data.frame(stringsAsFactors = FALSE)

            colnames(data_table)[1] <- 'Date'

            data_table$Date %<>% as.Date('%d/%m/%Y')
            data_table$COURS_CLOTURE %<>% as.numeric()
            data_table$COURS_AJUSTE %<>% as.numeric()
            data_table$EVOLUTION <- NULL
            data_table$QUANTITE_ECHANGE %<>% as.integer()
            data_table$VOLUME %<>% as.numeric()

            data_table %<>% dplyr::rename(Close = 'COURS_CLOTURE',
                                          Adjusted = 'COURS_AJUSTE',
                                          Quantity = 'QUANTITE_ECHANGE',
                                          Volume = 'VOLUME')

            return(data_table %>%
                       dplyr::arrange('Date'))
        },
        error = function(e) {
            #warning('Your query result is empty. Verify that you specified a valid symbol name or that the symbol was listed in CSE during the requested dates interval')
            return(data.frame())
        }
    )

}
