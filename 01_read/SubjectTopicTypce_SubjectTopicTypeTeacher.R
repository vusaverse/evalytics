## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the two tables subjectTopicType and subjectTopicTypeTeacher.
## 2) The resulting dataframe contains a lot of NA values.
## 3) The reason is that not all subjectTopicTypeIds have an entry in the dfsubjectTopicTypeTeacher table.
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfsubjectTopicType <- readr::read_delim(unz(sMostrecent_zip, "subjectTopicType.csv"))
dfsubjectTopicTypeTeacher <- readr::read_delim(unz(sMostrecent_zip, "subjectTopicTypeTeacher.csv"))

##' *INFO*: We encounter a one-to-many relationship between the two tables.
##' The reason being that for some subjectTopicTypeIds, there are multiple teachers.
##' Furthermore, not all subjectTopicTypeIds have an entry in the dfsubjectTopicTypeTeacher table.
dfsubjectTopicTypeJoined <- dfsubjectTopicType %>%
  left_join(dfsubjectTopicTypeTeacher, by = c("id" = "subjectTopicTypeId"))


## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

write_file_proj(dfsubjectTopicTypeJoined, "SubjectTopicTypce_SubjectTopicTypeTeacher")

clear_script_objects()
