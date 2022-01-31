library(tidyr)
library(ggplot2)
library(dplyr)


names <- c("Usain Bolt", "Tom Brady",  
           "Michael Jordan", "Tiger Woods")

pct <- c(0.709, 0.7, 0.686, 0.378)

colors <- c("#FDDA24", "#002244", "#CE1141", "#076652")

win_pct <- data.frame(names, pct)
View(win_pct)

winplot <- ggplot(win_pct, 
                  aes(x = names,
                      y = pct,
                      fill = names, 
                      color = names)) +
          geom_bar(stat = "identity") +
          geom_text(aes(label = pct), size = 6, vjust = 1.5, colour = "white") +
          labs(title = "Winning percentage of Sport Icons", 
               subtitle = "Only includes Championship Game performances", 
               x = "Names",
               y = "Winning Percentage",
               caption = "Visual by Brandon Wisniewski, Pat Walther, Abhi Joshi, Connor Stephens, and Robbie Goss") +
               theme_dark() +
               theme(plot.title = element_text(hjust = 0.5),
                     plot.subtitle = element_text(hjust = 0.5),
                     plot.caption = element_text(hjust = 0.5)) +
               scale_fill_manual(values = c("#CE1141", 
                                            "#076652", 
                                            "#002244", 
                                            "#FDDA24")) + 
               scale_color_manual(values = c("Black", 
                                             "Gray", 
                                             "#C60C30", 
                                             "#009639"))


print(winplot)
