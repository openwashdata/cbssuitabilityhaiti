library(sf)
library(tmap)

# Done
# # download and unzip maps from https://data.humdata.org
# utils::download.file(url = "https://data.humdata.org/dataset/5deac5b5-f135-45e2-9994-bf555c38ed22/resource/0cb67376-e085-4862-b3c8-86f0dded3cd3/download/world_bank_flood_extents_caphaitien.zip",
#                      destfile = here::here("data-raw", "extents_cap_haitien.zip"),
#                      mode = "wb")
# unzip(here::here("data-raw", "extents_cap_haitien.zip"), exdir = here::here("data-raw", "extents_cap_haitien"))
#
# # remove zip file
# file.remove(here::here("data-raw", "extents_cap_haitien.zip"))


# yr_100 ------------------------------------------------------------------

# read in spatial data using all 4 different files (shx,shp,prj,dbf)
flood_extent_100 <- st_read(dsn = here::here("data-raw", "extents_cap_haitien", "."), layer = "100yr_Flood_Extent")

# # read in shp file only
# flood_extent_100_shp <-
#   st_read(here::here("data-raw", "extents_cap_haitien", "100yr_Flood_Extent.shp")) |>
#   st_as_sf()

# read waste skips locations into a simple feature (spatial vector data)
# set coordinate reference system equal to one from census_boundaries
sf_flood_extent_100 <- st_as_sf(flood_extent_100, coords = c('long', 'lat'))


# yr_25 -------------------------------------------------------------------

# read in spatial data using all 4 different files (shx,shp,prj,dbf)
flood_extent_25 <- st_read(dsn = here::here("data-raw", "extents_cap_haitien", "."), layer = "25yr_Flood_Extent")

# read waste skips locations into a simple feature (spatial vector data)
# set coordinate reference system equal to one from census_boundaries
sf_flood_extent_25 <- st_as_sf(flood_extent_25, coords = c('long', 'lat'))


# yr_5 --------------------------------------------------------------------

# read in spatial data using all 4 different files (shx,shp,prj,dbf)
flood_extent_5 <- st_read(dsn = here::here("data-raw", "extents_cap_haitien", "."), layer = "5yr_Flood_Extent")

# read waste skips locations into a simple feature (spatial vector data)
# set coordinate reference system equal to one from census_boundaries
sf_flood_extent_5 <- st_as_sf(flood_extent_5, coords = c('long', 'lat'))


# show maps ---------------------------------------------------------------

tmap_mode("view")
qtm(flood_extent_100)
qtm(flood_extent_25)
qtm(flood_extent_5)
