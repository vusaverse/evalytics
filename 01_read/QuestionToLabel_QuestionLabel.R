## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join QuestionToLabel and QuestionLabel data.
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfQuestionLabel <- readr::read_delim(unz(sMostrecent_zip, "questionLabel.csv"))
dfQuestionToLabel <- readr::read_delim(unz(sMostrecent_zip, "questionToLabel.csv"))

## Join the two data frames
dfQuestionLabelled <- dfQuestionToLabel %>%
  left_join(dfQuestionLabel, by = c("questionLabelId" = "id"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

write_file_proj(dfQuestionLabelled, "QuestionLabelled")

clear_script_objects()
