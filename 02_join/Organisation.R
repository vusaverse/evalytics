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
dfOrganisation <- readr::read_delim(unz(sMostrecent_zip, "organisation.csv"))
dfSubject <- readr::read_delim(unz(sMostrecent_zip, "subject.csv"))
dfTeacher <- readr::read_delim(unz(sMostrecent_zip, "teacher.csv"))
dfGenericTopic <- readr::read_delim(unz(sMostrecent_zip, "genericTopic.csv"))

## Join the four data frames
dfOrganisationJoined <- dfOrganisation %>%
  left_join(dfSubject, by = c("id" = "organisationId")) %>%
  left_join(dfTeacher, by = c("id" = "organisationId")) %>%
  left_join(dfGenericTopic, by = c("id" = "organisationId"))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()
