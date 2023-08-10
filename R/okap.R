#' Sanitation zoning assessment data
#'
#' This data includes data from a sanitation zoning report done for the city
#' of Cap Haitien, Haiti in 2022. Additionally, it contains spatial data about
#' the neighborhoods of 5 different Haitien cities.
#'
#' @format A tibble with 198 rows and 21 variables:
#' \describe{
#'   \item{neighborho}{Unique identifying number for each neighborhood unit}
#'   \item{name}{Name of each nieghborhood unit}
#'   \item{sup_km2}{Area of neighborhood in square km}
#'   \item{cte}{Name of commune (administrative unit in Haiti)}
#'   \item{economy}{Categorical socioeconomic status (low, medium)}
#'   \item{sup_bati_km2}{area of neihborhood covered by buildings in square kilometers}
#'   \item{density}{Categorical population density (least dense, somewhat dense, dense, very dense, most dense)}
#'   \item{aptitude}{suitability of the site for a wastewater treatment system}
#'   \item{zoning}{"group" if collective or grouped sanitation is possible in short term.}
#'   \item{latrine}{Suggested pit latrine and septic allowance (allowed, not allowed)}
#'   \item{density_ra}{Catgoriccal population density according to the description of the variable "density" (values from 1 to 5)}
#'   \item{economy_nu}{Categotical socioeconomic status according to the description of the variable "economy" (1=low, 2 = medium)}
#'   \item{geometry}{Geospatial data of the neighborhood stored as a polygon}
#' }
#' @source {These data were developed under the USAID Water and Sanitation Project in collaboration with the Cap-Haitian municipal government and DINEPA. These data do not reflect the opinion of USAID or the US Government.}
"okap"
