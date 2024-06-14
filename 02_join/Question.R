## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the question, question scale and question labelled data frames.
## 2) TODO: write prior dataframes and read in this script
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfQuestions <- readr::read_delim(unz(sMostrecent_zip, "question.csv"))

## Join the two data frames
dfQuestion_Joined <- dfQuestions %>%
  ##' *INFO*: As known each question has multiple rows for the scale, which causes one-to-many relationship.
  left_join(dfQuestion, by = c("questionScaleHash"), suffix = c(".question", ".scale")) %>%
  left_join(dfQuestionLabelled, by = c("hash" = "questionHash"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()
