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
    par(mar = c(0, 0, 0, 0), cex = 1.1)

    ## Tworzy nowy pusty wykres tak, aby legenda pojawiła
    ## się w miejscu 3 3, pod wykresami
    plot.new()

    ## Rysowanie legendy
    legend("center",
        strtrim(levels(dataframe$nutrient), 30),
        fill = rainbow(length(levels(dataframe$nutrient))),
        ncol = 3
    )

    ## Zapisanie wykresu do pliku
    if (save) {
        dev.off()
    }
}

# compare_product("Rice grain, brown", save = TRUE)
