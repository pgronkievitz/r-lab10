top_products_with_nutrient <- function(df, nutrient_name, nest_level = 2) {
## Zwraca df posortowany tak, żeby prosukty które mają najwięcej
## danego mikro/makro elementu znalazły się na górze + dodaje
## index w celu ułatwienia interpretacji
#
# nutrient_name - nazwa składinka którego maxa poszukujemy
# nest_level - numer kategorii/subkategorii:
#   - 1 product_name
#   - 2 category
#   - 3 subcategory
#   - 4 subsubcategory
# NOTE: wymaga df w wersji WIDE

  # Posortowanie i wybranie odpowiednich kolumn
  df <- aggregate(df, by=list(df[,colnames(df)[nest_level]]), FUN=mean)
  dat <- df[order(df[nutrient_name], decreasing = TRUE),c(1,2,3, which(colnames(df) == nutrient_name))]
  colnames(dat)[1] <- colnames(df)[nest_level]
  dat <- cbind(1:dim(dat)[1], dat)
  colnames(dat)[1] <- "index"
  return(dat)
}

#k <- top_products_with_nutrient(wide_df, 'Alpha-tocopherol')


plot_top_products_with_nutrient <- function(nutrient_name,n_of_prod=10, save=FALSE, nest_level = 2) {
## Rysuje wykres z produktami, które mają najwięcej nadego składnika
#
# nutrient_name - nazwa składnika z kategorii nutrient
# save = FALSE - czy zapisać do pliku plots/nutrient_name.png
# nest_level - numer kategorii/subkategorii:
#   - 1 product_name
#   - 2 category
#   - 3 subcategory
#   - 4 subsubcategory
#
# NOTE: -dataframe musi być w formie 'long'
#       -folder ./plots musi istnieć

  # Przygotowanie pliku wyjściowego
  if(save) {
    png(file=paste("plots/", gsub(" ", "_", nutrient_name), ".png", sep = ""),
        width=600,
        height=600)
  }

  # Zbierz dane o produktach zawierających najwęcej danych składników
  top <- top_products_with_nutrient(df_long_to_wide(dataframe),
                                    nutrient_name = nutrient_name,
                                    nest_level = nest_level)
  top <- top[1:n_of_prod,]

  # Ustawienie marginesów wykresu, rozmiaru czcionki i orientacji napisów
  par(mar=c(5, 11, 2, 2), cex = 1, las = 1)

  # Rysowanie wykresu
  barplot(
    height = rev(top[,nutrient_name]),
    names.arg = strtrim(rev(top[,2]), 20),
    horiz = TRUE,
    col = rainbow(n_of_prod),
    main = paste("Top", n_of_prod, "produktów zawierających", nutrient_name),
    xlab = paste("Ilość",nutrient_name, "na Milligram/100 gram")
  )

  # Zapisanie wykresu do pliku
  if(save) {
    dev.off()
  }

}

#plot_top_products_with_nutrient(nutrient_name = "Calcium (Ca)", save = FALSE, nest_level = 3)
