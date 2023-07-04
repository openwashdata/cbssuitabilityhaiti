#' Categorized data for neighborhoods in Haiti
#'
#' Description
#' Description
#' Description
#'
#' @format A tibble with 198 rows and 21 variables:
#' \describe{
#'   \item{neighborho}{Unique identifying number for each neighborhood unit}
#'   \item{name}{Name of each nieghborhood unit}
#'   \item{sup_km2}{Area of neighborhood in square km}
#'   \item{sector_id}{NULL}
#'   \item{cte}{Name of commune (administrative unit in Haiti)}
#'   \item{qlty_water}{Unknown}
#'   \item{qty_water}{Unknown}
#'   \item{health_car}{Unknown}
#'   \item{schooling}{Unknown}
#'   \item{transport}{Unknown}
#'   \item{economy}{Categorical socioeconomic status (low, medium)}
#'   \item{ranking}{Unknown}
#'   \item{sup_bati}{area of neihborhood covered by buildings in square meters}
#'   \item{density}{Categorical population density (least dense, somewhat dense, dense, very dense, most dense)}
#'   \item{aptitude}{suitability of the site for a wastewater treatment system}
#'   \item{zoning}{"group" if collective or grouped sanitation is possible in short term.}
#'   \item{latrine}{Suggested pit latrine and septic allowance (allowed, not allowed)}
#'   \item{standing}{Unknown}
#'   \item{density_ra}{Catgoriccal population density according to the description of the variable "density" (values from 1 to 5)}
#'   \item{economy_nu}{Categotical socioeconomic status according to the description of the variable "economy" (1=low, 2 = medium)}
#'   \item{geometry}{Geospatial data of the neighborhood stored as a polygon}
#' }
#'
"okap"
