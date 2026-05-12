# Libraries ####
library(dplyr)
library(readr)
library(tidyr)
library(rvest)
library(stringr)
library(uuid)
library(yardstick)
library(tidymodels)
library(modelsummary)
library(gtExtras)
library(purrr)


`%!in%` <- Negate(`%in%`)

options(readr.show_col_types = FALSE)
options(dplyr.summarise.inform = FALSE)

# Roster Data ####
# Vanderbilt
url <- "https://vucommodores.com/sports/wsoc/roster/season/2025-26/"
webpage <- read_html(url)

vandy2025 <- webpage %>%
  html_element(xpath = '//*[@id="players-table"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Vanderbilt",year="2025") 

url <- "https://vucommodores.com/sports/wsoc/roster/season/2024-25/"
webpage <- read_html(url)

vandy2024 <- webpage %>%
  html_element(xpath = '//*[@id="players-table"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Vanderbilt",year="2024")  

url <- "https://vucommodores.com/sports/wsoc/roster/season/2023-24/"
webpage <- read_html(url)

vandy2023 <- webpage %>%
  html_element(xpath = '//*[@id="players-table"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Vanderbilt",year="2023") 


# Texas A&M
url <- "https://12thman.com/sports/womens-soccer/roster/2025"
webpage <- read_html(url)

tamu2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Texas A&M",year="2025") 

url <- "https://12thman.com/sports/womens-soccer/roster/2024"

webpage <- read_html(url)

tamu2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Texas A&M",year="2024") 

url <- "https://12thman.com/sports/womens-soccer/roster/2023"

webpage <- read_html(url)

tamu2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Texas A&M",year="2023") 

# Texas
url <- "https://texaslonghorns.com/sports/womens-soccer/roster/2025"

webpage <- read_html(url)

texas2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Texas",year="2025") 

url <- "https://texaslonghorns.com/sports/womens-soccer/roster/2024"

webpage <- read_html(url)

texas2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Texas",year="2024") 

# 2023 data for Texas was not included as they were not in the SEC until 2024


# Tennessee
url <- "https://utsports.com/sports/womens-soccer/roster/2023"

webpage <- read_html(url)

tennessee2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Tennessee",year="2023") 

url <- "https://utsports.com/sports/womens-soccer/roster/2024"

webpage <- read_html(url)

tennessee2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Tennessee",year="2024") 

url <- "https://utsports.com/sports/womens-soccer/roster/2025"

webpage <- read_html(url)

tennessee2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Tennessee",year="2025") 


# South Carolina
url <- "https://gamecocksonline.com/sports/wsoc/roster/season/2025/"

webpage <- read_html(url)

usc2025 <- webpage %>%
  html_element(xpath = '//*[@id="players-table"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="South Carolina",year="2025") 

url <- "https://gamecocksonline.com/sports/wsoc/roster/season/2024/"

webpage <- read_html(url)

usc2024 <- webpage %>%
  html_element(xpath = '//*[@id="players-table"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="South Carolina",year="2024") 

url <- "https://gamecocksonline.com/sports/wsoc/roster/season/2023/"

webpage <- read_html(url)

usc2023 <- webpage %>%
  html_element(xpath = '//*[@id="players-table"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="South Carolina",year="2023") 

# Oklahoma
url <- "https://soonersports.com/sports/soccer/roster/2025"

webpage <- read_html(url)

oklahoma2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Oklahoma",year="2025") 

url <- "https://soonersports.com/sports/soccer/roster/2024"

webpage <- read_html(url)

oklahoma2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Oklahoma",year="2024") 

# 2023 data for Oklahoma was not included as they were not in the SEC until 2024


# Mizzou
url <- "https://mutigers.com/sports/womens-soccer/roster/2025"

webpage <- read_html(url)

missouri2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Missouri",year="2025") 

url <- "https://mutigers.com/sports/womens-soccer/roster/2024"

webpage <- read_html(url)

missouri2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Missouri",year="2024")

url <- "https://mutigers.com/sports/womens-soccer/roster/2023"

webpage <- read_html(url)

missouri2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Missouri",year="2023")

# Miss St
url <- "https://hailstate.com/sports/womens-soccer/roster/2025"
webpage <- read_html(url)

missSt2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Mississippi St.",year="2025")

url <- "https://hailstate.com/sports/womens-soccer/roster/2024"
webpage <- read_html(url)

missSt2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Mississippi St.",year="2024")

url <- "https://hailstate.com/sports/womens-soccer/roster/2023"
webpage <- read_html(url)

missSt2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Mississippi St.",year="2023")

# Ole Miss
url <- "https://olemisssports.com/sports/womens-soccer/roster/2025"
webpage <- read_html(url)

oleMiss2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad" & pos%in%c("GK","D","MF","F","D/MF")) %>% 
  mutate(team="Ole Miss",year="2025")

url <- "https://olemisssports.com/sports/womens-soccer/roster/2024"
webpage <- read_html(url)

oleMiss2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad" & pos%in%c("GK","D","MF","F","D/MF")) %>% 
  mutate(team="Ole Miss",year="2024")

url <- "https://olemisssports.com/sports/womens-soccer/roster/2023"
webpage <- read_html(url)

oleMiss2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]') %>%
  html_table() %>% 
  select(name=Name, pos=`Pos.`) %>% 
  filter(name!="Skip Ad" & pos%in%c("GK","D","MF","F","D/MF")) %>% 
  mutate(team="Ole Miss",year="2023")

# LSU
url <- "https://lsusports.net/sports/sc/roster/season/2025/"

webpage <- read_html(url)

lsu2025 <- webpage %>%
  html_element(xpath = '//*[@id="players-table_wrapper"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="LSU",year="2025") 

url <- "https://lsusports.net/sports/sc/roster/season/2024/"

webpage <- read_html(url)

lsu2024 <- webpage %>%
  html_element(xpath = '//*[@id="players-table_wrapper"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="LSU",year="2024") 

url <- "https://lsusports.net/sports/sc/roster/season/2023/"

webpage <- read_html(url)

lsu2023 <- webpage %>%
  html_element(xpath = '//*[@id="players-table_wrapper"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="LSU",year="2023") 

# Kentucky
url <- "https://ukathletics.com/sports/wsoc/roster/season/2025/"
webpage <- read_html(url)

kentucky2025 <- webpage %>%
  html_element(xpath = '//*[@id="players-table_wrapper__general"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Kentucky",year="2025") 

url <- "https://ukathletics.com/sports/wsoc/roster/season/2024/"
webpage <- read_html(url)

kentucky2024 <- webpage %>%
  html_element(xpath = '//*[@id="players-table_wrapper__general"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Kentucky",year="2024") 

url <- "https://ukathletics.com/sports/wsoc/roster/season/2023/"
webpage <- read_html(url)

kentucky2023 <- webpage %>%
  html_element(xpath = '//*[@id="players-table_wrapper__general"]') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Kentucky",year="2023") 

# Georgia
url <- "https://georgiadogs.com/sports/womens-soccer/roster/2025"
webpage <- read_html(url)

georgia2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Georgia",year="2025") 

url <- "https://georgiadogs.com/sports/womens-soccer/roster/2024"
webpage <- read_html(url)

georgia2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Georgia",year="2024") 

url <- "https://georgiadogs.com/sports/womens-soccer/roster/2023"
webpage <- read_html(url)

georgia2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Georgia",year="2023") 

# Florida
url <- "https://floridagators.com/sports/womens-soccer/roster/2025"
webpage <- read_html(url)

florida2025 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]/div') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Florida",year="2025") 

url <- "https://floridagators.com/sports/womens-soccer/roster/2024"
webpage <- read_html(url)

florida2024 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]/div') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Florida",year="2024") 

url <- "https://floridagators.com/sports/womens-soccer/roster/2023"
webpage <- read_html(url)

florida2023 <- webpage %>%
  html_element(xpath = '//*[@id="tablePanel"]/div[1]/div') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Florida",year="2023") 

# Auburn
url <- "https://auburntigers.com/sports/soccer/roster/season/2025?view=table"
webpage <- read_html(url)

auburn2025 <- webpage %>%
  html_element(xpath = '//*[@id="players"]/div/div/div') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Auburn",year="2025") 

url <- "https://auburntigers.com/sports/soccer/roster/season/2024?view=table"
webpage <- read_html(url)

auburn2024 <- webpage %>%
  html_element(xpath = '//*[@id="players"]/div/div/div') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Auburn",year="2024") 

url <- "https://auburntigers.com/sports/soccer/roster/season/2023?view=table"
webpage <- read_html(url)

auburn2023 <- webpage %>%
  html_element(xpath = '//*[@id="players"]/div/div/div') %>%
  html_table() %>% 
  select(name=Name, pos=Position) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Auburn",year="2023") 

# Arkansas
url <- "https://arkansasrazorbacks.com/sport/w-soccer/roster/?season=2025-26"
webpage <- read_html(url)

arkansas2025 <- webpage %>%
  html_element(xpath = '//*[@id="roster"]/div/div') %>%
  html_table() %>% 
  select(name=Name, pos=Pos) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Arkansas",year="2025") 

url <- "https://arkansasrazorbacks.com/sport/w-soccer/roster/?season=2024-25"
webpage <- read_html(url)

arkansas2024 <- webpage %>%
  html_element(xpath = '//*[@id="roster"]/div/div') %>%
  html_table() %>% 
  select(name=Name, pos=Pos) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Arkansas",year="2024") 

url <- "https://arkansasrazorbacks.com/sport/w-soccer/roster/?season=2023-24"
webpage <- read_html(url)

arkansas2023 <- webpage %>%
  html_element(xpath = '//*[@id="roster"]/div/div') %>%
  html_table() %>% 
  select(name=Name, pos=Pos) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Arkansas",year="2023") 

# Alabama
url <- "https://rolltide.com/sports/womens-soccer/roster/2025"
webpage <- read_html(url)

alabama2025 <- webpage %>% 
  html_element(xpath = '//*[@id="tablePanel"]/div[1]/div') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Alabama",year="2025") 

url <- "https://rolltide.com/sports/womens-soccer/roster/2024"
webpage <- read_html(url)

alabama2024 <- webpage %>% 
  html_element(xpath = '//*[@id="tablePanel"]/div[1]/div') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Alabama",year="2024") 

url <- "https://rolltide.com/sports/womens-soccer/roster/2023"
webpage <- read_html(url)

alabama2023 <- webpage %>% 
  html_element(xpath = '//*[@id="tablePanel"]/div[1]/div') %>%
  html_table() %>% 
  select(name=`Full Name`, pos=`Pos.`) %>% 
  filter(name!="Skip Ad") %>% 
  mutate(team="Alabama",year="2023")


# Final roster compilation
sec <- bind_rows(alabama2023,alabama2024,alabama2025, 
                 arkansas2023,arkansas2024,arkansas2025,
                 auburn2023,auburn2024,auburn2025,
                 florida2023,florida2024,florida2025,
                 georgia2023,georgia2024,georgia2025,
                 kentucky2023,kentucky2024,kentucky2025,
                 lsu2023,lsu2024,lsu2025,
                 missouri2023,missouri2024,missouri2025,
                 missSt2023,missSt2024,missSt2025,
                 oklahoma2024,oklahoma2025,
                 oleMiss2023,oleMiss2024,oleMiss2025,
                 tamu2023,tamu2024,tamu2025,
                 tennessee2023,tennessee2024,tennessee2025,
                 texas2024,texas2025,
                 usc2023,usc2024,usc2025,
                 vandy2023,vandy2024,vandy2025)

sec$year <- as.numeric(sec$year)

# Namekey ####

# Create unique id for each athlete
nameKey <- sec %>% 
  distinct(name,team,year) %>% 
  mutate(fullName=name,
         abbr=paste0(str_sub(word(name,1),1,1),
                     ". ",
                     word(name, -1)),
         id=UUIDgenerate(n=n())) %>% 
  select(fullName,team,year,abbr,id)

# Count number of duplicate abbreviaitons
nameKey %>%
  count(abbr, team, year, sort = TRUE) %>%
  filter(n > 1)

# Create unique abbreviations 
nameKey <- nameKey %>% 
  mutate(abbr=case_when(fullName=="Macy Matula"~"Mac. Matula",
                        fullName=="Margo Matula"~"Mar. Matula",
                        fullName=="Ashley Tutas"~"Ash. Tutas",
                        fullName=="Alyssa Tutas"~"Aly. Tutas",
                        fullName=="Skylar Miller"~"Sky. Miller",
                        fullName=="Sydney Miller"~"Syd. Miller",
                        fullName=="Bella Scaturro Bright"~"B. Scaturro",
                        fullName=="LJ Knox"~"LJ. Knox",
                        fullName=="Aitana Martinez-Montoya"~"A. Martinez Montoya",
                        TRUE ~ abbr))
# Count number of duplicate abbreviaitons again (should be zero)
nameKey %>%
  count(abbr, team, year, sort = TRUE) %>%
  filter(n > 1)

# Wyscout ####
att23 <- read_csv("att23.csv") %>% 
  mutate(year=as.numeric(2023),,.before=Goals)

att24 <- read_csv("att24.csv") %>% 
  mutate(year=as.numeric(2024),,.before=Goals)

att25 <- read_csv("att25.csv") %>% 
  mutate(year=as.numeric(2025),,.before=Goals)

att <- bind_rows(att23,att24,att25)

def23 <- read_csv("def23.csv") %>% 
  mutate(year=as.numeric(2023),.before=DefDuels_per90)

def24 <- read_csv("def24.csv") %>% 
  mutate(year=as.numeric(2024),.before=DefDuels_per90)

def25 <- read_csv("def25.csv") %>% 
  mutate(year=as.numeric(2025),.before=DefDuels_per90)

def <- bind_rows(def23,def24,def25)

wyscout <- bind_rows(att23,att24,att25,
                     def23,def24,def25)

wyscout <- wyscout %>%
  mutate(
    Team=as.character(Team),
    Team = word(Team, 1, -2),
    Team=case_when(Team=="Alabama Crimson"~"Alabama", # Fix naming of Alabama
                   TRUE ~ Team),
    Name=case_when(Name=="M. Mckenzie"~"M. McKenzie",
                   Name=="M. Matula"~"Mar. Matula", # Differentiate between two players with the same first
                   # initial and last name on the same team
                   TRUE ~ Name)
  )

# All-SEC Awards ####
awards23 <- read_csv("awards23.csv") %>% 
  mutate(year=2023,.before=FirstTeamAllSEC)

awards24 <- read_csv("awards24.csv") %>% 
  mutate(year=2024,.before=FirstTeamAllSEC)

awards25 <- read_csv("awards25.csv") %>% 
  mutate(year=2025,.before=FirstTeamAllSEC)

awards <- bind_rows(awards23,awards24,awards25) %>% 
  mutate(Team=case_when(Team=="Mississippi State"~"Mississippi St.", # Fic naming of Mississippi St.
                        TRUE ~ Team))

# Final dataset ####
finalData <- left_join(wyscout,awards,by=c("Name","Team","year")) %>% 
  select(Name,year,Team,Goals_per90,Assists_per90,Shots_per90,KeyPasses_per90,TouchesBox_per90,
         DefDuels_per90:AllFreshmanTeam) %>% 
  rename(name=Name,
         team=Team,
         goalsPer90=Goals_per90,assistsPer90=Assists_per90,shotsPer90=Shots_per90,keyPassesPer90=KeyPasses_per90,touchesBoxPer90=TouchesBox_per90,
         defDuelsPer90=DefDuels_per90,aerialDuelsPer90=AerialDuels_per90,recoveriesPer90=Recoveries_per90,interceptionsPer90=Interceptions_per90,slidingTacklesPer90=SlidingTackles_per90,shotsBlockedPer90=ShotsBlocked_per90,
         firstTeamAllSEC=FirstTeamAllSEC,secondTeamAllSEC=SecondTeamAllSEC,thirdTeamAllSEC=ThirdTeamAllSEC,allFreshmanTeam=AllFreshmanTeam)

# Add unique id column from nameKey
secData <- sec %>% left_join(nameKey,by=c("name"="fullName","team","year")) %>%
  left_join(finalData,by=c("abbr"="name","team","year"))


# Create a summary table of the number of missing values for each variable
createMissingValuesTable <- function() {
  colSums(is.na(secData))  %>% tidy() %>% filter(x>1) %>% 
    gt(rowname_col = "names") %>% 
    tab_style(style = cell_text(align = "center"),
              locations = cells_stub()) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_body(columns = everything())) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(
      style = cell_borders(
        sides = c("left", "right"),
        weight = px(0.2)
      ),
      locations = cells_body(columns = everything())
    ) %>%
    cols_width(names ~ px(350),
               everything()~px(200)) %>%
    cols_label(x="N") %>% 
    tab_options(
      heading.title.font.size = 36,
      heading.subtitle.font.size = 40,
      table.border.top.color = "white",
      table_body.vlines.style = "solid",
      table_body.vlines.color = "black",
      table_body.vlines.width = 1,
      table.font.size = 28,
      data_row.padding = px(2),
      # change based on 1 or 2-page req.
      heading.background.color = "black",
      column_labels.background.color = "#841617",
      table.border.bottom.color = "black",
      table_body.border.bottom.color = "black",
      table.border.bottom.width = 1,
      table_body.border.bottom.width = 1,
      container.width = 970
    ) %>%
    tab_header(title = "Missing Values") %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Inter Tight"),
          default_fonts()
        )
      ),
      locations = list(cells_title(), cells_body(),
                       cells_column_labels())) %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Noto Sans Mono"),
          default_fonts()
        )
      ),
      locations = cells_body(columns=everything())) %>% 
    tab_style(style = cell_text(align = "center", weight="bold",
                                size="smaller",transform = "uppercase"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(style = cell_text(weight = "bold"),
              locations = cells_title(groups = "title"))
}

createMissingValuesTable()

# Data preprocessing
secData2 <- secData %>% 
  mutate(across(c(goalsPer90:shotsBlockedPer90),
                ~replace_na(.,0))) %>%           # Replace na values with 0
  mutate(across(c(firstTeamAllSEC:allFreshmanTeam),
                ~replace_na(.,0))) %>% 
  select(year,everything()) %>% 
  mutate(across(c(goalsPer90:shotsBlockedPer90), # Replace continous data with 1
                ~if_else(.>0,1,0))) %>% 
  mutate(award=case_when(
    firstTeamAllSEC==1|secondTeamAllSEC==1|thirdTeamAllSEC==1|allFreshmanTeam==1 ~ 1,
    TRUE ~ 0),
    allSEC=case_when(
      firstTeamAllSEC==1|secondTeamAllSEC==1|thirdTeamAllSEC==1 ~ 1, # Convert All-SEC teams into one variable: allSEC
      TRUE ~ 0)
  ) %>% 
  mutate(pos=case_when(
    pos %in%c("CF","F","Forward","FORWARD") ~ "F",
    pos %in%c("M","MF","Midfielder","Midfield") ~ "M",            # Convert positions into five distinct positions
    pos %in%c("D","CB","DEFENDER","Defender","Defense") ~ "D",
    pos %in%c("D/MF","F/M","F/MF","D/F","D/M","F/D","M/D","M/F","MF/D","MF/F","Midfield/Defender","Midfield/Forward","Midfielder/Forward","Forward/Midfield","Forward/Midfielder","Midfielder/Defender","DEFENDER/MIDFIELDER","Defender/Forward","Defender/Midfielder","Forward/Defender","Foward/Defender") ~ "Multiple",
    pos %in%c("GK","Goalkeeper","GOALKEEPER") ~ "GK",
    TRUE ~ pos
  )) %>% 
  mutate(across(c(year,team,pos,award,allSEC),as.factor)) # Prepare data for modeling

performance <- secData2 %>% 
  filter(pos!="GK") %>% 
  mutate(pos=droplevels(pos)) %>% 
  select(allSEC,id,year,team,pos,goalsPer90,assistsPer90,shotsPer90,keyPassesPer90,touchesBoxPer90,
         defDuelsPer90,aerialDuelsPer90,recoveriesPer90,interceptionsPer90,slidingTacklesPer90,shotsBlockedPer90)

# Summary table of the number of All-SEC selections by position
createPosBreakdownTable <- function() {
  posBreakdown <- performance %>% 
    group_by(pos) %>% 
    summarize(n=n(),
              allSEC=sum(allSEC==1,na.rm=T)) %>% 
    ungroup() %>% 
    bind_rows(summarize(.,pos="Total",n=sum(n),allSEC=sum(allSEC))) %>% 
    arrange(-n) %>% 
    gt(rowname_col = "pos") %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_stub()) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_body(columns = everything())) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(
      style = cell_borders(
        sides = c("left", "right"),
        weight = px(0.2)
      ),
      locations = cells_body(columns = everything())
    ) %>%
    cols_width(pos ~ px(350),
               everything()~px(200)) %>%
    tab_options(
      heading.title.font.size = 36,
      heading.subtitle.font.size = 40,
      table.border.top.color = "white",
      table_body.vlines.style = "solid",
      table_body.vlines.color = "black",
      table_body.vlines.width = 1,
      table.font.size = 28,
      data_row.padding = px(2),
      # change based on 1 or 2-page req.
      heading.background.color = "black",
      column_labels.background.color = "#841617",
      table.border.bottom.color = "black",
      table_body.border.bottom.color = "black",
      table.border.bottom.width = 1,
      table_body.border.bottom.width = 1,
      container.width = 970
    ) %>%
    tab_header(title = "Positional Breakdown") %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Inter Tight"),
          default_fonts()
        )
      ),
      locations = list(cells_title(), cells_body(),
                       cells_column_labels())) %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Noto Sans Mono"),
          default_fonts()
        )
      ),
      locations = cells_body(columns=everything())) %>% 
    tab_style(style = cell_text(align = "center", weight="bold",
                                size="smaller",transform = "uppercase"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(style = cell_text(weight = "bold"),
              locations = cells_title(groups = "title"))
  
  posBreakdown
  
}

createPosBreakdownTable()


createDataOverviewTable <- function() {
  glimpse_gt <- tibble(
    Variable = names(performance),
    Details = map_chr(performance,
                      ~ paste0(
                        "<",
                        class(.x)[1],
                        "> ",
                        str_trunc(
                          paste(head(.x, 5), collapse = ", "),
                          width = 40))))
  
  dataOverviewTable <- glimpse_gt %>% 
    gt(rowname_col = "Variable") %>% 
    tab_style(style = cell_text(align = "center"),
              locations = cells_stub()) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_body(columns = everything())) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(
      style = cell_borders(
        sides = c("left", "right"),
        weight = px(0.2)
      ),
      locations = cells_body(columns = everything())
    ) %>%
    cols_width(Variable ~ px(300)) %>%
    tab_options(
      heading.title.font.size = 18,
      heading.subtitle.font.size = 40,
      table.border.top.color = "white",
      table_body.vlines.style = "solid",
      table_body.vlines.color = "black",
      table_body.vlines.width = 1,
      table.font.size = 14,
      data_row.padding = px(2),
      # change based on 1 or 2-page req.
      heading.background.color = "black",
      column_labels.background.color = "#841617",
      table.border.bottom.color = "black",
      table_body.border.bottom.color = "black",
      table.border.bottom.width = 1,
      table_body.border.bottom.width = 1,
      container.width = 970
    ) %>%
    tab_header(title = "Data Overview") %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Inter Tight"),
          default_fonts()
        )
      ),
      locations = list(cells_title(), cells_body(),
                       cells_column_labels())) %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Noto Sans Mono"),
          default_fonts()
        )
      ),
      locations = cells_body(columns=everything())) %>% 
    tab_style(style = cell_text(align = "center", weight="bold",
                                size="smaller",transform = "uppercase"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(style = cell_text(weight = "bold"),
              locations = cells_title(groups = "title"))
  
  dataOverviewTable
  
}

createDataOverviewTable()

# tidy models ####
set.seed(100)
performance_split <- initial_split(performance, prop = 0.8)
performance_train <- training(performance_split)
performance_test  <- testing(performance_split)





# logistic regression ####
print('Starting LOGIT')
# set up the task and the engine
tune_logit_spec <- logistic_reg(
  penalty = tune(), # tuning parameter
  mixture =  tune()    # 1 = lasso, 0 = ridge
) %>% 
  set_engine("glmnet") %>%
  set_mode("classification")

# define a grid over which to try different values of the regularization parameter lambda
lambda_grid <- grid_regular(penalty(),mixture(),levels=c(penalty=50,mixture=5))

# 5-fold cross-validation
rec_folds <- vfold_cv(performance_train, v = 5, strata = allSEC)

# Workflow
rec_wf <- workflow() %>%
  add_model(tune_logit_spec) %>%
  add_formula(allSEC ~ year+pos+goalsPer90+assistsPer90+shotsPer90+keyPassesPer90+touchesBoxPer90+
                defDuelsPer90+aerialDuelsPer90+recoveriesPer90+interceptionsPer90+slidingTacklesPer90+shotsBlockedPer90)

# Tuning results
rec_res <- rec_wf %>%
  tune_grid(
    resamples = rec_folds,
    grid = lambda_grid,
    metrics = metric_set(roc_auc,sens,spec,accuracy,kap)
  )

# what is the best value of lambda?
top_kap  <- show_best(rec_res, metric = "kap")
best_kap <- select_best(rec_res, metric = "kap")

final_logit_lasso <- finalize_workflow(
  rec_wf,
  best_kap
)


print('*********** LOGISTIC REGRESSION **************')
logit_test <- last_fit(final_logit_lasso,performance_split) %>%
  collect_metrics()

final_fit <- final_logit_lasso %>%
  fit(data = performance_train)

# Function for showing most influential variables
createCoefTable <- function() {
  
  coef_table <- final_fit %>%
    extract_fit_parsnip() %>%
    tidy()
  
  coef_table %>%
    mutate(
      odds_ratio = exp(estimate)
    ) %>%
    filter(term != "(Intercept)") %>%
    arrange(desc(odds_ratio)) %>%
    slice_head(n = 10) %>%
    ggplot(aes(
      x = reorder(term, odds_ratio),
      y = odds_ratio
    )) +
    geom_col() +
    coord_flip() +
    labs(
      title = "Top Odds Ratios in All-SEC Model",
      x = "",
      y = "Odds Ratio"
    ) +
    geom_text(
      aes(label = round(odds_ratio, 2)),
      hjust = -0.1,
      size = 3
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        face = "bold"
      ),
      axis.text.y = element_text(face = "bold")
    )
}

