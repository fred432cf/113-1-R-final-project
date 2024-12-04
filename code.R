library(tidyverse) 
library(lubridate)
library(dplyr)
survey <- read_csv("Taichung_City_112_Year_Top_10_Accident_Proned_Roads_1_to_12_Months.csv.csv")

survey <- survey %>% 
  select(-c(`縣市別代碼`,`市話`, A1, A2, A3))

survey <- survey %>%
  mutate(`年月` = str_replace_all(`年月`, "[年月]", "-")) %>%  
  mutate(`年月` = str_remove_all(`年月`, "-$")) %>%             
  mutate(`年月` = ym(`年月`)) %>%                               
  mutate(`年月` = `年月` + years(1911))   

year_to_filter <- 2023
survey_filtered <- survey %>%
  filter(year(`發生日期`) == year_to_filter)

accident_summary <- survey_filtered %>%
  group_by(`轄區分局`) %>%
  summarize(`事故數量` = n(), .groups = "drop")

print(accident_summary)

