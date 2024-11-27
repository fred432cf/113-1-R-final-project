library(tidyverse) 
survey <- read_csv("2021_01_10570-00-01-2_Taichung_City_Government_Medical_Expenditure.csv") 

glimpse(survey) 

tidy_survey1 <- survey %>% 
  rename(
    inspection_type = `檢查性質`,
    financial_industry = `金融業別`,
    year = `年度`,
    institution_count = `家數`
  )

glimpse(tidy_survey1)


