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

# Jak widać każdy kraj posiada powyżej 2300 produktów
# jest to duża ilość, która pozwoli nam porównać te kraje
# względem siebie
wide_df <- df_long_to_wide(dataframe)
prod_per_country <- aggregate(product_name ~ country, wide_df, FUN=length)

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
# poszczególnych produktach i kategoriach, a także na porównywaniu ze sobą
# pojedynczych krajów i produktach z nich.

# Naszą analizę zaczniemy od najwyższego poziomu, czyli od poszczególnych
# krajów i kategorii produktów jakie się w nich znajdują
levels(dataframe$country)
levels(dataframe$category)
# W ramce danych znajdują się informacje z 6* krajów unii europejskiej
# i UK. W każdym z tych krajów znajdują się produkty należące do 21
# kategorii.

# Analizę znaczniemy od sprawdzenia, które kategorie zawierają najwięcej produktów
fct_count(wide_df$category, sort = TRUE)
# W kolumnie 'n' znajduje się ilosć produktów, które są w danej kategorii,
# wynika z tego że najwięcej produktów należy do kategorii
# 'Fish, seafood, amphibians, reptiles and invertebrates' drugą kategorią, z podobnym
# wynikiem jest 'Meat and meat products'

# Sprawdźmy zatem jakie dania znajdują się w tej kategorii
wide_df[wide_df$category == "Fish, seafood, amphibians, reptiles and invertebrates",c(1,2)][1:10,]
# Jak można było się domyślić zawiera ona głownie ryby i owoce morza.
# Przyjrzyjmy się zatem jednemu z produktów bezpośrednio i porównajmy go
# w poszczególnych krajach.
compare_product(df = dataframe, prod_name = "Freshwater fish")
# Powyższy wykres zawiera dosyć dużo informacji, więc zaleca się otworzenie go
# w osobnym oknie. 

# Możemy na nim zauważyć, że 'Freshwater fish' dzieli się na 3
# rodzaje różniące się względem ilości poszczególnych składników w nich zawartych.
# Jednak jak wynika z wykresu po lewej wspólną cechą charakterystyczną tego 
# produktu jest wysoka zawartośc fosforu i potasu.
# Sprawdzmy zatem jak ta warość prezentuje się na tle pozostałych produktów.
# Aby to zrobić obliczymy procent produktów który ma większą zawartość
# fosforu i potasu.
for(nutrient in levels(dataframe$nutrient)) {
  cat(compare_percent_of_nutrient(df = dataframe, prod_name = "Freshwater fish", nutrient = nutrient), nutrient, fill = TRUE)
}
# Około 26 % produktów posiada więcej fosforu
# Około 29 % produktów posiada więcej potasu
# Ale, uwaga, okazuje się że produkt ten nie ma sobie równych jeżeli chodzi
# o zawartość witaminy B-12.
