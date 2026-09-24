# Sanitation zoning assessment data

This data includes data from a sanitation zoning report done for the
city of Cap Haitien, Haiti in 2022. Additionally, it contains spatial
data about the neighborhoods of Cap Haitien and five other communes in
Haiti (Canaan, Croix-des-Bouquets, Jeremie, Les Cayes, Mirebalais).

## Usage

``` r
okap
```

## Format

A tibble with 198 rows and 13 variables:

- neighborho:

  Unique identifying number for each neighborhood unit

- name:

  Name of each nieghborhood unit

- sup_km2:

  Area of neighborhood in square km

- cte:

  Name of commune (administrative unit in Haiti)

- economy:

  Categorical socioeconomic status (low, medium)

- sup_bati_km2:

  area of neihborhood covered by buildings in square kilometers

- density:

  Categorical population density (least dense, somewhat dense, dense,
  very dense, most dense)

- aptitude:

  suitability of the site for a wastewater treatment system

- zoning:

  "group" if collective or grouped sanitation is possible in short term.

- latrine:

  Suggested pit latrine and septic allowance (allowed, not allowed)

- density_ra:

  Catgoriccal population density according to the description of the
  variable "density" (values from 1 to 5)

- economy_nu:

  Categotical socioeconomic status according to the description of the
  variable "economy" (1 = medium, 2 = low)

- geometry:

  Geospatial data of the neighborhood stored as a polygon

## Source

These data were developed under the USAID Water and Sanitation Project
in collaboration with the Cap-Haitian municipal government and DINEPA.
These data do not reflect the opinion of USAID or the US Government.
