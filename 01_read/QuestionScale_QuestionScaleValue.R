## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join SubjectLabel and SubjectToLabel tables.
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfQuestionScale <- readr::read_delim(unz(sMostrecent_zip, "questionScale.csv"))
dfQuestionScaleValue <- readr::read_delim(unz(sMostrecent_zip, "questionScaleValue.csv"))

## Join the two data frames
dfQuestion <- dfQuestionScaleValue %>%
  left_join(dfQuestionScale, by = c("questionScaleHash" = "hash"), suffix = c(".value", ".scale"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()
