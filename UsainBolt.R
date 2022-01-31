#Installed libraries
#install.packages("rvest")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("hablar")
#install.packages("tidyverse")
#install.packages('sqldf')
#install.packages("ggthemes")

#Included libraries
library(rvest)
library(dplyr)
library(ggplot2)
library(hablar)
library(tidyverse)
library(sqldf)
library(ggthemes)

Bolt_wiki <- "https://en.wikipedia.org/wiki/Usain_Bolt"

pageobj <- read_html(Bolt_wiki, as.data.frame=T, stringsAsFactors = TRUE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[3]] %>% 
  html_table(fill=T) -> international_medals

colnames(international_medals) <- c('Event', 'Gold', 'Silver', 'Bronze')
view(international_medals)
#write.csv(international_medals, 'Bolt_International_Medals.csv', row.names = FALSE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[4]] %>% 
  html_table(fill=T) -> medals
colnames(medals) <- c('Event', 'Gold', 'Silver', 'Bronze')
view(medals) 
#write.csv(medals, 'Bolt_Medals_By_Event.csv', row.names = FALSE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[5]] %>% 
  html_table(fill=T) -> personal_bests
colnames(medals) <- c('Event', 'Gold', 'Silver', 'Bronze')
view(personal_bests)

pageobj %>%  
  html_nodes("table") %>% 
  .[[6]] %>% 
  html_table(fill=T) -> yearly_bests
view(yearly_bests)

pageobj %>%  
  html_nodes("table") %>% 
  .[[7]] %>% 
  html_table(fill=T) -> international_competitions
view(international_competitions)

most_medals <- "https://en.wikipedia.org/wiki/List_of_multiple_Olympic_gold_medalists"

pageobj <- read_html(most_medals, as.data.frame=T, stringsAsFactors = TRUE)
pageobj %>%  
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(fill=T) -> most_medals
most_medals<-na.omit(most_medals)
view(most_medals)
#write.csv(most_medals, 'Most_Olympic_Medals.csv', row.names = FALSE)

sprinter_medals <- head(sqldf("SELECT * FROM most_medals WHERE Sport = 'Athletics';"), n=10)
view(sprinter_medals)

most_gold <- ggplot(sprinter_medals, aes(y=reorder(Athlete, +Gold), x=Gold, color = Nation, fill = Nation)) +
  geom_bar(stat='identity') + 
  labs(title="Most Gold Medals in Track & Field", 
       caption = "Data Viz by Brandon Wisniewski, Abhi Joshi, Pat Walther, Connor Stephens & Robbie Goss ~ Data from Wikipedia",
       y='Athlete', x='Gold Medals') +
  theme(plot.title = element_text(hjust = 0.5),
  plot.subtitle = element_text(hjust = 0.5),
  plot.caption = element_text(hjust = 0.5)) +
  theme_bw() +
  scale_x_continuous(breaks = pretty_breaks()) +
  scale_fill_manual(values=c("Finland" = "#002F6C", "United States" = "#BF0D3E", 
                             "Jamaica" = "#FDDA24")) +
  scale_color_manual(values=c("Finland" = "#002F6C", "United States" = "#BF0D3E", 
                              "Jamaica" = "#FDDA24"))
most_gold
#ggsave(filename = 'Most_Gold_Medals_Track&Field.png', plot = most_gold, width=10, height=5, units="in", dpi=300)

hundred_meters <- "https://en.wikipedia.org/wiki/100_metres"
pageobj <- read_html(hundred_meters, as.data.frame=T, stringsAsFactors = TRUE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[6]] %>% 
  html_table(fill=T) -> hundred_meters
view(hundred_meters)

Athlete <- c('Usain Bolt', 'Tyreek Hill', 'Leonard Fournette', 'Matt Breida', 'Raheem Mostert', 'Jonathan Taylor')
Speed <- c(27.33, 23.24, 22.05, 22.3, 23.09, 22.13)
Year <- c(2011, 2016, 2017, 2019, 2020, 2021)
Sport <- c('Track & Field', 'Football', 'Football', 'Football', 'Football', 'Football')
fastest_top_speed <- data.frame(Athlete, Speed, Year, Sport)
view(fastest_top_speed)

Bolt_vs_NFL <- ggplot(fastest_top_speed, aes(x=Athlete, y=Speed, label=Speed)) + 
  geom_point(size=3) + 
  geom_segment(aes(x=Athlete, 
                   xend=Athlete, 
                   y=10, 
                   yend=Speed)) +
  theme_gray() +
  labs(title="Usain Bolt vs Fastest NFL Players", 
       subtitle="Top Speed in mph", 
       caption="Data Viz by Brandon Wisniewski, Abhi Joshi, Pat Walther, Connor Stephens & Robbie Goss | Data from NFL Next Gen Stats & Britannica") + 
  theme(plot.background = element_rect(fill = "#009639"), 
        axis.text.x = element_text(angle=65, vjust=0.6, color="black"),
        axis.text.y = element_text(color="black"),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5),) + 
  geom_point(size = 8) +
  geom_text(color = 'yellow', size = 2)
Bolt_vs_NFL
#ggsave(filename = 'Bolt_vs_NFL.png', plot = Bolt_vs_NFL, width=8, height=5, units="in", dpi=300)

hundred_meters <- c(10.03, 9.69, 9.58, 9.82, 9.76, 9.63, 9.77, 9.98, 9.79, 9.81, 9.95)
two_hundred_meters <- c(21.73, 20.58, 20.13, 19.93, 19.99, 19.88, 19.75, 19.30, 
                        19.19, 19.56, 19.40, 19.32, 19.66, 19.55, 19.78)
four_hundred_meters <- c(48.28, 47.12, 45.35, 47.58, 47.58, 45.28, 46.94, 45.54, 
                         45.87, 46.44, 46.28)
mean(hundred_meters)
mean(two_hundred_meters)
mean(four_hundred_meters)
