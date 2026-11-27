#' @title Example of the olde TECAN output
#' @description
#' * Copy and paste the area containing data (ie. delete empty well columns) in the raw output into a new sheet. 
#' Please do not modify anything.
#' * The function can remove empty columns when the microplate is partially used.
#' * The function will add a column name to the time stamp column.
#' * Call readxl::read_xlsx(/path) to import data sheets.
#' @source Example data
"OldTECAN_rawOutput"