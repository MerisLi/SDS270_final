#' @title Pivot longers combined dataframe 
#' @description
#' This function is designed to pivot longer the \strong{combined} dataframe so it can be easily plotted on a graph, with `Time [s]` as the x axis
#' and `OD` as the y axis.
#' @importFrom tidyr pivot_longer
#' @importFrom stats na.omit
#' @importFrom dplyr mutate group_by summarise 
#' @importFrom ggplot2 ggplot aes geom_point scale_color_viridis_d
#' @importFrom rlang .data
#' @param combined_df A combined dataframe containing measurements from initial 1.5 hour growth and overnight growth
#' @returns A dataframe that has been pivoted longer, containing the combined measurements, with standardized 
#' column names (`Time_m`, `well_ID`, and `OD`)
#' @export


pivot_and_plot <- function(combined_df) {
  tidyr::pivot_longer(names_to = "well_ID", values_to = "OD")
  
  combined_df <- combined_df |>
    stats::na.omit() |>
    dplyr::mutate(Time_m = round(.data$Time_s/60,1),
          Time_h = round(.data$Time_m/60,1)) |>
    rename(Time_m = .data$Time_s) |>
    dplyr::group_by(.data$Time_m, .data$well_ID) |>
    dplyr::summarise(OD_average = mean(.data$OD))
  
  
  ggplot2::ggplot(combined_df, 
         ggplot2::aes(x = .data$Time_m, y = .data$OD_average, color = .data$well_ID)) +
    ggplot2::geom_point() +
    ggplot2::scale_color_viridis_d(option = "turbo")
}