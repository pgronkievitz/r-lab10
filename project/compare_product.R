compare_product <- function(df, prod_name, save = FALSE) {
    ## Porównuje dwa produkty
    #
    # prod_name - nazwa produktu z kategorii product_name
    # save = FALSE - czy zapisać do pliku plots/prod_name.png
    #
    # NOTE: -dataframe musi być w formie 'long'
    #       -folder ./plots musi istnieć
    #       -gdy nazwa produktu nie jest unikalna 'amount' zostaje
    #       uśredniona

    ## Wczytanie informacji o produkcie
    prod <- df[df$product_name == prod_name, ]
    prod <- aggregate(amount ~ nutrient + country, prod, FUN = mean)
    bprod <- prod


    ## Przygowanie pliku wyjściowego dla wykresu
    if (save) {
        png(
            file = paste("plots/", gsub(" ", "_", prod_name), ".png", sep = ""),
            width = 1000,
            height = 600
        )
    }

    ## Utworzenie panelu do umieszczenia wykresów o strukturze
    ## 1 2
    ## 3 3
    layout(matrix(c(1, 2, 3, 3), ncol = 2, byrow = TRUE), heights = c(4, 1))

    ## Ustawienie marginesów dla wykresu i skali tekstu
    par(mar = c(2, 2, 2, 2), cex = 1)

    ## Wykres po lewej
    barplot(amount ~ nutrient + country, prod,
        beside = TRUE,
        col = rainbow(length(levels(df$nutrient))),
        main = paste("Udział objętościowy składników w", prod_name)
    )

    # Znormalizowanie danych
    for(nutrient in levels(prod$nutrient)) {
      prod[prod$nutrient == nutrient,]$amount <- normalize(prod[prod$nutrient == nutrient,]$amount)
    }

    ## Wykres po prawej
    barplot(amount ~ nutrient + country, prod,
        beside = FALSE,
        col = rainbow(length(levels(df$nutrient))),
        main = paste("Istnienie danego składniku w", prod_name, "pomiędzy krajami europy.")
    )

    ## Ustawienie marginesu legendy i skali tekstu
    par(mar = c(0, 0, 0, 0), cex = 0.5)

    ## Tworzy nowy pusty wykres tak, aby legenda pojawiła
    ## się w miejscu 3 3, pod wykresami
    plot.new()

    ## Rysowanie legendy
    legend("center",
        strtrim(levels(df$nutrient), 20),
        fill = rainbow(length(levels(df$nutrient))),
        ncol = 3
    )

    ## Zapisanie wykresu do pliku
    if (save) {
        dev.off()
    }
}
# compare_product(df = dataframe, prod_name = "Freshwater fish")

compare_in_cat <- function(dataframe,
                           name,
                           element,
                           nest_level = 4,
                           save = FALSE) {
  ## Porównuje produkt względem jednego elementu w
  ## poszczegónych krajach
  #
  # dataframe - ramka z danymi
  # name - nazwa elementu z kategorii nest_level
  # element - nazwa elementu z kategorii nutrient
  # nest_level - numer kategorii/subkategorii:
  #   - 1 category
  #   - 2 subcategory
  #   - 3 subsubcategory
  #   - 4 product_name
  # save - czy zapisać wykres
    type <- if (nest_level == 1) {
        "category"
    } else if (nest_level == 2) {
        "subcategory"
    } else if (nest_level == 3) {
        "subsubcategory"
    } else if (nest_level == 4) {
        "product_name"
    } else {
        return(NA)
    }
    prod <- dataframe[dataframe[[type]] == name &
        dataframe$nutrient == element, ]

    barplot(amount ~ product_name + country, prod,
        beside = FALSE,
        col = "red",
        main = paste("Zawartość", element, "w", name, "w poszczegónych krajach"),
        ylab = paste("Ilość", element),
        xlab = "Kraj"
    )

    if (save) {
        dev.off()
    }
}

compare_percent_of_nutrient <- function(df, prod_name, nutrient) {
  ## Oblicza procent produktów które zawierają więcej danego składnika
  ## niż średnia prod_name
  #
  # df - ramka z danymi
  # prod_name - nazwa produktu
  # nutrient - nazwa składnika do obliczania procentów

  sred <- mean(dataframe[dataframe$product_name == prod_name & dataframe$nutrient == nutrient, "amount"])


  return(dim(dataframe[dataframe$nutrient == nutrient & dataframe$amount >= sred,])[1] / dim(dataframe[dataframe$nutrient == nutrient,])[1])
}

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# compare_in_cat(dataframe, "Human milk", "Copper (Cu)", 2)
