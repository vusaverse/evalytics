## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code voor Student Analytics Vrije Universiteit Amsterdam
## Copyright 2023 VU
## Web Page: http://www.vu.nl
## Contact: vu-analytics@vu.nl
##
##' *INFO*:
## 1) Loads packages for the project using library()
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Define the basic packages
basic_packages <- c(
  "dataMaid",       # Used for export analysis sets.
  "MASS",           # Provides a lot of basic statistical functions
  "ggplot2",        # For basic plots
  "rvest",          # Used to get data from the web.
  "readxl",         # Used to read Excel (.xls and .xlsx) files
  "checkmate",      # Used for assertion tests
  "cli",            # Used to add color to console messages
  "digest",         # Used for hashing variables
  "gridExtra",      # Used to place multiple graphical objects in a table
  "haven",          # Used for importing SPSS, STATA, and SAS files
  "httr",           # Used to work with HTTP
  "janitor",        # Used to clean up variable names from special characters
  "lubridate",      # Used to work with dates and times
  "purrr",          # Used to work with functions and vectors
  "readr",          # Used to read data (csv, tsv, and fwf)
  "vroom",          # Used to quickly read CSV data
  "slackr",         # Used to send messages in Slack
  "stats",          # Used for statistical functions and calculations
  "stringr",        # Used for functions to work with strings
  "tibble",         # Used for editing and creating tibbles
  "tidyr",          # Used to clean data in the tidyverse environment
  "utils",          # Used for utility functions
  "fst",            # Used for operations on large data files
  "styler",         # Used for improving the style of script
  "vusa",           # Mainly to always have the addins
  "vvmover",           # Mainly to always have the addins
  "dplyr"           # Used for the dplyr environment
)

# Load the packages into the library
suppressMessages(purrr::walk(basic_packages, ~library(.x, character.only = TRUE, warn.conflicts = FALSE)))

if (interactive()) {
  library(tidylog)
}

vusa::clear_script_objects()
