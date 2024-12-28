#根據交通部統計，台中市每年的交通事故數量在台灣各縣市中名列前茅，在近三年甚至都是第一名
#公共運輸系統不足:臺中捷運計畫有綠線、藍線、機場捷運、大平霧線、崇德豐原線、科工軸線、豐科軸線，
#另有綠線延伸至彰化、大坑，以及藍線延伸線等計畫，但是目前僅綠線已通車營運，其它路線皆尚在中央審核與規劃階段。
#公車也是其中一個原因:車系統雖免費但仍不便利：台中市的公車系統提供部分路線免費搭乘
#但班次密度與路線規劃未能滿足大眾需求，特別是在尖峰時段與偏遠地區
#再來是人口密度:市中心（如西屯區、北屯區、南屯區等）的密度較高，達到每平方公里 8,000-10,000人，超越台北市

library(tidyverse) 
library(lubridate)
library(dplyr)
survey <- read_csv("Taichung_City_112_Year_Top_10_Accident_Proned_Roads_1_to_12_Months.csv.csv")

survey <- survey %>% 
  select(-c(`縣市別代碼`,`市話`, `發生時間`, A1, A2, A3))
   
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
print(案件量_by_分局)

死亡人數_by_分局 <- survey %>%
  group_by(`轄區分局`) %>%
  summarise(`死亡人數` = sum(`死亡人數`, na.rm = TRUE)) %>%
  arrange(desc(`死亡人數`))
print(死亡人數_by_分局)

受傷人數_by_分局 <- survey %>%
  group_by(`轄區分局`) %>%
  summarise(`受傷人數` = sum(`受傷人數`, na.rm = TRUE)) %>%
  arrange(desc(`受傷人數`))
print(受傷人數_by_分局)

survey <- survey %>%
  mutate(`主要肇因` = factor(`主要肇因`, 
                       levels = c("倒車未依規定", "其他不當駕車行為", "其他引起事故之違規或不當行為", "尚未發現肇事因素", 
                                  "恍神、緊張、心不在焉分心駕駛", "未依規定讓車", "未保持行車安全距離", "未注意車前狀態",
                                  "無號誌路口，轉彎車未讓直行車先行", "變換車道不當", "變換車道或方向不當", 
                                  "違反(其他|特定)標誌(線)禁制", "違反號誌管制或指揮", "闖紅燈直行"), 
                       ordered = TRUE))

library(forcats)
survey <- survey %>%
  mutate(`主要肇因` = fct_explicit_na(`主要肇因`, na_level = "違反標誌(線)禁制"))

案件量_by_主要肇因 <- survey %>%
  group_by(`主要肇因`) %>%
  summarise(`總件數` = sum(`總件數`, na.rm = TRUE)) %>%
  arrange(desc(`總件數`))
print(案件量_by_主要肇因)

