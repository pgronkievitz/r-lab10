# Cleanup
install.packages("openxlsx")
install.packages("tidyverse")
library("openxlsx")
library("tidyverse")

df <- read.xlsx("Food_composition_dataset.xlsx")
dim(df) # 307084 x 97 dataset
colnames(df) # display all col names

interesing_cols <- c(
    "COUNTRY",
    "efsaprodcode2_recoded",
    "level1",
    "level2",
    "level3",
    "NUTRIENT_TEXT",
    "UNIT",
    "LEVEL"
)
df <- df[interesing_cols]
# Generate correlations
