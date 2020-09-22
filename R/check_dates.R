#' Check Dates
#'
#' This helper function checks if two dates (from and to) are valid or not.
#' Dates are valid if:
#'
#'     Are formatted as YYYY/MM/DD
#'     From Date <= To Date
#'
#' @param from String specifying the start date. Format: YYYY MM DD (any separator)
#' @param to String specifying the end date. Format: YYYY MM DD (any separator)
#'
#' @return Side effect (raise error) if invalid dates
#'
#' @importFrom lubridate as_date
#' @importFrom lubridate %m+%
#' @importFrom lubridate %m-%
#' @importFrom lubridate days
#' @importFrom lubridate years
#'

check_dates <- function(from, to) {

    from_ = lubridate::as_date(from)
    to_ = lubridate::as_date(to)

    if (is.na(from_) | is.na(to_)) {
        stop('Dates should be formatted as YYYY-MM-DD (eg. 2018-01-20)')
    }

    if (to_ < from_) {
        stop('End date (argument "to") should be >= Start date (argument "from")')
    }

    return(TRUE)

}
