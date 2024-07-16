## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the evaluation, avaluationCode, and evaluation labelled data frames.
## 2) TODO: evaluationBlock needs to be created and joined
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sDir <- paste0(Sys.getenv("RAW_DATA_DIR"), "Evalytics/")
sMostrecent_zip <- vvmover::get_recent_file_date_modified(sDir, ".zip")

## Read the required CSV files directly from the ZIP file
dfAnswerSetTextResult <- readr::read_delim(unz(sMostrecent_zip, "answerSetTextResult.csv"))
dfAnswerSetResult <- readr::read_delim(unz(sMostrecent_zip, "answerSetResult.csv"))
dfEvaluationBlock <- readr::read_delim(unz(sMostrecent_zip, "evaluationBlock.csv"))
dfEvaluationCode <- readr::read_delim(unz(sMostrecent_zip, "evaluationCode.csv"))



dfTeacher <- readr::read_delim(unz(sMostrecent_zip, "teacher.csv"))
dfEvaluationBlockQuestion <- readr::read_delim(unz(sMostrecent_zip, "evaluationBlockQuestion.csv"))

dfQuestions <- read_file_proj("QuestionJoined", dir = "2. Geprepareerde data")



dfAnswerSetTextResult_joined <- dfAnswerSetTextResult %>%
  left_join(dfTeacher, by = c("teacherId" = "id"), suffix = c(".answer_set", ".teacher")) %>%
  left_join(dfEvaluationBlock, by = c("evaluationBlockId" = "id"), suffix = c(".answer_set", ".evaluation_block")) %>%
  left_join(dfEvaluationBlockQuestion, by = c("evaluationBlockQuestionId" = "id"), suffix = c(".answer_set", ".evaluation_block_question")) %>%
  left_join(dfEvaluationCode, by = c("evaluationCodeId" = "id"), suffix = c(".answer_set", ".evaluation_code")) %>%
  left_join(dfQuestions, by = c("questionHash" = "hash"), suffix = c(".answer_set", ".question"))


dfAnswerSetResult_joined <- dfAnswerSetResult %>%
  left_join(dfTeacher, by = c("teacherId" = "id"), suffix = c(".answer_set", ".teacher")) %>%
  left_join(dfEvaluationBlock, by = c("evaluationBlockId" = "id"), suffix = c(".answer_set", ".evaluation_block")) %>%
  left_join(dfEvaluationBlockQuestion, by = c("evaluationBlockQuestionId" = "id"), suffix = c(".answer_set", ".evaluation_block_question")) %>%
  left_join(dfEvaluationCode, by = c("evaluationCodeId" = "id"), suffix = c(".answer_set", ".evaluation_code")) %>%
  left_join(dfQuestions, by = c("questionHash" = "hash"), suffix = c(".answer_set", ".question"))


## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## WRITE & CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

write_file_proj(dfAnswerSetTextResult_joined, "AnswerSetTextResult")
write_file_proj(dfAnswerSetResult_joined, "AnswerSetResult")

clear_script_objects()
