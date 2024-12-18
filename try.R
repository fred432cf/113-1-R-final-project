library(tidyverse) 
library(lubridate)
library(dplyr)
survey1 <- read_csv("Taichung_City_112_Year_Top_10_Accident_Proned_Roads_1_to_12_Months.csv.csv")

survey1 <- survey1 %>% 
  select(-c(`縣市別代碼`,`市話`, A1, A2, A3))

survey1 <- survey1 %>%
  mutate(`年月` = as.character(`年月`)) %>%                     
  mutate(`年月` = str_replace_all(`年月`, "年", "-")) %>%       
  mutate(`年月` = str_replace_all(`年月`, "月", "")) %>%       
  mutate(`年月` = str_trim(`年月`)) %>%                      
  mutate(`年月` = ym(`年月`) + years(1911))   
