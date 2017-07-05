#library(ggplot2)
# nmmaps <- read.csv("C:\\Users\\smortaz\\Documents\\conf\\Pass2016\\r\\chicago-nmmaps.csv", as.is = T)

#https: / / raw.githubusercontent.com / smortaz / NBANotebooks / master / chicago - nmmaps.csv

#install.packages('ggplot2')
library(ggplot2)

nmmaps <- read.csv(url("https://raw.githubusercontent.com/smortaz/NBANotebooks/master/chicago-nmmaps.csv"), as.is = T)


nmmaps$date <- as.Date(nmmaps$date)
nmmaps <- nmmaps[nmmaps$date > as.Date("1996-12-31"),]
nmmaps$year <- substring(nmmaps$date, 1, 4)


head(nmmaps)
##      city 


g <- ggplot(nmmaps, aes(date, temp)) + geom_point(color = "firebrick")
g

g + theme(plot.title = element_text(size = 20, face = "bold",
    margin = margin(10, 0, 10, 0)))


ggplot(nmmaps, aes(temp, temp + rnorm(nrow(nmmaps), sd = 20))) + geom_point() +
  xlim(c(0, 150)) + ylim(c(0, 150)) +
coord_equal()


g <- ggplot(nmmaps, aes(date, temp, color = factor(season))) + geom_point()
g

#here there is no legend automatically
ggplot(nmmaps, aes(x = date, y = o3)) + geom_line(color = "grey") + geom_point(color = "red")


ggplot(nmmaps, aes(x = date, y = o3)) + geom_line(aes(color = "Important line")) +
geom_point(aes(color = "My points"))


ggplot(nmmaps, aes(date, temp)) + geom_point(color = "firebrick") +
theme(panel.background = element_rect(fill = 'grey75'))

ggplot(nmmaps, aes(date, temp, color = factor(season))) +
  geom_point() +
scale_color_brewer(palette = "Set1")


library(grid)

my_grob = grobTree(textGrob("This text stays in place!", x = 0.1, y = 0.95, hjust = 0,
  gp = gpar(col = "blue", fontsize = 12, fontface = "italic")))

ggplot(nmmaps, aes(temp, o3)) + geom_point(color = "firebrick") + facet_wrap(~season, scales = "free") +
annotation_custom(my_grob)


g <- ggplot(nmmaps, aes(x = season, y = o3))
g + geom_boxplot(fill = "darkseagreen4")

g + geom_jitter(alpha = 0.5, aes(color = season), position = position_jitter(width = .2))

g + geom_violin(alpha = 0.5, color = "gray") + geom_jitter(alpha = 0.5, aes(color = season),
      position = position_jitter(width = 0.1)) + coord_flip()


ggplot(nmmaps, aes(date, temp)) + geom_point(color = "firebrick") +
stat_smooth()

ggplot(nmmaps, aes(temp, death)) + geom_point(color = "firebrick") +
stat_smooth(method = "lm", se = FALSE)
