## ----setup, include = FALSE---------------------------------------------------
library(magrittr)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- warning=FALSE-----------------------------------------------------------
all_stocks <- CSE::listed_symbols(type = "stock")
all_stocks %>% length()

## ---- warning=FALSE-----------------------------------------------------------
dplyr::data_frame(Firm = all_stocks) %>%
    head(n = 10) %>%
    knitr::kable()

## ---- warning=FALSE-----------------------------------------------------------
all_indexes <- CSE::listed_symbols(type = "index")
all_indexes %>% nrow()

## ---- warning=FALSE-----------------------------------------------------------
all_indexes %>%
    head(n = 10) %>%
    knitr::kable()

## ---- warning=FALSE-----------------------------------------------------------
firm_sample <- all_stocks %>% 
    sample(size = 5)

ipo_dates <- firm_sample %>%
    purrr::map(CSE::ipo_date)

dplyr::data_frame(Firm = firm_sample, IPO_Date = do.call(c, ipo_dates)) %>%
    knitr::kable()

## ---- warning=FALSE-----------------------------------------------------------
iam <- CSE::get_symbol("ITISSALAT AL-MAGHRIB", "2016-01-01", "2018-07-16", type = "stock")
masi <- CSE::get_symbol("MASI", "2016-01-01", "2018-07-16", type = "index")

## ---- warning=FALSE-----------------------------------------------------------
dim(iam)

dim(masi)

xts::first(iam, n = 5)

xts::last(iam, n = 5)

xts::first(masi, n = 5)

xts::last(masi, n = 5)

## ---- fig.width=7.5, fig.height=5, warning=FALSE------------------------------
plot(masi, main = "MASI Historical Values")
plot(iam$Adjusted, main = "IAM Historical Adjusted Prices")

