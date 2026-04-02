Projekt: Król Kanapy 
Autor: Michalina Gadomska

Przedmiot: Symulacja i Gry Decyzyjne

Środowisko: Godot Engine 4.x

1. Opis Projektu
"Król Kanapy" to autorska interpretacja klasycznej gry "Snake", osadzona w domowych i ogrodowych sceneriach. 
Gracz wciela się w postać Mamy Kotki, której misją jest odnalezienie i bezpieczne sprowadzenie do domu swoich młodych.

Gra łączy dynamiczną zręcznościówkę z elementami planowania trasy, oferując progresywny poziom trudności na czterech unikalnych etapach.

2. Instrukcja Rozgrywki
Cel Gry:
Należy zebrać wymaganą liczbę małych kotków (reprezentowanych na mapie przez myszki), aby odblokować przejście do kolejnego poziomu.

Sterowanie:
Strzałki (Góra, Dół, Lewo, Prawo): Ruch postaci Mamy Kotki.

System Grid-based: Ruch odbywa się w oparciu o stały krok (siatkę)

Warunki Przegranej
Gra kończy się porażką, gdy postać:

- Uderzy w elementy otoczenia (meble, ściany, choinki, itp.).

- Wyjdzie poza wyznaczony obszar gry (pokój/ogród).

- Uderzy we własny ogon (wejście w obszar zajmowany przez małe kotki).

- Zostanie złapana przez psa.

- Nie ukończy zadania przed upływem czasu (Timer).

3. Specyfikacja Techniczna (Wymagania)
- Interfejs Gry
Menu Główne: Ekran startowy.

Ekrany Końcowe: Dedykowane sceny dla wygranej (po 4. poziomie) oraz przegranej (Game Over).

Heads-Up Display: Licznik zebranych punktów oraz dynamiczny zegar odliczający czas.

Podstrona Sterowania: Instrukcja "Jak grać" dostępna dla użytkownika.

- Manager Gry
System Punktacji: Globalna zmienna zliczająca postęp w czasie rzeczywistym.

Timer: Zróżnicowane ograniczenie czasowe: 60 sekund dla poziomów 1-3 oraz 80 sekund dla finałowego poziomu 4.

State Machine: Logika zarządzająca przejściami między scenami oraz wstrzymywaniem procesów po kolizji.

- Fizyka i Kolizje
Najważniejszym aspektem technicznym jest zaawansowany system Collision Layers & Masks:

Warstwa 1 (Player): Główna postać.

Warstwa 2 (Meble): Przeszkody blokujące gracza i wpływające na losowanie pozycji znajdziek.

Warstwa 3 (Przeciwnik): Pies, który wykrywa tylko Mamę Kotkę.

Warstwa 4 (Ogon): Segmenty ogona, które są fizyczną przeszkodą dla głowy, ale są ignorowane przez psa.

- Mechanika Gry
Główna Mechanika (Ogon): System oparty na historii pozycji (Array pozycji Vector2). Każdy dołączony kotek podąża śladem wyznaczonym przez poprzedni segment, tworząc płynny ruch ogona.

- Znajdźki (Collectibles): System instancjonowania "Myszek" z algorytmem sprawdzającym wolne miejsce na mapie.

- Assety
Grafika: Połączenie autorskich grafik wygenerowanych przy wsparciu AI oraz wyselekcjonowanych darmowych zasobów z licencją non-commercial.

Audio: Dźwięki systemowe (miauczenie, uderzenie, szczekanie) przygotowane samodzielnie oraz pobrane z baz dźwięków o otwartej licencji.

4. Wykorzystanie AI
Kod: Wspomaganie się AI (Gemini), każdy fragment kodu wygenerowany przez AI został przeanalizowany i zmodyfikowany

Grafika: Generowanie tekstur bazowych dla postaci i elementów otoczenia.

Konsultacja techniczna: Rozwiązanie problemów z nakładaniem się masek kolizji.
