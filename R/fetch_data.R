#' Helper Function
#'
#' @param fetch_method a function to load data
#' @param symbol a character vector
#' @param from character vector specifying the start date (ISO8601 format)
#' @param to character vector specifying the end date (ISO8601 format)
#'
#' @return dataframe
#'
#' @importFrom lubridate as_date
#' @importFrom lubridate %m+%
#' @importFrom lubridate days
#'
#'
fetch_data <- function(fetch_method, symbol, from, to) {

    from_ <- lubridate::as_date(from)
    to_ <- lubridate::as_date(to)

    current_ <- from_

    data_ <- data.frame()

    while (current_ %m+% days(365 * 3) < to_)
    {
        # Get data from (current) ==> (current + 3 years)
        data_ <- rbind(data_,
                       fetch_method(symbol,
                                    as.character(current_),
                                    as.character(current_ %m+% days(365 * 3))))
        # update current += 3 years + 1 day
        current_ <- current_ %m+% days((365 * 3) + 1)
    }

    # get the remainder (current_) ==> to_
    data_ <- rbind(data_,
                   fetch_method(symbol,
                                as.character(current_),
                                as.character(to_)))

    return(data_)
}
