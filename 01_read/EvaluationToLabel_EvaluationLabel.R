## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join evaluationLabel and evaluationToLabel tables.
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfEvaluationLabel <- readr::read_delim(unz(sMostrecent_zip, "evaluationLabel.csv"))
dfEvaluationToLabel <- readr::read_delim(unz(sMostrecent_zip, "evaluationToLabel.csv"))

## Join the two data frames
dfEvaluationLabelled <- dfEvaluationToLabel %>%
  left_join(dfEvaluationLabel, by = c("evaluationLabelId" = "id"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()
