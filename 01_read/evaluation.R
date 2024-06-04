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
  if (grepl("[Ee]valuation", file, ignore.case = TRUE)) {
    # Read the CSV file directly from the ZIP file
    lData_frames[[file]] <- readr::read_delim(unz(sMostrecent_zip, file))
  }
}


dfEvaluation <- lData_frames[["evaluation.csv"]]

dfEvaluationBlockQuestion <- lData_frames[["evaluationBlockQuestion.csv"]]



dfEvaluationBlockQuestionSet <- lData_frames[["evaluationBlockQuestionSet.csv"]]
dfEvaluationBlockTeacher <- lData_frames[["evaluationBlockTeacher.csv"]]
dfEvaluationBlock <- lData_frames[["evaluationBlock.csv"]]

dfEvaluationCode <- lData_frames[["evaluationCode.csv"]]
dfEvaluationLabel <- lData_frames[["evaluationLabel.csv"]]
dfEvaluationToLabel <- lData_frames[["evaluationToLabel.csv"]]


zz_evaluation_joined <- dfEvaluation %>%
  left_join(dfEvaluationToLabel, by = c("id" = "evaluationId"), suffix = c("", "_evaluation_to_label")) %>%
  left_join(dfEvaluationLabel, by = c("evaluationLabelId" = "id"), suffix = c("", "_evaluation_label")) %>%
  left_join(dfEvaluationCode, by = c("id" = "evaluationId"), suffix = c("", "_evaluation_code")) %>%
  left_join(dfEvaluationBlock, by = c("id" = "evaluationId"), suffix = c("", "_evaluation_block")) %>%
  left_join(dfEvaluationBlockTeacher, by = c("id_evaluation_block" = "evaluationBlockId"), suffix = c("", "_evaluation_block_teacher")) %>%
  left_join(dfEvaluationBlockQuestionSet, by = c("id_evaluation_block" =  "evaluationBlockId"), suffix = c("", "_evaluation_block_question_set")) %>%
  left_join(dfEvaluationBlockQuestion, by = c("id_evaluation_block" = "evaluationBlockId"), suffix = c("", "_evaluation_block_question"))




## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()

