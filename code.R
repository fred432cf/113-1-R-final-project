library(tidyverse) 
library(lubridate)
library(dplyr)
survey <- read_csv("Taichung_City_112_Year_Top_10_Accident_Proned_Roads_1_to_12_Months.csv.csv")

survey <- survey %>% 
  select(-c(`縣市別代碼`,`市話`, 發生時間發生時間 A1, A2, A3))
   
survey <- survey %>%
  mutate(
    `年月` = str_remove_all(`年月`, "-$"),
    `年月` = str_trim(`年月`),
    `年月` = str_replace(`年月`, "^\\d{3}", ~ as.numeric(.x) + 1911),
    `年月` = ym(`年月`),
    `年月` = floor_date(`年月`, "month"),
    `年月` = format(`年月`, "%Y-%m")
  )

案件量_by_分局 <- survey %>%
  group_by(`轄區分局`) %>%
  summarise(`總件數` = sum(`總件數`, na.rm = TRUE)) %>%
  arrange(desc(`總件數`))

