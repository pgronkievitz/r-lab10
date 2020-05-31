## Załadowanie danych z pomocą skryptu
source("load_data.R")

## Załadowanie funkcji potrzebnych do przeprowadzenia analizy
source("cat_stats.R")
source("compare_product.R")
source("top_products_with_nutrient.R")

## Wyświetlenie informacji o danych
dim(dataframe)
# Zawiera ona 236994 obserwacji (wierszy) oraz 8 kolumn

# Kolumny te wskazują na strukturę danych umieszczonych w ramce.
# Każdy kraj zawiera listę produktów, każdy z tych produktów należy
# do swojej kategorii -> subkategorii -> subsubkategorii i każdy
# produkt zawiera listę nutrients, a każdy nutrient zawiera
# informacje o ilości i jednostce (amount i unit)
colnames(dataframe)

# Jak widać każdy kraj posiada powyżej 30000 produktów
# jest to duża ilość, która pozwoli nam porównać te kraje
# względem siebie
prod_per_country <- aggregate(product_name ~ country, dataframe, FUN=length)
prod_per_country

# Na wykresie widać że rozłożenie ilości produktów jest równomierne
pie(prod_per_country$product_name, labels = prod_per_country$country)

# Spojrzymy teraz na sumy i średnie warotości poszczególnych składników
# (nutrients)
nutrient_sum <- aggregate(amount ~ category + country, dataframe, FUN = sum)
nutrient_mean <- aggregate(amount ~ category + country, dataframe, FUN = mean)

barplot(nutrient_sum$amount,
        names.arg = nutrient_sum$country,
        col = nutrient_sum$category,
        main = "Suma ilości poszczególnych składników w każdym z krajów"
)

barplot(nutrient_mean$amount,
        names.arg = nutrient_mean$country,
        col = nutrient_mean$category,
        main = "Średnia ilość poszczególnych składników w każdym z krajów"
)
# Jak widać pomiędzy poszczegłonymy krajami w szerszej perspektywie nie ma
# znaczących różnic, dlatego podczas tej analizy skupimy się głównie na
# posczególnych produktach i kategoriach, a także na porównywaniu ze sobą
# pojedynczych krajów i produktach z nich.
