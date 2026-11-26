#' @title Clean up the new TECAN output
#' @description
#' This function is designed to clean-up the output of \strong{NEW TECAN}
#' * Combines measurements from multiple kinetic runs into a single continuous dataframe by stacking the input dataframes in their original order.
#' * Adjusts cycle numbers and timestamps to maintain continuity across consecutive measurements
#' * Standardizes the column names of the original spreadsheet (`Cycle Nr.`, `Time [s]`, and `Temp. [°C]`).
#' @param measurements A \strong{list} of dataframes containing measurements from a series of kinetic cycles, ordered by measurement sequence.
#' @returns A dataframe containing the combined measurements, with standardized 
#' column names (`Cycle`, `Time_s`, and `Temp`) and the original well ID columns.
#' @examples
#' data("NewTECAN_rawOutputList")
#' combined_NEW <- cleaner_NewT(NewTECAN_rawOutputList)
#' str(combined_NEW)
#' @export
cleaner_NewT <- function(measurements){
  cleaned_list <- purrr::map(measurements, clean_col)
  combined <- dplyr::bind_rows(cleaned_list)
  
  combined$Cycle <- as.numeric(combined$Cycle)
  combined$Time_s <- as.numeric(combined$Time_s)
  
  cycle_adj <- 0
  time_adj <- 0
  index <- NULL
  
  for (i in 2:nrow(combined)) {
    
    if (combined$Cycle[i] < combined$Cycle[i-1] && combined$Time_s[i] < combined$Time_s[i-1]) {
      
      index <- i
      
      if (combined$Cycle[i] < combined$Cycle[i-1]) {
        cycle_adj <- combined$Cycle[i-1]
      }
      
      if (combined$Time_s[i] < combined$Time_s[i-1]) {
        time_adj <- combined$Time_s[i-1]
      }
      
      break
    }
  }
  
  if (!is.null(index)) {
    combined$Cycle[index:nrow(combined)] <- combined$Cycle[index:nrow(combined)] + cycle_adj
    combined$Time_s[index:nrow(combined)] <- combined$Time_s[index:nrow(combined)] + time_adj
  }
    
  return(combined)
}