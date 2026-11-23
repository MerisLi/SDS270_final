#' @title Make a key for the 96-well plate treatment assignments
#' @description
#' Given a 96-well reference data sheet, the `makekey()` function can label the replication wells 
#' and generate unique identifiers (`keys`) for each observation based on strain, treatment, and repetition number.
#' @param data A data frame containing columns identifying well IDs, treatments, and strains. 
#' Column names should preferably be `well_ID`, `treatment`, and `strain`. However, the function is case-insensitive and does not require a specific column order in the input.
#' @importFrom dplyr filter group_by mutate arrange select ungroup
#' @returns A dataframe with 5 columns and standardized column names:
#' * `well_ID`: The original well identifier (e.g. A1).
#' * `strains`: The strain identifier (e.g. E2).
#' * `treatment`: Can be either a numeric volume or concentration, stored as a factor (e.g. 1 represents a treatment group that receives 1ug/mL ciprofloxacin per well).
#' * `reps`: The repetition number within each strain-treatment combination (e.g. getting 1, 2, or 3 for a triplicate)
#' * `keys`: A unique sample identifiers for each well, constructed from strain, treatment, and repetition number, stored as a factor 
#' (e.g. wt_1_1, wt_1_2, and wt_1_3 represent a triplicate of the wild-type (wt) strain receiving 1ug/mL ciprofloxacin treatment.
#' @examples
#' key <- makekey(well_reference)
#' str(key)
#' @export

makekey <- function(data){
  matched_cols <- match_cols(
    data,
    required_cols = c("well_ID", "treatment", "strains"))
  
  well_ID <- matched_cols[1]
  treatment <- matched_cols[2]
  strains <- matched_cols[3]
  
  data[[treatment]] <- factor(as.numeric(data[[treatment]]))
  
  
  data <- data|>
    group_by(.data[[strains]], .data[[treatment]])|>
    arrange(.data[[well_ID]], .by_group = TRUE)|>
    mutate(reps=seq_along(.data[[well_ID]]),
           keys = paste(.data[[strains]], .data[[treatment]], reps, sep = "_"))|>
    ungroup()|>
    mutate(
      keys = factor(
        keys,
        levels = unique(keys[order(.data[[strains]],
                                   .data[[treatment]])])
      ))

  
  data <- data|>
    select(.data[[well_ID]], 
           .data[[strains]], 
           .data[[treatment]],
           reps,
           keys)|>
    rename(well_ID = .data[[well_ID]],
           strains = .data[[strains]],
           treatment = .data[[treatment]])
  
  
  return(data)
}