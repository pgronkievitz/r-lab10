category_stats <- function(dataframe, category_of_products) {
    stats <- list()
    for (country in levels(dataframe$country)) {
        all_products <- (nrow(dataframe[dataframe$country == country, ]))
        cat_no <- (nrow(dataframe[dataframe$country == country &
            dataframe$category == category_of_products, ]))
        stats[[country]] <- (cat_no / all_products)
    }

    return(stats)
}
subcategory_stats <- function(dataframe, category_of_products) {
    stats <- list()
    for (country in levels(dataframe$country)) {
        all_products <- (nrow(dataframe[dataframe$country == country, ]))
        cat_no <- (nrow(dataframe[dataframe$country == country &
            dataframe$subcategory == category_of_products, ]))
        stats[[country]] <- (cat_no / all_products)
    }

    return(stats)
}
subsubcategory_stats <- function(dataframe, category_of_products) {
    stats <- list()
    for (country in levels(dataframe$country)) {
        all_products <- (nrow(dataframe[dataframe$country == country, ]))
        cat_no <- (nrow(dataframe[dataframe$country == country &
            dataframe$subsubcategory == category_of_products, ]))
        stats[[country]] <- (cat_no / all_products)
    }

    return(stats)
}

#subcategory_stats(dataframe, "Water based beverages")
