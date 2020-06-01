# Dziennik zadań

- Stworzone zostało repozytorium z kodem. Znacznie ułatwia ono pracę w zespole.
  Użyty został system wersjonowania GIT, ponieważ jest najpopularniejsze i
  najprostsze w obsłudze.
- Sprawozdanie pisane będzie w języku Markdown. Po analizie doszliśmy do
  wniosku, że `LaTeX` będzie nieadekwatnie skomplikowany.
- Ustawiona została automatyczna kompilacja plików `*.md` do pliku PDF. Pozwala
  to na szybszą edycję, bez konieczności instalowania dodatkowego
  oprogramowania. Do tego celu został użyty `pandoc`.
- _Problem_: Pojawiła się trudność w konfiguracji automatyzacji. _Rozwiązanie_:
  Wystarczająca okazała się zmiana kolejności wykonywania akcji w systemie.
  `GitHub Actions` wykonuje akcje kolejno, nawet przed pobraniem repozytorium.
  Zmieniono numer zadania pobrania repozytorium na 1, co poskutkowało poprawą
  kompilacja plików PDF.
- _Problem_: automatyzacja działała przy każdej zmianie w plikach.
  _Rozwiązanie_: Ustawiono, aby kompilacja odbywała się tylko po uprzednim
  nadaniu tagu w formacie `vX.Y` lub `vX.Y-rcZ`, gdzie `X` oraz `Y` są kolejnymi
  numerami wersji (główna i drobna zmiana). Dopisek `-rc` powoduje dodanie
  zmiany jako jeszcze niegotowej i niepełnej. Służy głównie do testowania nowych
  wersji dokumentu.
- W ramach jeszcze większych uproszczeń w tworzeniu sprawozdania stworzony
  został plik odpowiadający za konfigurację `pandoc`. Nie trzeba już podawać
  dodatkowych argumentów poza nazwą pliku konfiguracyjnego.
- Wprowadzenie podstawowych danych.
- Dane są w formacie `xslx` z pomocą biblioteki udało się je załadować.
- Z danych usunięte zostały niepotrzebne kolumny zawierające identyfikatory.
- Zmienione zostały nazwy kolumn.
- Dane po wczytaniu miały typ char, zostały przekonwertowane na factor.
- Celem sprawdzenia różnorodności danych stworzone zostały wykresy
  przedstawiające ilość mikroelementów w poszczególnych kategoriach i państwach.
  Dane okazały się w miarę jednolite. Nie nie jesteśmy w stanie wyłącznie po
  ilości dużej grupy produktów wyciągać wniosków na temat np. poszczególnych
  państw. Natomiast domyślnie rysowane wykresy niepoprawnie kolorowały
  poszczególne subkategorie (typem wykresu był `barplot`) zarówno na wykresie
  jak i dołączonej do niego legendzie. Pomysł porzucony.
- _Pomysł_: porównanie produktów pomiędzy poszczególnymi krajami. Porównywać
  będziemy zawartość zarówno poszczególnych składników jak i składnika, którego
  jest najwięcej.
- Udało się stworzyć funkcję porównującą dowolny produkt. Zawijanie działa także
  na wektor kolorów w `barplot`.
- _Problem_: Funkcja `legend` rysuje zbyt duży prostokąt, przysłaniając tym
  samym wykresy. Została przesunięta pod wykres.
- _Problem_: przy porównywaniu nazw produktów, okazało się, że nie są unikalne.
  Od teraz funkcja porównująca produkty grupuje je, a ilości wartości odżywczych
  uśrednia.
- Stworzono funkcje porównujące względną ilość produktów w danej kategorii,
  podkategorii oraz podpodkategorii
- _Problem_: po znalezieniu produktów które zawierają największą ilość danego
  składnika, jednakże produkty mogą pochodzić z różnych krajów. _Rozwiązanie_:
  przed sortowaniem grupowane są produkty i obliczam średnią z ilości danego
  składnika w nim.
- _Problem_: `barplot` nie przyjmuje `heights = top$name` _Rozwiązanie_:
  `heights = top[, name]` działa.
- _Problem_: napisy na wykresach nachodzą na siebie ponieważ są równoległe do
  osi. Rozwiązanie: ustawienie wartości `par(las = 1)`
