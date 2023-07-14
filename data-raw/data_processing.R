# description -------------------------------------------------------------

# R script to process uploaded raw data into a tidy dataframe

# R packages --------------------------------------------------------------

library(tidyverse)
library(lubridate)
library(here)
library(sf)
library(tmap)
library(spData)
library(janitor)
library(devtools)

# read data ---------------------------------------------------------------

mwater <- st_read("data-raw/mWater water points/waterpoints_clip.shp") |>
  st_as_sf()

okap <- st_read("data-raw/Okap_Zonaj_Asenisman_USAID/Okap_Zonaj_Asenisman_USAID.shp") |>
  st_as_sf()

# wb <- st_read("data-raw/world_bank_flood_extents_caphaitien/100yr_Flood_Extent.shp") |>
#   st_as_sf()

# tidy data ---------------------------------------------------------------

okap |>
  glimpse()

okap |>
  janitor::tabyl(economy)

okap |>
  tabyl(ranking)

# translate content to English
okap_fr <- okap
okap <- okap |>
  mutate(density = c("least dense", "somewhat dense",
                     "dense", "very dense",
                     "most dense")[density_ra],
         economy = c("medium", "low")[economy_nu],
         aptitude = c("good", "medium", "bad")[match(aptitude, c("bonne", "moyenne", "mauvaise"))],
         zoning = str_replace_all(zoning, "regroupe", "group"),
         latrine = c("allowed", "not allowed")[match(latrine, c("fond perdu", "pas fond perdu"))]) |>
  mutate(density = fct_reorder(density, density_ra, .na_rm = FALSE)) |>
  rename("sup_bati_km2" = sup_bati)
  select(-sector_id)

mwater <- mwater |>
  mutate(Date.added = mdy_hm(Date.added)) |>
  rename("latitude" = Latitude.o,
         "longitude" = Longitude,
         "administra"= Administra,
         "type" = Type,
         "date_added" = Date.added,
         "datasets" = Datasets..)

# explore data ------------------------------------------------------------

# explore mwater

mwater |>
  count(Datasets..)
mwater |>
  qtm()
tm_shape(mwater) +
  tm_dots(col = "Type")
mwater |>
  tabyl(Administra)

# explore okap

okap |>
  glimpse()
okap |>
  qtm()
tm_shape(okap) +
  tm_borders()
# convert sf into tibble
okap |>
  sf::st_drop_geometry() |>
  as_tibble()
okap


## code to prepare `DATASET` dataset goes here

usethis::use_data(mwater, okap, overwrite = TRUE)

# fs::dir_create(here::here("inst", "extdata"))

write_csv(mwater, here::here("inst", "extdata", "mwater.csv"))
write_csv(okap, here::here("inst", "extdata", "okap.csv"))

openxlsx::write.xlsx(sf::st_drop_geometry(mwater), here::here("inst", "extdata", "mwater.xlsx"))
openxlsx::write.xlsx(sf::st_drop_geometry(okap), here::here("inst", "extdata", "okap.xlsx"))

# prepare dictionaries ----------------------------------------------------

library(tibble)

get_variable_info <- function(data, directory = "", file_name = "") {
  total_variables <- sum(sapply(data, function(df) length(names(df))))

  variable_info <- tibble(
    directory = character(total_variables),
    file_name = character(total_variables),
    variable_name = character(total_variables),
    variable_type = character(total_variables),
    description = character(total_variables)
  )

  index <- 1

  for (i in seq_along(data)) {
    dataframe <- data[[i]]
    variable_names <- names(dataframe)
    variable_types <- sapply(dataframe, typeof)

    num_variables <- length(variable_names)
    variable_info$variable_name[index:(index + num_variables - 1)] <- variable_names
    variable_info$variable_type[index:(index + num_variables - 1)] <- variable_types
    variable_info$file_name[index:(index + num_variables - 1)] <- rep(file_name[i], num_variables)
    variable_info$directory[index:(index + num_variables - 1)] <- rep(directory[i], num_variables)

    index <- index + num_variables
  }

  return(variable_info)
}


# Specify values for directory and file_name
directories <- c("data/", "data/")
file_names <- c("okap.rda", "mwater.rda")

dictionary <- get_variable_info(data = list(okap, mwater),
                                directory = directories,
                                file_name = file_names)

# dictionary |>
#   write_csv("data-raw/dictionary.csv")

# dictionary |>
#   openxlsx::write.xlsx("data-raw/dictionary.xlsx")
