# Preparation
install.packages("openxlsx")
install.packages("tidyverse")
library("openxlsx")
library("tidyverse")

dataframe <- read.xlsx("Food_composition_dataset.xlsx")
dim(dataframe) # 236994x12 dataset

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
dataframe <- dataframe[interesting_cols]

## rename columns to more convenient names
colnames(dataframe) <- c(
    "country",
    "product name",
    "category",
    "subcategory",
    "subsubcategory",
    "nutrient",
    "unit",
    "amount"
)
dim(dataframe)
df[sample(nrow(df), 20), ]

# Generate correlations
