## R code voor Student Analytics Vrije Universiteit Amsterdam
## Copyright 2023 VU
## Web Page: http://www.vu.nl
## Contact: vu-analytics@vu.nl
##
##
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Function to set all environment variables
set_all_envs <- function(var.name, var.value) {
  args = list(var.value)
  names(args) = var.name
  do.call(Sys.setenv, args)
}

##' *INFO*: The RENVIRON_PATH is set in the .Renviron file
##' TO add it there run the following code:
##' usethis::edit_r_environ()
##' and add the following line:
##' RENVIRON_PATH = "path/to/your/file.xlsx"
to_set <- readxl::read_xlsx(Sys.getenv("RENVIRON_PATH"))

## Set systemvariables inR
purrr::pmap(list(to_set$variable, to_set$value), set_all_envs)

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## CLEAR ####
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear_script_objects()