- _Problem_: nazwy produktów są zbyt długie i wychodzą poza wykres.
  _Rozwiązanie_: `strtrim(top$product_name, 20)` ich długość zostaje ograniczona
  do 20 znaków.
- _Problem_: gdy `barplot` rysuje zaczyna od końca `data.frame` tzn. Gdy dane
  posortowane były malejąco na spodzie wykresu znajdowała się wartość
  maksymalna. _Rozwiązanie_: odwrócona zostaje lista podawana w argumentach z
  pomocą `rev`.
- W celu porównania ze sobą danych przeskalowane zostały do wspólnej jednostki.
  _Problem_: na wykresach nie widać niektórych składników. W przypadku braku
  podziału niektóre składniki dominują całkowicie wykresy. Prawdopodobnym
  rozwiązaniem będzie znormalizowanie danych, wykresy nadal będą dobrze
  ilustrować skład, ponieważ porównujemy te same składniki pomiędzy produktami.
- Pojawił się pomysł na plakat, w pliku main.R przeprowadzimy analizę danych a
  najciekawsze wnioski/wykresy wstawimy do plakatu. W plakacie skupimy się na
  stereotypach o jedzeniu z odrobiną humoru.
- _Problem_: Dziennik nie był pisany na bieżąco. _Rozwiązanie_: system kontroli
  wersji pozwolił odtworzyć zmiany w całym projekcie. Możliwe stało się
  dopisanie nieistniejących wpisów.
- _Problem_: Plik `main.R` stał się zbyt duży i nieczytelny. _Rozwiązanie_:
  funkcje zostały wydzielone do osobnych plików. Każdy odpowiada za inną, w
  większości przypadków niezależną część analizy danych. Osobnym plikiem stało
  się także wczytanie danych i ich wstępne przetworzenie. W pliku `main.R`
  aktualnie znajduje się sama analiza z użyciem osobnych funkcji.
- _Problem_: utrzymanie czytelnego i jednorodnego kodu stało się dość trudne.
  _Rozwiązanie_: skonfigurowane zostało automatyczne formatowanie. Nie ogranicza
  to do zera procesu formatowania, jednak znacznie go przyspiesza.
- _Problem_: w przypadku niektórych funkcji łatwiej jest operować na ramce
  pozostawionej w oryginalnym formacie. _Rozwiązanie_: stworzona została
  funkcja, która automatycznie konwertuje oryginalną ramkę na wersję szeroką.
- _Problem_: Bezpośrednio z ramki danych nie można zliczać produktów, ponieważ
  nie są one na najniższym poziomie w ramce. _Rozwiązanie_: przekonwertowanie
  ramki do wersji szerokiej, gdzie każda unikalna kombinacja pierwszych 5 koumn
  stanowi unikalny index.
- Podczas porównywania produktów niektóre składniki nie są wyraźnie widoczne na
  wykresach. Problem ich normalizacji nadal nie został rozwiązany.
- Udało się rozwiązać problem niewidoczności danych na wykreasch. Od teraz
  funkcja rysująca wykres po wyselekcjonowaniu danych, normalizuje je względem
  każdego ze składników. W ten sposób każdy ze składników reprezentowany jest w
  skali od 0 do 1 względem pozostałych. 0 - składnik nie występuje, 1 produkt
  zawiera najwięcej danego składnika w porównaniu z tym samym produktem z innych
  krajów.
- _Problem_:Dane po znormalizowaniu nie oddają udziału objętościowego
  poszczególnych składników. _Rozwiązanie_: Z dwóch generowanych wykresów,
  wykres po lewej zawiera dane przed normalizacją, a po prawej po. W ten sposób
  widać zarówno udział składników jak i ich objętość.
- _Problem_: Powrócił problem kolorowania wykresów. Przez braki danych, wektor
  kolorów zawija się po złych wierszach. _Rozwiązanie_: cast i melt ramki
  danych. Najpierw zamieniam jedną kolumnę typu "Factor" na wiele kolumn (format
  wide), a następnie przywracam ją do pierwotnej formy. W ten sposób każdy
  produkt uzyska każdy składnik (braki uzupełnia się zerami). Teraz zawijanie
  działa prawidłowo.
