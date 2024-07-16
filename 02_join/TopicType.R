## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join tables to TopicType
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfTopicType <- readr::read_delim(unz(sMostrecent_zip, "topicType.csv"))
dfSubject <- readr::read_delim(unz(sMostrecent_zip, "subjectTopicType.csv"))
dfEvaluationBlock <- readr::read_delim(unz(sMostrecent_zip, "evaluationBlock.csv"))
dfGenericTopic <- readr::read_delim(unz(sMostrecent_zip, "genericTopicTopicType.csv"))

## Join the dataframes
dfTopicTypeJoined <- dfTopicType %>%
  left_join(dfSubject, by = c("id" = "topicTypeId"), suffix = c(".topic", ".subject")) %>%
  left_join(dfGenericTopic, by = c("id" = "topicTypeId"), suffix = c(".topic", ".generic")) %>%
  left_join(dfEvaluationBlock, by = c("id" = "topicTypeId"), suffix = c(".topic", ".evaluation"))

## PROBLEM: df is very big about 162 million objects. There must be a better way to organize this...
## (edit) SOLUTION: Filter out rows that have NA in 'name' and/or 'description'
dfTopicTypeFiltered <- dfTopicTypeJoined %>%
  filter(!is.na(name) & !is.na(description))

## Remove empty columns
dfTopicTypeFiltered <- dfTopicTypeFiltered %>%
  select(-'id.generic', -'genericTopicId', -'index.generic', -'parentTopicTypeId')

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#clear_script_objects()

