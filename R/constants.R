#' To Avoid the Note About magrittr Package While R CMD Check
#'
#'
globalVariables('.')


#' URL For Stocks Data
#'
#'
URL <- 'https://www.casablanca-bourse.com/bourseweb/en/Negociation-History.aspx?Cat=24&IdLink=225'


#' VIEW_STATE XPath
#'
#'
VIEW_STATE_XPATH <- '//*[@id="__VIEWSTATE"]'


#' Where To Get The List Of All Listed Stocks
#'
#'
LISTED_SEC_XPATH <- '//*[@id="HistoriqueNegociation1_HistValeur1_DDValeur"]/option'


#' URL For Indexes Data
#'
#'
URL_INDEXES <- 'https://www.casablanca-bourse.com/bourseweb/en/index-history.aspx?Cat=22&IdLink=215'


#' Where To Get The List Of All Available Indexes
#'
#'
INDEXES_XPATH <- '//*[@id="IndiceHistorique1_DDLIndice"]/option'


#' Base URL to Get a Stock Key Indicators
#' Should be Appended with the Stock Code Value
#'
#'
KEY_INDICATORS_BASE_URL <- 'https://www.casablanca-bourse.com/bourseweb/en/Company.aspx?codeValeur='


#' IPO Date XPATH
#'
#'
IPO_DATE_XPATH <- '//*[@id="SocieteCotee1_FicheTechnique1_LBIntroduction"]'






