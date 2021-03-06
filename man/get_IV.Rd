% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_IV.R
\name{get_IV}
\alias{get_IV}
\title{Get Historical Values of an INDEX}
\usage{
get_IV(index_code, from, to)
}
\arguments{
\item{index_code}{a character vector of length one. Use \code{listed_symbols(type = "index")}
to list all valid indexes in CSE.}

\item{from}{a character vector of length one matching the format 'yyyy-mm-dd'}

\item{to}{a character vector of length one matching the format 'yyyy-mm-dd'}
}
\value{
a dataframe
}
\description{
Given a valid index code, this function returns the corresponding historical data
for the specified period (\code{from} until \code{to}). The returned dataframe
includes Date and Value columns.
}
\note{
The difference between \code{to} and \code{from} should be less than or
equal 3 years.
}
\examples{
\dontrun{get_IV('MASI', '2014/01/01', '2016/12/31')}
\dontrun{get_IV('MADEX', '2017/01/01', '2017/06/30')}


}
