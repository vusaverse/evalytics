## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the evaluation, evaluationCode, and evaluation labelled data frames.
## 2) TODO: evaluationBlock needs to be created and joined
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfEvaluation <- readr::read_delim(unz(sMostrecent_zip, "evaluation.csv"))
dfEvaluationCode <- readr::read_delim(unz(sMostrecent_zip, "evaluationCode.csv"))
dfEvaluationLabelled <- read_file_proj("EvaluationLabelled")

## Join the two data frames
dfEvaluation_Joined <- dfEvaluation %>%
  ##' *INFO*: It appears that evaluationId can have more than one evaluationLabelIdName.
  left_join(dfEvaluationLabelled, by = c("id" = "evaluationId"), suffix = c(".evaluation", ".label")) %>%
  ##' *INFO*: It appears multiple codes are available, which causes one-to-many relationship.
  left_join(dfEvaluationCode, by = c("id" = "evaluationId"), suffix = c(".evaluation", ".code"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

write_file_proj(dfEvaluation_Joined, "EvaluationJoined")

clear_script_objects()
