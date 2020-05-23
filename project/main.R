# Preparation
# install.packages("openxlsx")
# install.packages("tidyverse")
library("openxlsx")
library("tidyverse")
library("ggplot2")

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
    "product_name",
    "category",
    "subcategory",
    "subsubcategory",
    "nutrient",
    "unit",
    "amount"
)
dim(dataframe)
dataframe[sample(nrow(dataframe), 20), ]

## convert to df then column to factors
dataframe <- data.frame(dataframe)

dataframe$product_name <- as.factor(dataframe$product_name)
dataframe$category <- as.factor(dataframe$category)
dataframe$country <- as.factor(dataframe$country)
dataframe$subcategory <- as.factor(dataframe$subcategory)
dataframe$subsubcategory <- as.factor(dataframe$subsubcategory)
dataframe$nutrient <- as.factor(dataframe$nutrient)
dataframe$unit <- as.factor(dataframe$unit)

dataframe$amount[dataframe$unit == "Microgram/100 gram"] <- dataframe$amount[dataframe$unit == "Microgram/100 gram"] / 1000

## reshape df to use separate nutrients as columns
dataframe <- reshape2::dcast(
    dataframe,
    country + product_name + category + subcategory + subsubcategory ~ nutrient,
    value.var = "amount",
    sum
)

numeric_cols <- c(
    "Alpha-tocopherol",
    "Calcium (Ca)",
    "Copper (Cu)",
    "Magnesium (Mg)",
    "niacin equivalents, total",
    "Phosphorus (P)",
    "Potassium (K)",
    "riboflavin",
    "thiamin",
    "Total iron",
    "Total Selenium",
    "vitamin B-12",
    "vitamin B-6, total",
    "vitamin E; alpha-tocopherol equiv from E vitamer activities",
    "vitamin K, total",
    "Zinc (Zn)"
)

dataframe[sample(nrow(dataframe), 10), ]

## plots

# Sum and mean of nutrients per country
nutrient_sum <- aggregate(amount ~ category + country, dataframe, FUN = sum)
nutrient_mean <- aggregate(amount ~ category + country, dataframe, FUN = mean)

barplot(nutrient_sum$amount,
    names.arg = nutrient_sum$country,
    col = nutrient_sum$category
)
barplot(nutrient_mean$amount,
    names.arg = nutrient_mean$country,
    col = nutrient_mean$category
)

# Number of products per country
product_name_sum <- aggregate(product_name ~ country, dataframe, FUN = length)
barplot(product_name_sum$product_name,
    names.arg = product_name_sum$country,
    col = product_name_sum$product_name
)

# Generate correlations
