

library(tidyverse)
library(ggcorrplot)
library(corrplot)

team_results <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/team-results.csv')

heat <- heat %>% 
  select(c(YEAR, TEAM, POWER, PATH, DRAW, POOL.VALUE))

resumes <- resumes %>% 
  select(c(YEAR, TEAM, NET.RPI, RESUME, ELO, B.POWER, Q1.W, PLUS.500, R.SCORE))

ken <- full_join(ken, heat, by = c("TEAM", "YEAR"))
ken <- full_join(ken, resumes, by = c("TEAM", 'YEAR'))

ken <- ken %>% 
  mutate(FT = FT., .before = FT., .keep = "unused")

ken <- ken %>% 
  mutate(CHAMPION = 0, .before = K.TEMPO)

ken <- ken %>% 
  mutate(CHAMPION = if_else(YEAR %in% c('2008', '2022') & TEAM == "Kansas", 1, 
                            if_else(YEAR %in% c('2009', '2017') & TEAM == "North Carolina", 1,
                                    if_else(YEAR %in% c('2010', '2015') & TEAM == "Duke", 1,
                                            if_else(YEAR %in% c('2011', '2014', '2023') & TEAM == "Connecticut", 1,
                                                    if_else(YEAR == '2012' & TEAM == "Kentucky", 1,
                                                            if_else(YEAR == '2013' & TEAM == "Louisville", 1,
                                                                    if_else(YEAR %in% c('2016', '2018') & TEAM == "Villanova", 1,
                                                                            if_else(YEAR == '2019' & TEAM == "Virginia", 1,
                                                                                    if_else(YEAR == '2021' & TEAM == "Baylor", 1, 0))))))))))

ken_select <- ken %>% 
  select(YEAR, TEAM, SEED, ROUND, CHAMPION,
         KADJ.EM, K.TEMPO,
         BADJ.EM, BARTHAG, ELITE.SOS,
         AST., TALENT, PPPO, WAB,
         NET.RPI, RESUME, ELO, B.POWER,
         Q1.W, PLUS.500, R.SCORE,
         POWER, PATH)

ken_select <- ken_select %>% 
  mutate(WINS = as.numeric(recode(ROUND,
                                  "68" = "0",                         
                                  "64" = "0",
                                  "32" = "1",
                                  "16" = "2",
                                  "8"  = "3",
                                  "4"  = "4",
                                  "2"  = "5",
                                  "1"  = "6",
                                  "0"  = "0"), .before = 'CHAMPION'))

ken_select <- ken_select %>% 
  mutate(YEAR = as.factor(YEAR)) %>% 
  group_by(YEAR) %>% 
  mutate_at(vars(KADJ.EM:PATH), ~(scale(.) %>% as.vector)) %>% 
  ungroup()

ken_cor <- ken_select %>% 
  select(-c(YEAR, TEAM))

cor(ken_cor)

WINS_correlation <- lm(WINS ~
                       B.POWER + BADJ.EM +
                       R.SCORE + TALENT + WAB +
                       PATH + POWER, data = ken_cor)
summary(WINS_correlation)

ken_select$predicted <- predict(WINS_correlation, ken_select)

mm_lm_plot <- ken_select %>% 
  mutate(YEAR = as.numeric(YEAR)) %>% 
  filter(YEAR > 12 & YEAR < 24) %>% 
  ggplot(aes(x = predicted, y = WINS, color = as.factor(CHAMPION))) +
  geom_point(alpha = .5, shape = 4)+
  #geom_smooth(method = lm, se = F, color = "salmon",
  #         linetype = 2, linewidth = 0.5)+
  geom_vline(xintercept = 2, color = "blue", linetype = 2)+
  geom_hline(yintercept = 2, color = "blue", linetype = 2)+
  theme_classic()+
  theme(legend.position = "none",
        plot.title.position = "plot",
        plot.title = element_text(hjust = 0.575),
        axis.title.x = element_text(hjust = 0.55))+
  labs(title = "Predicting Tournament Wins
2013-2023", 
       x = "Predicted Wins", 
       y = "Actual Wins")

ggsave(
  "march_madness_lm_plot.png",
  mm_lm_plot,
  width = 7,
  height = 4
)

lm_2024 <- ken_select %>% 
  filter(YEAR == "2024") %>% 
  select(TEAM, SEED, WINS, predicted)

