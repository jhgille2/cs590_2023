#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param agData
make_agData_plot <- function(agData) {

  agData %<>% 
    dplyr:: rename(value_tonnes = Value.1, 
                   value_1000_ha = Value.2) %>% 
    mutate(Year = as.integer(Year))
  
  
  
  # make a color palette
  colpal <- colorRampPalette(colors = c("black","white","red","orange","yellow","green","blue","purple"))
  
  # get some colors from your palette (one for each country)
  cols <- colpal(29)
  
  # Make the animated plot
  agData_plot <- ggplot(agData, aes(x = value_tonnes, y = value_1000_ha, col = Area, size = Value/100000, label = Area)) + 
    lims(x = c(0,450000000), y = c(0,200000)) + 
    scale_size(range = c(2, 20)) + 
    theme_hc() + 
    geom_point(pch = 20) + 
    scale_color_manual(values = cols) + 
    geom_text(hjust = 0, vjust = 0) +
    labs(title = 'Year: {frame_time}', x = 'Grain Production (tonnes)', y = 'Cropland Area (ha)') +
    transition_time(Year) + 
    ease_aes("linear")
  
  # Save the plot
  outpath <- here("export", "agData.gif")
  anim_save(outpath, 
            agData_plot, 
            height = 10, 
            width = 15, 
            units = "in", 
            res = 100, 
            duration = 30)
  
  return(outpath)
}
