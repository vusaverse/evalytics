## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the subjectGrade and subjectGradePeriod dataframes.
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfsubjectGrade <- readr::read_delim(unz(sMostrecent_zip, "subjectGrade.csv"))
dfsubjectGradePeriod <- readr::read_delim(unz(sMostrecent_zip, "subjectGradePeriod.csv"))

dfSubjectGradeJoined <- dfsubjectGrade %>%
  left_join(dfsubjectGradePeriod, by = c("id" = "subjectGradeId"))


## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

write_file_proj(dfSubjectGradeJoined, "SubjectGradeJoined")

clear_script_objects()
