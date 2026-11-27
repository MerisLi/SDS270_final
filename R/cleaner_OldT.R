#' This function is designed to clean-up the output of \strong{OLD TECAN}
#' * Combines measurements from multiple kinetic runs into a single continuous dataframe by stacking the input dataframes in their original order.
#' * Adjusts cycle numbers and timestamps to maintain continuity across consecutive measurements
#' * Standardizes the column names of the original spreadsheet (`Cycle Nr.`, `Time [s]`, and `Temp. [°C]`).
#' @param measurements A \strong{list} of dataframes containing measurements from a series of kinetic cycles, ordered by measurement sequence.
#' @returns A dataframe containing the combined measurements, with column names labeled in all real numbers starting at 1.
#' The first two rows are are the standardized names (`Time [s]` and `Temp. [°C]`). Each following row is the original well ID 
#' @examples
#' data("OldTECAN_rawOutputList")
#' combined_OLD <- cleaner_OLDT(OldTECAN_rawOutputList)
#' str(combined_OLD)
#' @export