lm_2024 <- lm_2024 %>% 
  mutate(TEAM = recode(TEAM,
                       'Arizona' = "Zona",
                       'Auburn' = "AU",
                       'Baylor' = "BU",
                       'Connecticut' = "UConn",
                       'Creighton' = "CU",
                       'Houston' = "UH",
                       'Illinois' = "UI",
                       'Iowa St.' = "ISU",
                       'Marquette' = "MU",
                       'North Carolina' = "UNC",
                       'Purdue' = 'PU',
                       'Tennessee' = "UT",
                       'Kansas' = "KU",
                       'Gonzaga' = "Zaga",
                       'North Carolina St.' = "NCST",
                       'Alabama' = "Bama",
                       'San Diego St.' = "SDSU"))

picks_fills <- scale_fill_manual(values = c("UConn" = "#000e2f", 
                                            "UNC"   = "#7BAFD4",
                                            "PU"    = "#ceb888",
                                            "UH"    = "#C8102E",
                                            "ISU"   = "#F1BE48",
                                            "Zona"  = "#CC0033",
                                            "UT"    = "#FF8200",
                                            "MU"    = "#003366",
                                            "BU"    = "#154734",
                                            "UI"    = "#13294b",
                                            "CU"    = "#005ca9",
                                            "Duke"  = "#003087",
                                            "AU"    = "#0C2340",
                                            "Zaga"  = "#041E42",
                                            "KU"    = "#0051BA",
                                            "Bama"  = "#9e1b32",
                                            "Clemson" = "#F56600",
                                            "NCST" = "#CC0000",
                                            "SDSU" = "#a6192e"))

picks_colors <- scale_color_manual(values = c("UConn" = "#7C878E",
                                              "UNC" = "#13294B",
                                              "PU" = "#000000",
                                              "UH" = "#000000",
                                              "ISU" = "#C8102E",
                                              "Zona" = "#003366",
                                              "UT" = "#4B4B4B",
                                              "MU" = "#ffcc00",
                                              "BU" = "#FFB81C",
                                              "UI" = "#E84A27",
                                              "CU" = "#00235D",
                                              "Duke" = "#000000",
                                              "AU" = "#E87722",
                                              "Zaga" = "#C8102E",
                                              "KU" = "#E8000D",
                                              "Bama" = "#828a8f",
                                              "Clemson" = "#522D80",
                                              "NCST" = "#000000",
                                              "SDSU" = "#000000"))

lm_2024 <- lm_2024 %>% 
  mutate(WINS = as.numeric(if_else(TEAM %in% c('KU', 'BU'), "1",
                                   if_else(TEAM %in% c('UH', 'ISU', 'Zona', 'UNC', 'MU', 'CU', 'Zaga', 'SDSU'), "2",
                                           if_else(TEAM %in% c('UT', 'UI', 'Duke', 'Clemson'), "3",
                                                   if_else(TEAM %in% c('Bama', 'NCST'), "4",
                                                           if_else(TEAM == 'PU', "5",
                                                                   if_else(TEAM == "UConn", "6", ""))))))))


mm_2024_lm_plot <- lm_2024 %>% 
  filter(WINS > 1) %>% 
  ggplot(aes(WINS, reorder(TEAM, WINS))) +
  geom_bar(aes(fill = TEAM, color = TEAM), stat = "identity")+
  theme_classic()+
  theme(legend.position = "none",
        plot.title.position = "plot",
        plot.title = element_text(hjust = 0.59))+
  scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5, 6),
                     labels = c("R64","R32", "S16", "E8", "F4", "Runner-Up", "Champ"))+
  labs(title = "2024 Sweet Sixteen Teams
Predicted Wins",
       x = "Round Reached",
       y = "")+
  geom_label(aes(label = round(predicted, 2)))+
  picks_fills+
  picks_colors

ggsave(
  "mm_2024_lm_plot.png",
  mm_2024_lm_plot,
  width = 7,
  height = 4
)


ken_select <- ken_select %>% 
  mutate(DIFF =round(WINS - predicted, 2))

expect <- ken_select %>% 
  filter(YEAR != 2024) %>% 
  group_by(TEAM) %>% 
  summarize(avg_DIFF = round(mean(DIFF), 2), n = n()) %>% 
  filter(n >1)

