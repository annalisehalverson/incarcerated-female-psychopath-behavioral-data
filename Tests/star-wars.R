library(tidyverse)

## Create your goal tibble to replicate

# Run this line to see what your end product should look like
sw.wrangled.goal <- read_csv("Tests/sw-wrangled.csv") %>% 
  mutate(across(c(hair, gender, species, homeworld), factor)) # this is a quick-and-dirty fix to account for odd importing behavior

# View in console
sw.wrangled.goal 

# Examine the structure of the df and take note of data types
# Look closely at factors (you may need another function to do so) to see their levels
str(sw.wrangled.goal) 

## Use the built-in starwars dataset to replicate the tibble above in a tbl called sw.wrangled
# If you get stuck, use comments to "hold space" for where you know code needs to go to achieve a goal you're not sure how to execute
view(sw.wrangled.goal)
view(starwars)

## eyeballing the two data sets, it seems i need to ...
# split name into first and last name /c
# create an initial column incorporating the first letter of first and last (except NA, which is fully copied over) /c
# create a column that converts height (cm) to in /c
# rename hair column and change all NAs to none /c
# remove skin color column /c
# remove eye color column /c
# remove birth year column /c
# remove sex column /c
# replace gender column to show only first letter /c
# put species before homeworld and make all caps /c
# remove films, vehicles, starships /c
# create a T/F column for brown hair /c
# drop columns with NA's in height_in, etc (i think?) /c

# i can't figure out how the rows are ordered???
# i also lost the third name in the three-named people i think, i'm not sure how to resolve that

sw.wrangled <- starwars %>% 
  separate(name, c("first_name", "last_name"), sep = " (?<!-)")
sw.wrangled$initials <- paste0(substr(sw.wrangled$first_name, 1, 1), substr(sw.wrangled$last_name, 1, 1))
sw.wrangled <- sw.wrangled %>% 
  relocate(initials, .after = last_name) %>% 
  rename(height_cm = height) %>% 
  mutate(height_in = height_cm / 2.54) %>% 
  relocate(height_in, .before = height_cm) %>% 
  rename(hair = hair_color)
sw.wrangled$hair <- sw.wrangled$hair %>% replace_na("none")
sw.wrangled <- sw.wrangled[-c(8:11, 15:17)] %>% 
  relocate(species, .before = homeworld) %>% 
  mutate(gender = substr(gender, 1, 1)) %>% 
  drop_na(height_in)
sw.wrangled$species <- toupper(sw.wrangled$species)
sw.wrangled$brown_hair <- sw.wrangled$hair == "brown"

view(sw.wrangled)

## Check that your sw.wrangled df is identical to the goal df
all.equal(sw.wrangled, sw.wrangled.goal)
# Use any returned information about mismatches to adjust your code as needed
# oh my god there's so many little differences this is wild
all.equal(sw.wrangled.goal, sw.wrangled.goal)