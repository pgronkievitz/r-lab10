top_products_with_nutrient <- function(df, nutrient_name) {
## Zwraca df posortowany tak, żeby prosukty które mają najwięcej
## danego mikro/makro elementu znalazły się na górze + dodaje
## index w celu ułatwienia interpretacji
#
# nutrient_name - nazwa składinka którego maxa poszukujemy
#
# NOTE: wymaga df w wersji WIDE

  # Posortowanie i wybranie odpowiednich kolumn
  df <- aggregate(df, by=list(df$product_name), FUN=mean)
  dat <- df[order(df[nutrient_name], decreasing = TRUE),c(1,2,3, which(colnames(df) == nutrient_name))]
  colnames(dat)[1] <- "product_name"
  dat <- cbind(1:dim(dat)[1], dat)
  colnames(dat)[1] <- "index"
  return(dat)
}

# k <- top_products_with_nutrient(dataframe2, 'Alpha-tocopherol')


plot_top_products_with_nutrient <- function(nutrient_name,n_of_prod=10, save=FALSE) {
## Zwraca wykres top n_of_prod produktów któr zawierają dany składnik
  # Zbierz dane o produktach zawierających najwęcej danych składników
  top <- top_products_with_nutrient(df_long_to_wide(dataframe), 
                                    nutrient_name = nutrient_name)
  top <- top[1:n_of_prod,]
  
  par(mar=c(2, 11, 2, 10), cex = 1, las = 1)

  barplot(
    height = rev(top[,nutrient_name]),
    names.arg = strtrim(rev(top$product_name), 20),
    horiz = TRUE,
    col = rainbow(n_of_prod),
    main = paste("Top", n_of_prod, "produktów zawierających", nutrient_name),
    xlab = paste("Ilość",nutrient_name, "na Milligram/100 gram")
  )
}
plot_top_products_with_nutrient(nutrient_name = "Alpha-tocopherol")
