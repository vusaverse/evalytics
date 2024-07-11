## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the evaluation, avaluationCode, and evaluation labelled data frames.
## 2) TODO: write prior dataframes and read in this script
## 3) TODO: evaluationBlock needs to be created and joined
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfEvaluation <- readr::read_delim(unz(sMostrecent_zip, "evaluation.csv"))
dfEvaluationCode <- readr::read_delim(unz(sMostrecent_zip, "evaluationCode.csv"))

dfTopicTypeJoined <- dfTopicType %>%
  left_join(dfSubject, by = c("id" = "topicTypeId"), suffix = c(".topic", ".subject")) %>%
  left_join(dfEvaluationBlock, by = c("id" = "topicTypeId"), suffix = c(".topic", ".evaluation"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#clear_script_objects()
