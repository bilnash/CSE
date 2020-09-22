#' Get all Available Symbols in Casablanca Stock Exchange
#'
#' This function returns a list of all stocks and indexes currently available in CSE.
#' The argument \code{type} controls the symbol type: stock, index or all (for both).
#'
#' @param type one of "stock", "index" or "all"
#'
#' @return if \code{type == "all"}: list with two columns (INDEXES, STOCKS)
#' @return if \code{type == "index"}: dataframe (index code and description)
#' @return if \code{type == "stock"}: character vector
#'
#' @importFrom stringr str_to_lower
#'
#' @export
#'
#' @examples
#' \dontrun{listed_symbols()}
#' \dontrun{listed_symbols()$INDEXES}
#' \dontrun{listed_symbols()$STOCKS}
#' \dontrun{listed_symbols(type = 'stock')}
#' \dontrun{listed_symbols(type = 'index')}
#'
listed_symbols <- function(type = 'all') {

    type <- stringr::str_to_lower(type)

    if (type == 'all')
    {
        return(list(INDEXES = indexes_metadata(),
                    STOCKS = stocks_metadata(with_values = FALSE)))
    }
    else if (type == 'stock')
    {
        return(stocks_metadata(with_values = FALSE))
    }
    else if (type == 'index')
    {
        return(indexes_metadata())
    }
    else
    {
        stop('Invalid Symbol Type! Should be "stock", "index" or "all".')
    }

}
