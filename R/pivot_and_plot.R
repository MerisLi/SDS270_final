#' @title Pivot longers combined dataframe 
#' @description
#' This function is designed to pivot longer the \strong{combined} dataframe so it can be easily plotted on a graph, with `Time [s]` as the x axis
#' and `OD` as the y axis
#' @param measurements Cleaned dataframe containing measurements from initial 1.5 hour growth and overnight growth
#' @returns A dataframe that has been pivoted longer, containing the combined measurements, with standardized 
#' column names (`Time_m`, `well_ID`, and `OD`)
#' @examples




#' @export


pivot_and_plot <- function(combined_df) {
  pivot_longer(cols = -c(1,2), names_to = "well_ID", values_to = "OD")
  
  
  
  combined_df <- combined_df |>
    mutate(Time_m=round(Time_s/60,1),
           Time_h=round(Time_m/60,1)) |>
    rename(Time_m = Time_s) |>
    group_by(Time_m, well_ID) |>
    summarise(OD_average = mean(OD))
  
  
  ggplot(combined_df, 
         aes(x = Time_m, y = OD_average, color = well_ID)) +
    geom_point() +
    scale_color_viridis_d(option = "turbo")
}