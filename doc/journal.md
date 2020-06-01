# Dziennik zadań

- Stworzone zostało repozytorium z kodem. Znacznie ułatwia ono pracę w zespole.
  Użyty został system wersjonowania GIT, ponieważ jest najpopularniejsze i
  najprostsze w obsłudze.
- Sprawozdanie pisane będzie w języku Markdown. Po analizie doszliśmy do
  wniosku, że `LaTeX` będzie nieadekwatnie skomplikowany.
- Ustawiona została automatyczna kompilacja plików `*.md` do pliku PDF. Pozwala
  to na szybszą edycję, bez konieczności instalowania dodatkowego
  oprogramowania. Do tego celu został użyty `pandoc`.
- *Problem*: Pojawiła się trudność w konfiguracji automatyzacji.
  *Rozwiązanie*:
  Wystarczająca okazała się zmiana kolejności wykonywania akcji w systemie.
  `GitHub Actions` wykonuje akcje kolejno, nawet przed pobraniem repozytorium.
  Zmieniono numer zadania pobrania repozytorium na 1, co poskutkowało poprawą
  kompilacja plików PDF.
- *Problem*: automatyzacja działała przy każdej zmianie w plikach.
  *Rozwiązanie*: Ustawiono, aby kompilacja odbywała się tylko po uprzednim
  nadaniu tagu w formacie `vX.Y` lub `vX.Y-pre`, gdzie `X` oraz `Y` są kolejnymi
  numerami wersji (główna i drobna zmiana). Dopisek `-pre` powoduje dodanie
  zmiany jako jeszcze niegotowej i niepełnej. Służy głównie do testowania
  nowych wersji dokumentu.
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
- *Pomysł*: porównanie produktów pomiędzy poszczególnymi krajami. Porównywać
  będziemy zawartość zarówno poszczególnych składników jak i składnika, którego
  jest najwięcej.
- Udało się stworzyć funkcję porównującą dowolny produkt. Zawijanie działa
  także na wektor kolorów w `barplot`.
- *Problem*: Funkcja `legend` rysuje zbyt duży prostokąt, przysłaniając tym
  samym wykresy. Została przesunięta pod wykres.
- *Problem*: przy porównywaniu nazw produktów, okazało się, że nie są unikalne. Od
  teraz funkcja porównująca produkty grupuje je, a ilości wartości odżywczych
  uśrednia.
- Stworzono funkcje porównujące względną ilość produktów w danej kategorii,
  podkategorii oraz podpodkategorii
- *Problem*: po znalezieniu produktów które zawierają największą ilość danego
  składnika, jednakże produkty mogą pochodzić z różnych krajów.
  *Rozwiązanie*: przed sortowaniem grupowane są produkty i obliczam średnią z
  ilości danego składnika w nim.
- *Problem*: `barplot` nie przyjmuje `heights = top$name`
  *Rozwiązanie*: `heights = top[, name]` działa.
- *Problem*: napisy na wykresach nachodzą na siebie ponieważ są równoległe do osi.
  Rozwiązanie: ustawienie wartości `par(las = 1)`
- *Problem*: nazwy produktów są zbyt długie i wychodzą poza wykres.
  *Rozwiązanie*: `strtrim(top$product_name, 20)` ich długość zostaje ograniczona
  do 20 znaków.
- *Problem*: gdy `barplot` rysuje zaczyna od końca `data.frame` tzn. Gdy dane
  posortowane były malejąco na spodzie wykresu znajdowała się wartość
  maksymalna.
  *Rozwiązanie*: odwrócona zostaje lista podawana w argumentach z pomocą `rev`.
- W celu porównania ze sobą danych przeskalowane zostały do wspólnej jednostki.
  *Problem*: na wykresach nie widać niektórych składników. W przypadku
  braku podziału niektóre składniki dominują całkowicie wykresy.
  Prawdopodobnym rozwiązaniem będzie znormalizowanie danych, wykresy nadal będą
  dobrze ilustrować skład, ponieważ porównujemy te same składniki pomiędzy
  produktami.
- Pojawił się pomysł na plakat, w pliku main.R przeprowadzimy analizę danych a
  najciekawsze wnioski/wykresy wstawimy do plakatu. W plakacie skupimy się na
  stereotypach o jedzeniu z odrobiną humoru.
- *Problem*: Dziennik nie był pisany na bieżąco.
  *Rozwiązanie*: system kontroli wersji pozwolił odtworzyć zmiany w całym
  projekcie. Możliwe stało się dopisanie nieistniejących wpisów.
- *Problem*: Plik `main.R` stał się zbyt duży i nieczytelny.
  *Rozwiązanie*: funkcje zostały wydzielone do osobnych plików. Każdy odpowiada
  za inną, w większości przypadków niezależną część analizy danych. Osobnym
  plikiem stało się także wczytanie danych i ich wstępne przetworzenie.
  W pliku `main.R` aktualnie znajduje się sama analiza z użyciem osobnych
  funkcji.
- *Problem*: utrzymanie czytelnego i jednorodnego kodu stało się dość trudne.
  *Rozwiązanie*: skonfigurowane zostało automatyczne formatowanie. Nie
  ogranicza to do zera procesu formatowania, jednak znacznie go przyspiesza.
- *Problem*: w przypadku niektórych funkcji łatwiej jest operować na ramce
  pozostawionej w oryginalnym formacie.
  *Rozwiązanie*: stworzona została funkcja, która automatycznie konwertuje
  oryginalną ramkę na wersję szeroką.