createCoefTable()


# Create prediction table on out-of-sample data
pred_table <- performance_test %>%
  select(year, allSEC) %>%
  bind_cols(
    predict(final_fit, performance_test),
    predict(final_fit, performance_test, type = "prob")
  )

# Show metrics 
metrics(pred_table,
        truth = allSEC,
        estimate = .pred_class)

# Sensitivity
sens(pred_table,
     truth = allSEC,
     estimate = .pred_class,
     event_level = "second")

# Specificity
spec(pred_table,
     truth = allSEC,
     estimate = .pred_class,
     event_level = "second")

# ROC_AUC
roc_auc(pred_table,
        truth = allSEC,
        .pred_1,
        event_level="second")

# Confusion matrix
conf_mat(pred_table,
         truth = allSEC,
         estimate = .pred_class)





# Determine appropriate cut-off for pred class
thresholds <- seq(0.10, 0.90, by = 0.01)

kappa_by_threshold <- map_dfr(thresholds, function(thresh) {
  pred_table %>%
    mutate(
      pred_class = factor(
        if_else(.pred_1 >= thresh, "1", "0"),
        levels = levels(allSEC)
      )
    ) %>%
    kap(truth = allSEC, estimate = pred_class) %>%
    mutate(threshold = thresh)
})

# Best threshold of kappa
best_threshold <- kappa_by_threshold %>%
  arrange(desc(.estimate)) %>%
  slice(1)

