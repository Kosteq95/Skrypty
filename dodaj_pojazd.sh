#rozdział na samochody osobowe -o  i ciężarowe -c --- podawanie przez argument -- bez argumentu to sam osobowy 
#pobrać Markę, Model, Rocznik, Numer rej, Date ostatniego przegladu, Przebieg przy przegladzie, 
#skrypt ma nam utworzyć bazę w ~/Baza_pojazdow/
#                                           - osobowe
#                                                |- omoda
#                                           - ciężarowe
#Skrytp ma wykryć nowy typ badź markę pojazdu i utworzyć odpowiednie foldery 
#"Pasport pojazdu" ma być zapisany jako plik o nazwie numru rejestracyjnego np TK012345.pc
#
# -------------- CAR PASSPORT -----------------
# Marka: .........
# Model: .........
# Rocznik: .......
# Numer rejestracyjny: ..........
# Data ostatniego przegladu: DD.MM.YYYY
# Przebieg od ostatniego przeglądu: ...... km
# Ostania aktualizacja odbyła się  DD.MM.YYYY HH:MM:SS przez "nazwa użytkownika systemu"


typ="osobowe"

if [ $1 = "-c" ]
then
    typ="ciezarowe"
elif [ $1 != "-o" ] && [ -n "$1" ]
then
    echo "Błędny parametr określający typ pojazdu" 1>&2
    exit 1
fi


read -p "Podaj markę samochodu: " marka
read -p "Podaj model samochodu: " model
read -p "Podaj rocznik samochodu: " rocznik
read -p "Podaj numer rejestracyjny: " nr_rej
read -p "Podaj datę ostatniego przeglądu (DD.MM.YYYY) i jego przebieg" przeglad przebieg


file_path="$HOME/Baza_pojazdow/$typ/$marka/"
mkdir -p $file_path

echo "-------------- CAR PASSPORT -----------------
 Marka: $marka
 Model: $model
 Rocznik: $rocznik
 Numer rejestracyjny: $nr_rej
 Data ostatniego przegladu: $przeglad
 Przebieg od ostatniego przeglądu: $przebieg km
 Ostania aktualizacja odbyła się  $(date +%d).$(date +%m).$(date +%Y) $(date +%R):$(date +%S) przez $USER" > $file_path/$nr_rej.pc


