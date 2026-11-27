#' @title Clean up the new TECAN output
#' @description
#' This function is designed to clean-up the output of \strong{TECAN}
#' * Adjusts time stamps to maintain continuity across consecutive measurements
#' * Standardizes the column names of the original spreadsheet.
#' * For output of the new TECAN: combines measurements from multiple kinetic runs into a single continuous dataframe by stacking the input dataframes in their original order.
#' @param output A \strong{list} of dataframes containing measurements from a series of kinetic cycles, ordered by measurement sequence, 
#' or a \strong{single dataframe} containing the raw output of the old TECAN.
#' @returns A dataframe containing the all measurements, with standardized time stamps - `Time_s`and the well ID columns.
#' @examples
#' #If calling the function on new TECAN data:
#' data("NewTECAN_rawOutput_List")
#' df_NEW <- cleaner_T(NewTECAN_rawOutput_List)
#' str(df_NEW)
#' 
#' #If calling the function on old TECAN data:
#' data("OldTECAN_rawOutput")
#' cleaned_OLD <- cleaner_T(OldTECAN_rawOutput)
#' str(cleaned_OLD)
#' @export
cleaner_T <- function(output){
  if (is.data.frame(output)) {
    cols <- names(output)
    cols[1] <- "Time_s"
    
    df <- dplyr::as_tibble(output)
    names(df) <- cols
    
    df$"Time_s" <- stringr::str_remove(df$"Time_s", "s")
    
  } else if (is.list(output)) {
    cleaned_list <- purrr::map(output, clean_col)
    df <- dplyr::bind_rows(cleaned_list)
    df <- df[, !names(df) %in% c("Cycle", "Temp")]
    
  } else {
    stop("Input must be a list (new TECAN) or a data frame (old TECAN).")
  }
  
  df$Time_s <- as.numeric(df$Time_s)
  
  df <- df[, !sapply(df, \(x) all(is.na(x) | trimws(x) == ""))]
  
  time_adj <- 0
  index <- NULL
  
  for (i in 2:nrow(df)) {
      
      if (df$Time_s[i] < df$Time_s[i-1]) {
        time_adj <- df$Time_s[i-1]+(df$Time_s[i-1]-df$Time_s[i-2])
        
        index <- i
        break
      }
      
    }
  
  if (!is.null(index)) {
    df$Time_s[index:nrow(df)] <- df$Time_s[index:nrow(df)] + time_adj
  }
    
  return(df)
}