## ----setup, include = FALSE---------------------------------------------------
library(magrittr)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- warning=FALSE-----------------------------------------------------------
all_stocks <- CSE::listed_symbols(type = "stock")
all_stocks %>% length()

## ---- warning=FALSE, eval=FALSE-----------------------------------------------
#  dplyr::tibble(Firm = all_stocks) %>%
#      head(n = 10)

## ---- warning=FALSE, echo=FALSE-----------------------------------------------
dplyr::tibble(Firm = all_stocks) %>%
    head(n = 10) %>%
    knitr::kable()

## ---- warning=FALSE-----------------------------------------------------------
all_indexes <- CSE::listed_symbols(type = "index")
all_indexes %>% nrow()

## ---- warning=FALSE, eval=FALSE-----------------------------------------------
#  all_indexes %>%
#      head(n = 10)

## ---- warning=FALSE, echo=FALSE-----------------------------------------------
all_indexes %>%
    head(n = 10) %>%
    knitr::kable()

## ---- warning=FALSE-----------------------------------------------------------
firm_sample <- all_stocks %>% 
    sample(size = 5)

ipo_dates <- firm_sample %>%
    purrr::map(CSE::ipo_date)

## ---- warning=FALSE, eval=FALSE-----------------------------------------------
#  dplyr::tibble(Firm = firm_sample, IPO_Date = do.call(c, ipo_dates))

## ---- warning=FALSE, echo=FALSE-----------------------------------------------
dplyr::tibble(Firm = firm_sample, IPO_Date = do.call(c, ipo_dates)) %>%
    knitr::kable()

## ---- warning=FALSE-----------------------------------------------------------
iam <- CSE::get_symbol("ITISSALAT AL-MAGHRIB", "2016-01-01", "2018-07-16", type = "stock")
masi <- CSE::get_symbol("MASI", "2016-01-01", "2018-07-16", type = "index")

## ---- warning=FALSE-----------------------------------------------------------
dim(iam)

## ---- warning=FALSE-----------------------------------------------------------
dim(masi)

## ---- warning=FALSE-----------------------------------------------------------
xts::first(iam, n = 5)

## ---- warning=FALSE-----------------------------------------------------------
xts::last(iam, n = 5)

## ---- warning=FALSE-----------------------------------------------------------
xts::first(masi, n = 5)

## ---- warning=FALSE-----------------------------------------------------------
xts::last(masi, n = 5)

## ---- fig.width=7.5, fig.height=5, warning=FALSE------------------------------
plot(masi, main = "MASI Historical Values")
plot(iam$Adjusted, main = "IAM Historical Adjusted Prices")

