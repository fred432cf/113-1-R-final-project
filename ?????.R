library(tidyverse) 
survey <- read_csv("金融檢查執行情形.csv") 

glimpse(survey) 

tidy_survey1 <- survey %>% 
  rename(
    inspection_type = `檢查性質`,
    financial_industry = `金融業別`,
    year = `年度`,
    institution_count = `家數`
  )

glimpse(tidy_survey1)

