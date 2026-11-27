#' @title Example of the new TECAN output
#' @description
#' * Copy and paste the area containing data (ie. delete empty well columns) in the raw output into a new sheet. 
#' * The measurement from each kinetic cycle is saved into separate sheets. No need to modify any column names or arrangements, which will cause the function to fail.
#' * The function can remove empty columns when the microplate is partially used.
#' * Call readxl::read_xlsx(/path, sheet="name") to import data sheets.
#' * Save the dataframes into a list. The order of dataframes should follow the measurement sequence (ie. list(first_1.5h, second_15h))
#' @format 
#' #' \describe{
#'   \item{first_1.5h}{The first kinetic cycle, duration = 1.5h}
#'   \item{second_15h}{The second kinetic cycle, duration = 15h}
#'   \item{NewTECAN_rawOutputList}{List of dataframes, c(first_1.5h, second_15h) by measurement sequence}
#'   }
#' @source Example data
"NewTECAN_rawOutput_List"