# Pull estimate
best_threshold$.estimate

# New prediction table with estimate 
pred_table2 <- pred_table %>%
  mutate(
    pred_30 = factor(
      if_else(.pred_1 >= best_threshold$.estimate, "1", "0"),
      levels = levels(allSEC)
    )
  )

# New confusion matrix with estimate
confusionMatrixTable <- conf_mat(
  pred_table2,
  truth = allSEC,
  estimate = pred_30
)

# Function for confusion matrix gt table
createConfusionMatrixTable <- function() {
  confusionMatrixGT <- confusionMatrixTable %>%
    tidy() %>%
    mutate(
      Prediction = c("Null", "Predicted All-SEC",
                     "Null", "Predicted All-SEC"),
      Truth = c("0", "0", "1", "1")
    ) %>%
    select(Prediction, Truth, Count = value) %>%
    pivot_wider(
      names_from = Truth,
      values_from = Count,
      names_prefix = "Truth_"
    ) %>%
    gt(rowname_col = "Prediction") %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_stub()) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_body(columns = everything())) %>%
    tab_style(style = cell_text(align = "center"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(
      style = cell_borders(
        sides = c("left", "right"),
        weight = px(0.2)
      ),
      locations = cells_body(columns = everything())
    ) %>%
    cols_label(Truth_0="Null",Truth_1="All-SEC") %>% 
    cols_width(Prediction ~ px(350),
               everything()~px(200)) %>%
    tab_options(
      heading.title.font.size = 36,
      heading.subtitle.font.size = 40,
      table.border.top.color = "white",
      table_body.vlines.style = "solid",
      table_body.vlines.color = "black",
      table_body.vlines.width = 1,
      table.font.size = 28,
      data_row.padding = px(2),
      # change based on 1 or 2-page req.
      heading.background.color = "black",
      column_labels.background.color = "#841617",
      table.border.bottom.color = "black",
      table_body.border.bottom.color = "black",
      table.border.bottom.width = 1,
      table_body.border.bottom.width = 1,
      container.width = 970
    ) %>%
    tab_header(title = "Confusion Matrix") %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Inter Tight"),
          default_fonts()
        )
      ),
      locations = list(cells_title(), cells_body(),
                       cells_column_labels())) %>% 
    tab_style(
      style = cell_text(
        font = c(
          google_font(name = "Noto Sans Mono"),
          default_fonts()
        )
      ),
      locations = cells_body(columns=everything())) %>% 
    tab_style(style = cell_text(align = "center", weight="bold",
                                size="smaller",transform = "uppercase"),
              locations = cells_column_labels(columns = everything())) %>%
    tab_style(style = cell_text(weight = "bold"),
              locations = cells_title(groups = "title"))
  
  confusionMatrixGT
}
createConfusionMatrixTable()

# Print test results
logit_test %>% print(n = 1)
best_kap %>% print(n = 1)

# combine results into a nice tibble
logit_ans <- top_kap %>% slice(1)
logit_ans %<>% left_join(logit_test %>% slice(1),by=c(".metric",".estimator")) %>%
  mutate(alg = "logit") %>% select(-starts_with(".config"))
