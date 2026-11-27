OldTECAN_rawOutput <- readxl::read_xlsx(
  "data-raw/OldTECAN_rawOutput.xlsx"
)

usethis::use_data(
  OldTECAN_rawOutput,
  overwrite = TRUE
)