first_1.5h <- readxl::read_xlsx(
  "data-raw/NewTECAN_rawOutput_SAMPLE.xlsx",
  sheet = "first_1.5h"
)

second_15h <- readxl::read_xlsx(
  "data-raw/NewTECAN_rawOutput_SAMPLE.xlsx",
  sheet = "second_15h"
)

NewTECAN_rawOutputList <- list(first_1.5h, second_15h)
  
usethis::use_data(
  NewTECAN_rawOutputList,
  overwrite = TRUE
)