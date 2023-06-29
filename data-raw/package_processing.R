
# TODO
# update_dictionary("data-raw/dictionary.xlsx")

# DONE
# Add documentation -------------------------------------------------------
devtools::install_github("openwashdata/openwashdata")
library(openwashdata)

# Done
# Initiate documentation folder for writing up metadata and documentation for objects
# dir.create("R")
# usethis::use_r("mwater")
# usethis::use_r("okap")

# TODO
# Add documentation from data dictionary to script as roxygen
openwashdata::generate_roxygen_docs("data-raw/dictionary.csv", output_file_path = "R/okap.R")
openwashdata::generate_roxygen_docs("data-raw/dictionary.csv", output_file_path = "R/mwater.R")

# DONE
# Add an additional package documentation to Package
usethis::use_package_doc()

TB UPDATED
# Add dependencies in DESCRIPTION file
# use_package("tidyverse")
use_package("tmap")
use_package("here")

# DONE
# ADd license
usethis::use_ccby_license()

# TB UPDATED
# Add CITATION.cff file
cffr::cff_write()

# load, document, check, and install
devtools::load_all()  # "Cmd + Shift + L"
devtools::document()  # "Cmd + Shift + D"
devtools::check()     # "Cmd + Shift + E"
devtools::install()   # "Cmd + Shift + B"

# DONE
# Create a rmd README for package
usethis::use_readme_rmd()

# DONE
# Create an examples article for the package
usethis::use_article("examples")
devtools::build_rmd("vignettes/articles/examples.Rmd")

# Add automated CMD BUILD check
usethis::use_github_action_check_standard()


