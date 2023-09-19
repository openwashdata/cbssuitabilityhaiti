#' Location of different water points in Cap Haitien, Haiti
#'
#' This data includes water point data from the mWater platform. Water points
#' are for the city Cap Haitien, Haiti in 2022. The data collection and
#' characterization was done between 2016 and 2022.
#'
#' @format A tibble with 1849 rows and 7 variables:
#' \describe{
#'   \item{latitude}{Lattitude coordinate}
#'   \item{longitude}{Longitude coordinate}
#'   \item{administra}{Communal section- smallest administrative unit in Haiti}
#'   \item{type}{Type of water access point}
#'   \item{date_added}{Date water access point was added to mWater}
#'   \item{datasets}{Dataset in mWater that point is part of, including organizaiton that is responsible for data}
#'   \item{geometry}{Geospatial data of the different access points that were added to mWater}
#'   }
#'
"mwater"
