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

# get 3rd level administrative areas in Haiti
# # download and unzip maps from stanford data base
# download.file(url = "https://stacks.stanford.edu/file/druid:kz179wf4778/data.zip?download=true",
#               destfile = "data-raw/3rd-level-haiti-divisions.zip",
#               mode = "wb")
# unzip("data-raw/3rd-level-haiti-divisions.zip", exdir = "data-raw/haiti-adm3")
# # remove zip file
# file.remove("data-raw/3rd-level-haiti-divisions.zip")

# read in 3rd administrative lvl spatial files
haiti_adm3 <- st_read("data-raw/haiti-adm3/HTI_adm3.shp") |>
  st_as_sf()

# tidy data ---------------------------------------------------------------

okap |>
  glimpse()

okap |>
  janitor::tabyl(economy)

okap |>
  tabyl(ranking)

# translate content to English
okap_eng <- okap |>
  mutate(density = c("least dense", "somewhat dense",
                     "dense", "very dense",
                     "most dense")[density_ra],
         economy = c("medium", "low")[economy_nu],
         aptitude = c("good", "medium", "bad")[match(aptitude, c("bonne", "moyenne", "mauvaise"))],
         zoning = str_replace_all(zoning, "regroupe", "group"),
         latrine = c("allowed", "not allowed")[match(latrine, c("fond perdu", "pas fond perdu"))]) |>
  mutate(density = fct_reorder(density, density_ra))


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

# explore Haiti adm3 area data
haiti_adm3 |> qtm() +
  tmap_options(check.and.fix = TRUE)
glimpse(haiti_adm3)


### explore Cap-Haitien data

# find Cap-Haitien data
mwater |>
  tabyl(Administra)
okap |>
  tabyl(cte)

# filter Cap-Haitien adm3 map data
cap_adm3 <- haiti_adm3 |>
  filter(ID_3 == 79) # select Cap-Haitien
cap_adm3 <- haiti_adm3 |>
  filter(ID_3 == 77|ID_3 == 78 | ID_3 == 79 | ID_3 == 81) # select North

# filter Cap-Haitien mwater data
cap_mwater <- mwater |>
  filter(str_detect(Administra, "Cap Haitien"))

# filter Cap-Haitien okap data
cap_okap <- okap_eng |>
  filter(cte == "ctecaphaitien")

# basic example plot
# neighborhoods of Cap-Haitien according to their density
# different types of sanitation systems in area arround Cap-Haitien
cap_map <- cap_adm3 |>
  tm_shape() +
  tm_borders(lwd = 2) +
  tm_layout(bg.color = "lightblue") +
  tm_borders() +
  tm_shape(cap_okap) +
  tm_borders() +
  tm_fill(col = "density", palette = "YlOrBr") +
  tm_shape(cap_mwater) +
  tm_dots(col = "Type", palette = "Blues")

cap_map



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
