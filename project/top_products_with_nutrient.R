top_products_with_nutrient <- function(df, nutrient_name) {
## Zwraca df posortowany tak, żeby prosukty które mają najwięcej
## danego mikro/makro elementu znalazły się na górze + dodaje
## index w celu ułatwienia interpretacji
#
# nutrient_name - nazwa składinka którego maxa poszukujemy
#
# NOTE: wymaga df w wersji WIDE
  
  # Posortowanie i wybranie odpowiednich kolumn
  dat <- df[order(df[nutrient_name], decreasing = TRUE),c(1,2,3,4,5, which(colnames(df) == nutrient_name))]
  
  # 
  dat <- cbind(1:dim(dat)[1], dat)
  colnames(dat)[1] <- "index"
  return(dat)
}

# k <- top_products_with_nutrient(dataframe2, 'Alpha-tocopherol')
