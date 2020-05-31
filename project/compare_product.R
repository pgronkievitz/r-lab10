compare_product <- function(dataframe, prod_name, save = FALSE) {
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
    prod <- dataframe[dataframe$product_name == prod_name, ]
    prod <- aggregate(amount ~ nutrient + country, prod, FUN = mean)

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
        col = rainbow(length(levels(dataframe$nutrient)))
    )

    ## Wykres po prawej
    barplot(amount ~ nutrient + country, prod,
        beside = FALSE,
        col = rainbow(length(levels(dataframe$nutrient)))
    )

    ## Ustawienie marginesu legendy i skali tekstu
    par(mar = c(0, 0, 0, 0), cex = 0.5)

    ## Tworzy nowy pusty wykres tak, aby legenda pojawiła
    ## się w miejscu 3 3, pod wykresami
    plot.new()

    ## Rysowanie legendy
    legend("center",
        strtrim(levels(dataframe$nutrient), 20),
        fill = rainbow(length(levels(dataframe$nutrient))),
        ncol = 3
    )

    ## Zapisanie wykresu do pliku
    if (save) {
        dev.off()
    }
}
compare_product(dataframe = dataframe, prod_name = "Freshwater fish")

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

# compare_in_cat(dataframe, "Human milk", "Copper (Cu)", 2)
