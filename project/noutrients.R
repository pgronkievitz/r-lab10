source("load_data.R")

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
