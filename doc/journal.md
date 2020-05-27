# Dziennik zadań
- Wprowadzenie podstawowych danych
- Dane są w formacie xslx z pomocą biblioteki udało  
nam się je załadować.
- Z danych usunięte zostały niepotrzebne kolumny  
zawierające identyfikatory
- Zmienione zostały nazwy kolumn
- Dane po wczytaniu miały typ char, zostały  
przekonwertowane na factor
- Celem sprawdzenia różnorodności danych zrobiliśmy  
wykresy przedstawiające ilość mikroelementów w  
poszczególnych kategoriach i państwach. Dane  
okazały się w miarę jednolite. Nie niesteśmy w  
stanie wyłącznie po ilości dużej grupy  produktów  
wyciągać wniosków na temat np. poszczególnych państw.  
Natomiast domyślnie rysowane wykresy niepoprawnie  
kolorowały poszczególne subkategorie (typem wykresu  
był barplot) zarówno na wykresie jak i dołączonej do  
niego legendzie. Pomysł porzucony.
- Nowy pomysł: porównianie produktów pomiędzy  
poszczególnymi krajami. Porównywac będziemy  
zawartość zarówno poszczególnych składników  
jak i składnika, którego jest najwięcej.
- Udało się stworzyć funkcję porównującą dowolny  
podukt. : zawijanie działa także  
na wektor kolorów w 'barplot'.
- 'legend' rysuje zbyt duży prostokąt, przysłaniając  
tym samym wykresy. Została przesunięta pod wykres.
- Problem: przy porównywaniu nazw produktów, okazało  
się, że nie są unikalne. Od teraz funkcja porównująca  
produkty grupuje je, a ilości wartości odżywczych  
uśrednia.


