first_1.5h <- readxl::read_xlsx(
  "data-raw/OldTECAN_rawOutput_SAMPLE.xlsx",
  sheet = "first"
)

second_15h <- readxl::read_xlsx(
  "data-raw/OldTECAN_rawOutput_SAMPLE.xlsx",
  sheet = "second"
)

OldTECAN_rawOutputList <- list(first_1.5h, second_15h)

usethis::use_data(
  OldTECAN_rawOutputList,
  overwrite = TRUE
)