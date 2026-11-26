#' @noRd
#' @title Helper functions that clean column names and check if the input matches the requirement of the `makekey` function
#' @description
#' Allow  the `makekey` function to ignore case and formatting differences in the column names of the input dataframe.
#' @param data A data frame containing columns identifying well IDs, treatments, and trial. 
#' Column names should preferably be `well_ID`, `treatment`, and `trial`.
#' @param x A character vector of column names in the data input.
#' @param required_col A character vector of column names should be in the key.
#' @return A character vector containing only the matched column names.

normalize_names <- function(x) {
  tolower(gsub("[^[:alnum:]]", "", x))
}

match_cols <- function(data, required_cols) {
  
  actual_names <- names(data)
  normalized_actual <- normalize_names(actual_names)
  normalized_required <- normalize_names(required_cols)
  
  matches <- match(normalized_required, normalized_actual)
  
  if (anyNA(matches)) {
    stop(
      "Missing required columns: ",
      paste(required_cols[is.na(matches)], collapse = ", ")
    )
  }
  
  actual_names[matches]
}

