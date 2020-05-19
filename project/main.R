# Preparation
install.packages("openxlsx")
install.packages("tidyverse")
library("openxlsx")
library("tidyverse")

df <- read.xlsx("Food_composition_dataset.xlsx")
dim(df) # 236994x12 dataset
colnames(df) # display all col names


## filter out interesting columns
interesting_cols <- c(
    "COUNTRY",
    "efsaprodcode2_recoded",
    "level1",
    "level2",
    "level3",
    "NUTRIENT_TEXT",
    "UNIT",
    "LEVEL"
)
df <- df[interesting_cols]

## rename columns to more convenient names
colnames(df) <- c(
                  "country",
                  "product name",
                  "category",
                  "subcategory",
                  "subsubcategory",
                  "nutrient",
                  "unit",
                  "amount"
)

# Generate correlations
