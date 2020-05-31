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

