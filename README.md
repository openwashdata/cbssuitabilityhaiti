
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cbssuitabilityhaiti

<!-- badges: start -->

DOI R-CMD-Check <!-- badges: end -->

# Overview

This packages combines data collected as part of ?????? conducted in
Haiti. The projects were supported by SOIL at ??????.

## Installation

You can install the development version of cbssuitabilityhaiti from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("openwashdata/cbssuitabilityhaiti")
```

Alternatively, you can download the individual datasets as a CSV or XLSX
file from the table below.

| dataset | CSV                                                                                                  | XLSX                                                                                                   |
|:--------|:-----------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------|
| okap    | [Download CSV](https://github.com/openwashdata/cbssuitabilityhaiti/raw/main/inst/extdata/okap.csv)   | [Download XLSX](https://github.com/openwashdata/cbssuitabilityhaiti/raw/main/inst/extdata/okap.xlsx)   |
| mwater  | [Download CSV](https://github.com/openwashdata/cbssuitabilityhaiti/raw/main/inst/extdata/mwater.csv) | [Download XLSX](https://github.com/openwashdata/cbssuitabilityhaiti/raw/main/inst/extdata/mwater.xlsx) |

# Projects

## mWater

(One sentence) Evaluating the potential of ……..

### Description

(One to two short paragraphs) This Project focuses on determining …….

### Research Question

(One to two questions)

### Data

Description of the Data. When/Where it was collected. For how long.

The package provides access one data set.

``` r
library(cbssuitabilityhaiti)
```

``` epoxy
The `mwater` data set has {ncol(mwater)} variables and {nrow(mwater)} observations. For an overview of the variable names, see the following table.  
```

``` r
mwater
```

| variable_name | variable_type | description                                                                                  |
|:--------------|:--------------|:---------------------------------------------------------------------------------------------|
| Latitude.o    | double        | Lattitude coordinate                                                                         |
| Longitude     | double        | Longitude coordinate                                                                         |
| Administra    | character     | Communal section- smallest administrative unit in Haiti                                      |
| Type          | character     | Type of water access point                                                                   |
| Date.added    | character     | Date water access point was added to mWater                                                  |
| Datasets..    | character     | Dataset in mWater that point is part of, including organizaiton that is responsible for data |
| geometry      | list          | Geospatial data of the different access points that were added to mWater                     |

A small visualisation of this data set

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

## Okap

(One sentence) Evaluating the potential of ……..

### Description

(One to two short paragraphs) This Project focuses on determining …….

### Research Question

(One to two questions)

### Data

Description of the Data. When/Where it was collected. For how long.

The package provides access one data set.

``` r
library(cbssuitabilityhaiti)
```

``` epoxy
The `okap` data set has {ncol(okap)} variables and {nrow(okap)} observations. For an overview of the variable names, see the following table.  
```

``` r
okap
```

| variable_name | variable_type | description                                                                                                 |
|:--------------|:--------------|:------------------------------------------------------------------------------------------------------------|
| neighborho    | double        | Unique identifying number for each neighborhood unit                                                        |
| name          | character     | Name of each nieghborhood unit                                                                              |
| sup_km2       | double        | Area of neighborhood in square km                                                                           |
| sector_id     | double        | NULL                                                                                                        |
| cte           | character     | Name of commune (administrative unit in Haiti)                                                              |
| qlty_water    | double        | Unknown                                                                                                     |
| qty_water     | double        | Unknown                                                                                                     |
| health_car    | double        | Unknown                                                                                                     |
| schooling     | double        | Unknown                                                                                                     |
| transport     | double        | Unknown                                                                                                     |
| economy       | character     | Categorical socioeconomic status (low, medium)                                                              |
| ranking       | double        | Unknown                                                                                                     |
| sup_bati      | double        | area of neihborhood covered by buildings in square meters                                                   |
| density       | character     | Categorical population density (least dense, somewhat dense, dense, very dense, most dense)                 |
| aptitude      | character     | suitability of the site for a wastewater treatment system                                                   |
| zoning        | character     | “group” if collective or grouped sanitation is possible in short term.                                      |
| latrine       | character     | Suggested pit latrine and septic allowance (allowed, not allowed)                                           |
| standing      | character     | Unknown                                                                                                     |
| density_ra    | double        | Catgoriccal population density according to the description of the variable “density” (values from 1 to 5)  |
| economy_nu    | double        | Categotical socioeconomic status according to the description of the variable “economy” (1=low, 2 = medium) |
| geometry      | list          | Geospatial data of the neighborhood stored as a polygon                                                     |

A small visualisation of this data set

<img src="man/figures/README-unnamed-chunk-12-1.png" width="100%" />

## Examples

This is a basic example which shows you how to use the data:

``` r
library(cbssuitabilityhaiti)
## basic example code
```
