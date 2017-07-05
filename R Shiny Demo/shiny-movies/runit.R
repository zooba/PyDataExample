# R Script

################## requires R 3.3.2 ##################

#install.packages(c('shiny', 'ggvis', 'dplyr', 'RSQLite'))

install.packages(c('shiny', 'ggvis', 'dplyr', 'RSQLite', 'astro', 'ATE', 'autopls',
'babar', 'backtest', 'bandit', 'BB', 'bedr', 'beepr', 'betas', 'bigml' ))

install.packages('dbplyr')
install.packages('RSQLite')

library(shiny)
library(ggvis)
library(dplyr)
library(RSQLite)
library(dbplyr)
runApp(".")

