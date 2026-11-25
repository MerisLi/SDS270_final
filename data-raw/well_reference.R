well_reference <- readxl::read_xlsx(
  "data-raw/well_reference_SAMPLE.xlsx"
)

usethis::use_data(
  well_reference,
  overwrite = TRUE
)