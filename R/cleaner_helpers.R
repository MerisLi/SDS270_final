#' @noRd
#' @title Helper functions that clean column names for the New Tecan output
#' @description
#' Standardize the names of columns holding cycle numbers, time stamps, and temperature.
#' Support the `cleaner_NewT` function.
#' @param data The raw dataframe copied from the output spreadsheet.
#' Should follow this order: `Cycle Nr.`,	`Time [s]`,	`Temp. [°C]`, `A1`, `A2`, etc.. #' 
#' @return A dataframe with cleaned names: `Cycle`, `Time_s`, and `Temp`; other well IDs remain as default.

clean_col <- function(x){
  
  col <- names(x)
  
  cycle <- which(stringr::str_detect(col, "^Cycle"))
  time  <- which(stringr::str_detect(col, "^Time"))
  temp  <- which(stringr::str_detect(col, "^Temp"))
  
  if(length(cycle) != 1 ||
     length(time) != 1 ||
     length(temp) > 1 ){
    stop("Please directly copy & paste the TECAN output without modifying the order of columns.")
  }
  
  col[cycle] <- "Cycle"
  col[time]  <- "Time_s"
  if(length(temp) == 1){
    col[temp] <- "Temp"
  }
  
  if(any(stringr::str_detect(col, "[^[:alnum:]_]"))){
    stop("Invalid column names detected.")
  }
  
  names(x) <- col
  
  return(x)
}