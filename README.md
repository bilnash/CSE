
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Build
Status](https://travis-ci.com/bilnash/CSE.svg?branch=master)](https://travis-ci.com/bilnash/CSE)

# CSE

The goal of CSE (Casablanca Stock Exchange) is to simplify financial
programming workflow with Casablanca stock exchange data.

Currently, it implements 3 mains functions:

  - `listed_symbols`: Returns all listed symbols (stocks, indexes, or
    both) in Casablanca stock exchange.

  - `get_symbol`: Returns a symbol historical data corresponding to a
    specific date range.

  - `ipo_date`: Returns a symbol IPO (Initial Public Offering) date.

## Installation

You can install CSE from github with:

``` r
# install.packages("devtools")
devtools::install_github("bilnash/CSE", build_vignettes = TRUE)
```

## Documentation

A detailled documentation can be found in the package vignette.

``` r
vignette("cse_vignette", package = "CSE")
```

## Example

This is a basic example which shows you how to use CSE:

``` r
listed_stocks <- CSE::listed_symbols(type = "stock")
available_indexes <- CSE::listed_symbols(type = "index")

head(listed_stocks)
#> [1] "2L ADH J01JAN2020"   "DOUJA PROM ADDOHA"   "ALLIANCES"          
#> [4] "AFRIC INDUSTRIES SA" "AFMA"                "AGMA"

head(available_indexes)
#>   INDEX_CODE                       DESCRIPTION
#> 1       AGRO       Food producers & Processors
#> 2      ASSUR                         Insurance
#> 3       BANK                             Banks
#> 4       B&MC Construction & Building Materials
#> 5      BOISS                         Beverages
#> 6       ESGI                 Casablanca ESG 10
```

``` r
cosumar_data <- CSE::get_symbol(symbol = "COSUMAR", from = "2015-01-01", to = "2020-09-22", type = "stock")

masi_data <- CSE::get_symbol(symbol = "MASI", from = "2015-01-01", to = "2020-09-22", type = "index")

head(cosumar_data) 
#>              Open   High       Low   Close Adjusted Quantity     Volume
#> 2015-01-02    0.0    NaN  66660.20 1600.00   106.66        0        0.0
#> 2015-01-06 1532.0 111.26    102.12 1669.00   111.26       36    56522.0
#> 2015-01-07    0.0    NaN 666601.99  166.90   111.26        0        0.0
#> 2015-01-08  161.1 108.12    107.39  162.20   108.12   202627 32696568.7
#> 2015-01-09  168.5 112.32    112.32  168.50   112.32     1365   230002.5
#> 2015-01-12  168.5 112.32    111.42  167.15   111.42      302    50770.8
#>            Capitalisation
#> 2015-01-02     6705691200
#> 2015-01-06     6994874133
#> 2015-01-07     6994874133
#> 2015-01-08     6797894454
#> 2015-01-09     7061931045
#> 2015-01-12     7005351776

tail(masi_data)
#>               Value
#> 2020-09-15 10128.78
#> 2020-09-16 10101.06
#> 2020-09-17 10064.32
#> 2020-09-18 10084.21
#> 2020-09-21 10122.59
#> 2020-09-22 10119.53
```
