# PREPARING DATA FOR ANALYSIS IN R #

library(tidyverse)
library(mediation)

# 1. determine assessments and scores needed for analysis /c
# 2. mock up ideal data structure, in long format /c
# 3. import all relevant sheets to R [6]
# 4. filter only necessary columns in each sheet [20]
# 5. join all columns together into one large, wide table
# 6. pivot_longer function to convert to a long table, referencing mockup
# 7. do something about missing values
# 8. view the data sets

# step 3
DKEFS_df <- read_excel("localonly/Decety_assessment_data_copy.xlsx", sheet = "dkefs")
print(DKEFS_df)
PAI_BOR_df <- read_excel("localonly/Decety_assessment_data_copy.xlsx", sheet = "PAI_BOR")
print(PAI_BOR_df)
ZAN_df <- read_excel("localonly/Decety_assessment_data_copy.xlsx", sheet = "ZAN")
print(ZAN_df)
PCLR_df <- read_excel("localonly/Decety_assessment_data_copy.xlsx", sheet = "PCL-R")
print(PCLR_df)
TAS_df <- read_excel("localonly/Decety_assessment_data_copy.xlsx", sheet = "TAS20")
print(TAS_df)
STAI_df <- read_excel("localonly/Decety_assessment_data_copy.xlsx", sheet = "STAI")
print(STAI_df)

# step 4
filtered_DKEFS_df <- DKEFS_df %>% select (1, 2)
print(filtered_DKEFS_df)
filtered_PAI_BOR_df <- PAI_BOR_df %>% select (1, 26)
print(filtered_PAI_BOR_df)
filtered_ZAN_df <- ZAN_df %>% select (1, 11, 12, 13, 14, 15)
print(filtered_ZAN_df)
filtered_PCLR_df <- PCLR_df %>% select (1, 22, 23, 24, 25, 26, 27, 28)
print(filtered_PCLR_df)
filtered_TAS_df <- TAS_df %>% select (1, 22, 23, 24, 25)
print(filtered_TAS_df)
filtered_STAI_df <- STAI_df %>% select (1, 42, 43)
print(filtered_STAI_df)

# step 4.5
filtered_PCLR_df$PCLR_Factor2_Score_Prorated <- as.double(
  filtered_PCLR_df$PCLR_Factor2_Score_Prorated
)
filtered_PCLR_df$PCLR_Facet3_Score_Prorated <- as.double(
  filtered_PCLR_df$PCLR_Facet3_Score_Prorated
)

# step 5
assessment_data_wide <- full_join(
  filtered_DKEFS_df, filtered_PAI_BOR_df) %>% 
  full_join(filtered_ZAN_df, by = "URSI") %>% 
  full_join(filtered_PCLR_df, by = "URSI") %>% 
  full_join(filtered_TAS_df, by = "URSI") %>% 
  full_join(filtered_STAI_df, by = "URSI")
print(assessment_data_wide)

# step 6
assessment_data_long <- assessment_data_wide %>% 
  pivot_longer(cols = c("PAIBOR_Total_Score", 
                        "ZAN_Total_Score", 
                        "ZAN_Affective_Disturbance", 
                        "ZAN_Cognitive_Disturbance", 
                        "ZAN_Impulsivity", 
                        "ZAN_Disturbed_Relationship", 
                        "PCLR_Total_Score_Prorated", 
                        "PCLR_Factor1_Score_Prorated", 
                        "PCLR_Factor2_Score_Prorated", 
                        "PCLR_Facet1_Score_Prorated", 
                        "PCLR_Facet2_Score_Prorated", 
                        "PCLR_Facet3_Score_Prorated", 
                        "PCLR_Facet4_Score_Prorated", 
                        "TAS_Factor1_Difficulty_Identifying_Feeling", 
                        "TAS_Factor2_Difficulty_Describing_Feelings", 
                        "TAS_Factor3_Externally_Oriented_Thinking", 
                        "TAS_Total_Score", 
                        "STAI_State_Anxiety", 
                        "STAI_Trait_Anxiety"),
               names_to = "Assessment",
               values_to = "Score")
print(assessment_data_long)

# step 7
# there are some NAs at the bottom, replace with -1001 for consistency
assessment_data_long$Score[is.na(assessment_data_long$Score)] <- -1001
# replace missing ages as NA so they don't impact descriptives
assessment_data_long$Age <- ifelse(assessment_data_long$Age == -1001, NA, assessment_data_long$Age)

# create subset that removes all rows containing -1001 in Score column
# note doesn't remove entire participant! just their missing assessment
sub_assessment_data_long <- assessment_data_long[assessment_data_long$Score != -1001, ]

# step 8
# view both data frames
view(assessment_data_long) # 2,945 entries
view(sub_assessment_data_long) # 2,611 entries (334 missing)










