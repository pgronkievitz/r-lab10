# Dziennik zadań

- Wprowadzenie podstawowych danych.
- Dane są w formacie xslx z pomocą biblioteki udało nam się je załadować.
- Z danych usunięte zostały niepotrzebne kolumny zawierające identyfikatory
- Zmienione zostały nazwy kolumn
- Dane po wczytaniu miały typ char, zostały przekonwertowane na factor
- Celem sprawdzenia różnorodności danych zrobiliśmy wykresy przedstawiające
  ilość mikroelementów w poszczególnych kategoriach i państwach. Dane okazały
  się w miarę jednolite. Nie nie jesteśmy w stanie wyłącznie po ilości dużej
  grupy produktów wyciągać wniosków na temat np. poszczególnych państw.
  Natomiast domyślnie rysowane wykresy niepoprawnie kolorowały poszczególne
  subkategorie (typem wykresu był `barplot`) zarówno na wykresie jak i
  dołączonej do niego legendzie. Pomysł porzucony.
- Nowy pomysł: porównanie produktów pomiędzy poszczególnymi krajami. Porównywać
  będziemy zawartość zarówno poszczególnych składników jak i składnika, którego
  jest najwięcej.
- Udało się stworzyć funkcję porównującą dowolny produkt. : zawijanie działa
  także na wektor kolorów w `barplot`.
- `legend` rysuje zbyt duży prostokąt, przysłaniając tym samym wykresy. Została
  przesunięta pod wykres.
- Problem: przy porównywaniu nazw produktów, okazało się, że nie są unikalne. Od
  teraz funkcja porównująca produkty grupuje je, a ilości wartości odżywczych
  uśrednia.
- Stworzono funkcje porównujące względną ilość produktów w danej kategorii,
  podkategorii oraz podpodkategorii
- Problem: po znalezieniu produktów które zawierają największą ilość danego  
  składnika, zapomiałem o tym, że produkty mogą pochodzić z różnych krajów.  
  Rozwiązanie: przed sortowaniem grupuję produkty i obliczam średnią z ilości  
  danego składnika w nim.
- Problem: barplot nie przyjmuje `heights = top$name` Rozwiązanie:
  `heights = top[,name]` działa.
- Problem: napisy na wykresach nachodzą na siebie ponieważ są równoległe do  
  osi. Rozwiązanie: ustawienie warości `par(las = 1)`
- Problem: nazwy produktów są zbyt długie i wychodzą poza wykres. Rozwiązanie:
  `strtrim(top$product_name, 20)` przycinam je do 20 znaków.
- Problem: `barplot` gdy rysuje zaczyna od końca `data.frame` tzn. gdy dane  
  posortowane były malejąco na spodzie wykresu znajdowała się wartość  
  maksymalna. Rozwiązanie: odwracam listę podawaną w argumentach z pomocą `rev`.
