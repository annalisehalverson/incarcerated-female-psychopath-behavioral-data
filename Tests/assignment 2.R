library(tidyverse)
library(papaja)
require(graphics)
## this is a line of commented text
x <- 6
x + 2
my_string1 <- 'My name is annalise and'
my_string2 <- 'I <3 R'
my_newstring <- paste(my_string1, my_string2)
print(my_newstring)
my_dataframe <- data.frame (
  Name = c("Emma", "Kimmy", "Niko"),
  PCLR_score = c(12, 25, 32),
  Medication = c(TRUE, FALSE, TRUE)
)
print(my_dataframe)
## I used AI to help me learn how to create this dataframe, but all inserted text is my own. :)