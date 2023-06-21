# description -------------------------------------------------------------

# R script to process uploaded raw data into a tidy dataframe

# R packages --------------------------------------------------------------

library(tidyverse)
library(here)
library(sf)
library(tmap)
library(spData)
library(janitor)

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



# explore data ------------------------------------------------------------

mwater |>
  count(Datasets..)

okap |>
  glimpse()

tm_shape(mwater) +
  tm_dots(col = "Type")

okap |>
  filter(cte == "ctecaphaitien") |>
  tm_shape() +
  tm_borders() +
  tm_fill(col = "density")

okap |>
  sf::st_drop_geometry() |>
  as_tibble()

tm_shape(okap) +
  tm_borders()

okap

## code to prepare `DATASET` dataset goes here

usethis::use_data(mwater, okap, overwrite = TRUE)

fs::dir_create(here::here("inst", "extdata"))

# write_csv(DATASET, here::here("inst", "extdata", "DATASET.csv"))
#
# openxlsx::write.xlsx(DATASET, here::here("inst", "extdata", "DATASET.xlsx"))

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
dictionary |>
  write_csv("data-raw/dictionary.csv")

dictionary |>
  openxlsx::write.xlsx("data-raw/dictionary.xlsx")
