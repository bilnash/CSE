#' Load and Manage Historical Data from Casablanca Stock Exchange
#'
#' Function to load and manage historical data of a Symbol listed in Casablanca Stock Exchange.
#' Current available symbol types are "stock" and "index".
#' For stocks, the returned object includes: Date, Open, High, Low, Close, Adjusted, Quantity, Volume, and Capitalisation.
#' For indexes, the returned object includes: Date and Value columns.
#'
#' @param symbol a character vector specifying the name of the symbol to be loaded. Use \code{listed_symbols} function to get all available symbol names.
#' @param from a character vector specifying the start date. Should be formatted according to ISO8601 (\code{"yyyy-mm-dd"})
#' @param to a character vector specifying the end date. Should be formatted according to ISO8601 (\code{"yyyy-mm-dd"})
#' @param type a character vector specifying the symbol type. Current supported types are "stock" and "index"
#' @param format.as.xts a boolean value. Set to \code{FALSE} in order to return a dataframe instead of an xts object
#'
#' @return an xts object or a dataframe
#'
#' @importFrom xts as.xts
#'
#' @export
#'
#' @examples
#' \dontrun{get_symbol('COSUMAR', '2017-01-01', '2017-12-31')}
#' \dontrun{get_symbol('COSUMAR', '2017-01-01', '2017-06-30', format.as.xts = TRUE)}
#' \dontrun{get_symbol('MASI', '2017-01-01', '2017-12-31', type = 'index')}
#'
#'
get_symbol <- function(symbol, from, to, type, format.as.xts = TRUE) {

    check_dates(from, to)

    if (type == 'stock')
    {
        data_ <- fetch_data(get_OHLCAQVCap, symbol, from, to)
    }
    else if (type == 'index')
    {
        data_ <- fetch_data(get_IV, symbol, from, to)
    }
    else
    {
        stop('Symbol type should be "stock" or "index"')
    }

    if (format.as.xts & nrow(data_) > 0)
    {
        index <- data_$Date
        data_$Date <- NULL
        data_ <- as.xts(data_, order.by = index)
    }

    Sys.sleep(1)
    return(data_)

}