expect %>% 
  filter(avg_DIFF >0.62) %>% 
  ggplot(aes(reorder(TEAM, desc(avg_DIFF)), avg_DIFF, 2))+
  geom_bar(aes(fill = TEAM), stat = "identity")+
  labs(x = "TEAM")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

library(magick)
library(magrittr)

blank_page <- image_blank(
  width = 5*300,
  height = 5*300,
  color = "white"
)

lm_image <- image_read("march_madness_lm_plot.png")
lm_2024_image <- image_read("mm_2024_lm_plot.png")


Jordan_logo <- image_read("https://th.bing.com/th/id/OIP.aVHJ5oWbbG9GeH47wfbb2QHaEK?w=324&h=182&c=7&r=0&o=5&pid=1.7")
mm_logo <- image_read("https://preview.redd.it/2024-final-four-logo-revealed-today-v0-pwyd4zujdd4a1.jpg?auto=webp&s=d7e4c2afaeaa27325978b885197c12b7e88e2c1e")

model_report <- blank_page %>% 
  image_scale("1000") %>% 
  image_composite(
    image_scale(Jordan_logo, "150x"), offset = "+0+10"
  ) %>% 
  image_composite(
    image_scale(mm_logo, "100x"), offset = "+900"
  ) %>% 
  image_annotate(
    text = "NCAA March Madness Data",
    gravity = "north",
    location = "+0+20",
    size = 40,
    font = "Palatino"
  ) %>% 
  image_annotate(
    text = "Barttorvik Data from 2008-2024",
    gravity = "north",
    location = "+0+65",
    size = 20,
    font = "Palatino"
  ) %>% 
  image_composite(
    image_scale(lm_image, "700"), offset = "+0+150"
  ) %>% 
  image_annotate(
    text = "FDU(2023)",
    location = "+50+425",
    size = 10,
    font = "Helvetica",
  ) %>% 
  #image_annotate(
   # text = "UConn(2014)",
    #location = "+270+195",
    #size = 10,
    #font = "Helvetica",
  #) %>% 
  image_annotate(
    text = "R-Squared 0.3667",
    gravity = "north",
    location = "+350+450",
    size = 20,
    font = "Helvetica",
    boxcolor = "#FDF9D8",
    color = "#841617"
  ) %>% 
  image_annotate(
    text = "Actual Wins Range:
0-6\n
Predicted Wins Range:
-0.60-4.13",
    gravity = "north",
    location = "+350+275",
    size = 20,
    font = "Helvetica",
    boxcolor = "#FDF9D8",
    color = "#841617"
  ) %>% 
  image_annotate(
    text = "Champions in Blue",
    gravity = "north",
    location = "+350+200",
    size = 20,
    font = "Helvetica",
    boxcolor = "#FDF9D8",
    color = "#5DE2E7"
  ) %>% 
  #image_annotate(
   # text = "Cinderellas",
    #gravity = "north",
    #location = "-250+210",
    #size = 20,
    #font = "Helvetica"
  #) %>% 
  image_annotate(
    text = "Underachievers",
    gravity = "north",
    location = "+100+445",
    size = 20,
    font = "Helvetica"
  ) %>% 
  image_annotate(
    text = "UVA(2018)",
    gravity = "north",
    location = "+40+470",
    size = 10,
    font = "Helvetica",
  ) %>% 
  image_annotate(
    text = "KU(2010)",
    gravity = "north",
    location = "+70+425",
    size = 10,
    font = "Helvetica",
  ) %>%
  image_annotate(
    text = "Zaga(2021)",
    gravity = "north",
    location = "+165+240",
    size = 10,
    font = "Helvetica",
  ) %>%
  image_composite(
    image_scale(lm_2024_image, "700"), offset = "+0+600"
  ) %>% 
  image_annotate(
    text = "#1 Seeds: UConn, Purdue,
UNC, Houston\n
NC State, Alabama, San Diego St.
& Clemson Significantly
Outperformed Expectations\n
Houston Significantly
Underperformed Expectations\n
Auburn (2.12) & UK (1.25)
Both First-Round Exits
(not listed)",
    gravity = "south",
    location = "+350+30",
    size = 20,
    font = "Helvetica",
    boxcolor = "#841617",
    color = "#FDF9D8"
  )

image_write(model_report,
            path = "mm_model_report.pdf",
            format = "pdf")

