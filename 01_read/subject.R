## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Attempt to join all "subject" export files together
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")

sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

# Get a list of file names inside the ZIP file
vFile_names <- unzip(sMostrecent_zip, list = TRUE)$Name %>% sort

# Create an empty list to store the data frames
lData_frames <- list()

# Loop through each file name
for (file in vFile_names) {
  # Check if the file is a CSV file
  if (grepl("[Ss]ubject", file, ignore.case = TRUE)) {
    # Read the CSV file directly from the ZIP file
    lData_frames[[file]] <- readr::read_delim(unz(sMostrecent_zip, file))
  }
}

dfSubject <- lData_frames[["subject.csv"]]
dfSubjectGrade <- lData_frames[["subjectGrade.csv"]]
dfSubjectGradePeriod <- lData_frames[["subjectGradePeriod.csv"]]

dfSubjectLabel <- lData_frames[["subjectLabel.csv"]]
dfSubjecttoLabel<- lData_frames[["subjectToLabel.csv"]]

dfSubjectTopicType <- lData_frames[["subjectTopicType.csv"]]
dfSubjectTopicTypeteacher <- lData_frames[["subjectTopicTypeTeacher.csv"]]


Subject_joined <- dfSubject %>%
  left_join(dfSubjectGrade, by = c("id" = "subjectId"), suffix = c("", "_subject_grade")) %>%
  left_join(dfSubjectGradePeriod, by = c("id_subject_grade" = "subjectGradeId"), suffix = c("", "_subject_grade_period")) %>%
  left_join(dfSubjecttoLabel, by = c("id" = "subjectId"), suffix = c("", "_subject_to_label")) %>%
  left_join(dfSubjectLabel, by = c("subjectLabelId" = "id"), suffix = c("", "_subject_label")) %>%
  left_join(dfSubjectTopicType, by = c("id" = "subjectId"), suffix = c("", "_subject_topic_type")) %>%
  left_join(dfSubjectTopicTypeteacher, by = c("topicTypeId" = "subjectTopicTypeId"), suffix = c("", "_subject_topic_type_teacher"))


## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()

