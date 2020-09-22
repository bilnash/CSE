#' Combine \code{get_CAQV} and \code{get_OHLCap}
#'
#' @param symbol a character vector
#' @param from a character vector
#' @param to a character vector
#'
#' @return a dataframe
#'
#' @importFrom dplyr inner_join
#' @importFrom dplyr select
#'
#'
get_OHLCAQVCap <- function(symbol, from, to) {

    data_CAQV <- get_CAQV(symbol, from, to)

    if (nrow(data_CAQV) == 0)
    {
        return(data.frame())
    }

    Sys.sleep(1)

    data_OHLCap <- get_OHLCap(symbol, from, to)

    dplyr::inner_join(data_CAQV, data_OHLCap, by = 'Date') %>%
        dplyr::select('Date', 'Open', 'High', 'Low', 'Close',
                       'Adjusted', 'Quantity', 'Volume', 'Capitalisation') %>%
        return()

}
