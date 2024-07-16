## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## R code for Education Analytics Vrije Universiteit Amsterdam
## Copyright 2024 VU
## Web Page: http://www.vu.nl
## Contact:
##
##' *INFO*:
## 1) Join the question, question scale and question labelled data frames.
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

dfAnswerSetResult_joined <- read_file_proj("AnswerSetResult", dir = "2. Geprepareerde data")

question_codes <- c("VU-AFSL-S-01", "VU-TS-S-03")

dfAnswerSetResult_joined_specific <- dfAnswerSetResult_joined %>%
  filter(code.question %in% question_codes)
