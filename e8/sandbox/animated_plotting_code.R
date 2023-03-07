tar_load(agData)


agData %<>% 
 dplyr:: rename(value_tonnes = Value.1, 
         value_1000_ha = Value.2) %>% 
  mutate(Year = as.integer(Year))



# make a color palette
colpal <- colorRampPalette(colors = c("black","white","red","orange","yellow","green","blue","purple"))

# get some colors from your palette (one for each country)
cols <- colpal(29)


agData_plot <- ggplot(agData, aes(x = value_tonnes, y = value_1000_ha, col = Area, size = Value/100000, label = Area)) + 
  lims(x = c(0,450000000), y = c(0,200000)) + 
  scale_size(range = c(2, 20)) + 
  theme_gdocs() + 
  geom_point(pch = 20) + 
  scale_color_manual(values = cols) + 
  geom_text(hjust = 0, vjust = 0) +
  labs(title = 'Year: {frame_time}', x = 'Grain Production (tonnes)', y = 'Cropland Area (ha)') +
  transition_time(Year) 


animate(agData_plot, height = 10, width = 15, units = "in", res = 180)
