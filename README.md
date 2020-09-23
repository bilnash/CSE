
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

Please refer to the package vignette:

``` r
vignette("cse_vignette", package = "CSE")
```

Also available at:
<https://bilnash.github.io/CSE/vignettes/cse_vignette.html>

## Basic Example

This is a basic example which shows you how to use CSE:

``` r
listed_stocks <- CSE::listed_symbols(type = "stock")

available_indexes <- CSE::listed_symbols(type = "index")
```

``` r
sample(listed_stocks, size = 6L) %>%
    dplyr::tibble(Stock = .) %>%
    knitr::kable()
```

| Stock            |
| :--------------- |
| BMCI             |
| WAFA ASSURANCE   |
| REBAB COMPANY    |
| IB MAROC.COM     |
| CIMENTS DU MAROC |
| ENNAKL           |

``` r
head(available_indexes) %>%
    knitr::kable()
```

| INDEX\_CODE | DESCRIPTION                       |
| :---------- | :-------------------------------- |
| AGRO        | Food producers & Processors       |
| ASSUR       | Insurance                         |
| BANK        | Banks                             |
| B\&MC       | Construction & Building Materials |
| BOISS       | Beverages                         |
| ESGI        | Casablanca ESG 10                 |

``` r
cosumar_data <- CSE::get_symbol(symbol = "COSUMAR", from = "2015-01-01", to = "2020-09-22", type = "stock", format.as.xts = FALSE)

masi_data <- CSE::get_symbol(symbol = "MASI", from = "2015-01-01", to = "2020-09-22", type = "index", format.as.xts = FALSE)
```

``` r
head(cosumar_data) %>%
    knitr::kable()
```

| Date       |   Open |   High |       Low |   Close | Adjusted | Quantity |     Volume | Capitalisation |
| :--------- | -----: | -----: | --------: | ------: | -------: | -------: | ---------: | -------------: |
| 2015-01-02 |    0.0 |    NaN |  66660.20 | 1600.00 |   106.66 |        0 |        0.0 |     6705691200 |
| 2015-01-06 | 1532.0 | 111.26 |    102.12 | 1669.00 |   111.26 |       36 |    56522.0 |     6994874133 |
| 2015-01-07 |    0.0 |    NaN | 666601.99 |  166.90 |   111.26 |        0 |        0.0 |     6994874133 |
| 2015-01-08 |  161.1 | 108.12 |    107.39 |  162.20 |   108.12 |   202627 | 32696568.7 |     6797894454 |
| 2015-01-09 |  168.5 | 112.32 |    112.32 |  168.50 |   112.32 |     1365 |   230002.5 |     7061931045 |
| 2015-01-12 |  168.5 | 112.32 |    111.42 |  167.15 |   111.42 |      302 |    50770.8 |     7005351776 |

``` r
tail(masi_data) %>%
    knitr::kable()
```

| Date       |    Value |
| :--------- | -------: |
| 2020-09-15 | 10128.78 |
| 2020-09-16 | 10101.06 |
| 2020-09-17 | 10064.32 |
| 2020-09-18 | 10084.21 |
| 2020-09-21 | 10122.59 |
| 2020-09-22 | 10119.53 |
