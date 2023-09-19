library(tidyverse)
library(here)
library(janitor)
library(devtools)
library(openwashdata)
library(desc)


# update dictionary -------------------------------------------------------

# DONE
# Create and update dictionary
# function that conversts dictionary as xlsx to csv for later use in roxygen
update_dictionary <- function(dictionary_path) {
  dictionary_excel <-
    readxl::read_excel(dictionary_path)

  dictionary_excel |>
    readr::write_csv("data-raw/dictionary.csv")
}

# DONE
# update_dictionary("data-raw/dictionary.xlsx")

# Add documentation -------------------------------------------------------

# DONE
# # load openwashdata package
# devtools::install_github("openwashdata/openwashdata")
# library(openwashdata)

# Done
# Initiate documentation folder for writing up metadata and documentation for objects
# dir.create("R")
# usethis::use_r("mwater")
# usethis::use_r("okap")

# DONE
# Add documentation from data dictionary to script as roxygen
# openwashdata::generate_roxygen_docs("data-raw/dictionary.csv", output_file_path = "R/okap.R")
# openwashdata::generate_roxygen_docs("data-raw/dictionary.csv", output_file_path = "R/mwater.R")

# TODO
# Add data description to DATASET.R files

# DONE
# # Add an additional package documentation to Package
# usethis::use_package_doc()

# DONE
# Add license
# usethis::use_ccby_license()

# TB UPDATED
# Add dependencies in DESCRIPTION file
# use_package("tidyverse")
use_package("tmap","Suggests")

# TODO
# Add authors information

# DONE
# # Creatre authors skeleton
# use_authors_skeleton <- function(dest = NULL){
#   if(is.null(dest)){
#     dest <- file.path(proj_get(),"bootstrap","authors.csv")
#   } else {
#     dest
#   }
#   tbl <- tibble(
#     first_name = character(),
#     last_name = character(),
#     email = character(),
#     role = character(),
#     orcid = character()
#   )
#   write_csv(tbl, file = paste0(dest, "authors.csv"))
#   openxlsx::write.xlsx(x = tbl, file = paste0(dest, "authors.xlsx"))
# }
# use_authors_skeleton(dest = "data-raw/")

# DONE
# Create converting function from xlsx to csv
update_authors_csv <- function(authors_path) {
  authors_excel <-
    readxl::read_excel(authors_path)

  authors_excel |>
    readr::write_csv("data-raw/authors.csv")
}

# DONE
# Create use authors information function
#' @param f character file location of the authors .csv file
#' @param quiet logical should the function be quiet about the number of authors
#' found in the csv file? Defaults to FALSE.
#' @importFrom usethis use_author
#' @importFrom dplyr rowwise
#' @importFrom readr read_csv
#' @export
use_authors_from_csv <- function(f = "bootstrap/authors.csv", quiet = FALSE){
  a <- read_csv(f, col_types = "cccc")
  n <- a |>
    rowwise() |>
    transmute(df = use_author(given = first_name,
                              family = last_name,
                              email = email,
                              role = role,
                              comment = ifelse(is.na(orcid),
                                               '',
                                               orcid)
    )
    ) |>
    nrow()
  if(!quiet){
    message(
      sprintf("%d authors added to the DESCRIPTION file.", n)
    )
  }
}
use_authors_from_csv_replace <- function(f = "raw-data/authors.csv", quiet = FALSE){

  a <- read_csv(f, col_types = "cccc")

  old <- length(desc_get_authors())

  for (i in row(a[1])) {
    desc_del_author(given = a$first_name[i],
                    family = a$last_name[i],
                    email = a$email[i],
                    role = a$role[i])
  }

  u <- old - length(desc_get_authors())

  n <- a |>
    rowwise() |>
    transmute(df = use_author(given = first_name,
                              family = last_name,
                              email = email,
                              role = role,
                              comment = ifelse(is.na(orcid),
                                               '',
                                               orcid)
    )
    ) |>
    nrow()

  if(!quiet){
    message(
      sprintf("%d authors updated to the DESCRIPTION file \n", u),
      sprintf("%d authors added to the DESCRIPTION file.", (n - u))
    )
  }
}

# TODO (orcid-ids...)
# Update Authors csv
update_authors_csv("data-raw/authors.xlsx")
use_authors_from_csv(f = "data-raw/authors.csv")
use_authors_from_csv_replace(f = "data-raw/authors.csv")
# Add CITATION.cff file
cffr::cff_write()

# DONE
# Add citation statement to .R-files

# DONE
# Include Citation statements to the end of the README.Rmd/Readme.md file

# load, document, check, and install
devtools::load_all()  # "Cmd + Shift + L"
devtools::document()  # "Cmd + Shift + D"
devtools::check()     # "Cmd + Shift + E"
devtools::install()   # "Cmd + Shift + B"

# DONE
# Create a rmd README for package
# usethis::use_readme_rmd()

# DONE
# Create an examples article for the package
usethis::use_article("examples")
devtools::build_rmd("vignettes/articles/examples.Rmd")

# Add automated CMD BUILD check
usethis::use_github_action_check_standard()

# Setup pkgdown configuration and github actions
usethis::use_pkgdown()

# Build pkgdown website
pkgdown::build_site()

# install.packages("cffr")
library(cffr)

packageVersion("cffr")

# Hard code doi
doi <- "10.5281/zenodo.8361085"

# creates CFF with all author roles
mod_cff <- cff_create("DESCRIPTION",
                      dependencies = FALSE,
                      keys = list("doi" = doi,
                      "date-released" = Sys.Date()))

# Remove the preferred-citation key
mod_cff$`preferred-citation` <- NULL

# writes the CFF file
cff_write(mod_cff)

# Now write a CITATION file from the CITATION.cff file
# Use inst/CITATION instead (the default if not provided)
path_cit <- file.path("inst/CITATION")

write_citation("CITATION.cff", file = path_cit)

# By last, read the citation
cat(readLines(path_cit), sep = "\n")

# Start of inst/CITATION
utils::readCitationFile("inst/CITATION")
