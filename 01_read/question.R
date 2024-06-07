## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Attempt to join all "evaluation" export files together
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
  if (grepl("[Qq]uestion", file, ignore.case = TRUE)) {
    # Read the CSV file directly from the ZIP file
    lData_frames[[file]] <- readr::read_delim(unz(sMostrecent_zip, file))
  }
}




dfevaluationBlockQuestion <- lData_frames[["evaluationBlockQuestion.csv"]]
dfevaluationBlockQuestionSet <- lData_frames[["evaluationBlockQuestionSet.csv"]]
dfquestion <- lData_frames[["question.csv"]]

dfquestionLabel <- lData_frames[["questionLabel.csv"]]
dfquestionScale <- lData_frames[["questionScale.csv"]]
dfquestionScaleValue <- lData_frames[["questionScaleValue.csv"]]
dfquestionToLabel <- lData_frames[["questionToLabel.csv"]]


## Good
zzQuestionToLabel <- dfquestionToLabel %>%
  left_join(dfquestionLabel, by = c("questionLabelId" = "id"))

## left hand side step is empty
zzQuestionScale <- dfquestionScale %>%
  left_join(dfquestionScaleValue, by = c("hash" = "questionScaleHash"), suffix = c("", ".value"))


##   Detected an unexpected many-to-many relationship between `x` and y
zzQuestion <- dfquestion %>%
  left_join(zzQuestionToLabel, by = c("hash" = "questionHash")) %>%
  left_join(zzQuestionScale, by = c("questionScaleHash" = "hash"), suffix = c("", ".scale"))


## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()

