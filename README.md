
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
cosumar_data <- CSE::get_symbol(symbol = "COSUMAR", from = "2018-01-01", to = "2018-06-30", type = "stock")

masi_data <- CSE::get_symbol(symbol = "MASI", from = "2018-01-01", to = "2018-06-30", type = "index")

head(cosumar_data) 
#>              Open   High    Low Close Adjusted Quantity    Volume
#> 2018-01-02 295.00 199.31 191.98 288.0   191.98     2250  658171.1
#> 2018-01-03 298.90 199.25 193.98 297.8   198.51     4113 1213873.1
#> 2018-01-04 297.55 198.65 196.71 296.0   197.31     5375 1600775.2
#> 2018-01-05 295.95 199.31 195.31 299.0   199.31     3485 1040793.8
#> 2018-01-08 299.75 199.98 195.78 300.0   199.98    15413 4589872.5
#> 2018-01-09 294.20 199.98 196.11 299.0   199.31      351  104062.0
#>            Capitalisation
#> 2018-01-02    18141531552
#> 2018-01-03    18758847556
#> 2018-01-04    18645462984
#> 2018-01-05    18834437271
#> 2018-01-08    18897428700
#> 2018-01-09    18834437271

head(masi_data)
#>               Value
#> 2018-01-02 12420.15
#> 2018-01-03 12509.58
#> 2018-01-04 12463.08
#> 2018-01-05 12537.75
#> 2018-01-08 12479.42
#> 2018-01-09 12504.46
```
