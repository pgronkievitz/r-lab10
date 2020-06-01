category_stats <- function(dataframe, category_of_products) {
## Zwraca listę z procentem zawartości elementu z kategorii
## w tej kategorii
#
# dataframe - ramka z danymi
# category_of_products - nazwa z elementu z 'category'
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
## Zwraca listę z procentem zawartości elementu z subkategorii
## w tej subkategorii
#
# dataframe - ramka z danymi
# category_of_products - nazwa z elementu z 'subcategory'
    stats <- list()
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
## Zwraca listę z procentem zawartości elementu z subsubkategorii
## w tej subsubkategorii
#
# dataframe - ramka z danymi
# category_of_products - nazwa z elementu z 'subsubcategory'
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
