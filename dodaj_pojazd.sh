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
set -e

function pobierz_dane
{
    licznik=0
    while [ -z "$dana" ]
    do
        if [ $licznik -gt 3 ]
        then
            echo "Nie podano $licznik razy $2" 1>&2
            exit 2
        fi
        read -p "Podaj $1 samochodu:"  dana
        licznik=$((licznik+1))
    done

    echo $dana
}


typ="osobowe"

if [ "$1" = "-c" ]
then
    typ="ciezarowe"
elif [ "$1" != "-o" ] && [ -n "$1" ]
then
    echo "Błędny parametr określający typ pojazdu" 1>&2
    exit 1
fi


marka=$(pobierz_dane "markę" "marki")
model=$(pobierz_dane "model" "modelu")


isok=0

while [ $isok -eq 0 ]
do
    rocznik=$(pobierz_dane "rocznik" "rocznika")
    set +e
    zmienna=$(echo "$rocznik" | grep -ciE "^[0-9]+$")
    echo $zmienna
    set -e
    if [ $zmienna == "0" ]
    then
        echo "Podano tekst"
    elif ([[ $rocznik -lt 1890 ]] || [[ $rocznik -gt $(date +%Y) ]]) 
    then
        echo "Podaj rocznik z zakresu 1890-$(date +%Y)!"
    else
        isok=1
    fi

done


nr_rej=$(pobierz_dane "numer rejestracyjny" "numeru rejestracyjnego")
przeglad=$(pobierz_dane "datę ostatniego przeglądu" "daty przeglądu")

dzien=$(echo "$przeglad" | cut -d "." -f 1)
miesiac=$(echo "$przeglad" | cut -d "." -f 2)
rok=$(echo "$przeglad" | cut -d "." -f 3)

set +e

zmienna=$(echo "$przeglad"| grep -ciE "[A-Z]")
echo $zmienna
echo test
#while ! [[ $przeglad == [0-3][0-9].[03-1][0-9].20[0-9][0-9] ]]
while [[ $dzien -lt 0 ]] || [[ $dzien -gt 31 ]] || [[ $miesiac -lt 0 ]] || [[ $miesiac -gt 12 ]] || [[ $rok -lt $(($(date +%Y)-20)) ]] || [[ $rok -gt $(date +%Y) ]]
do
    echo "Podana data jest nie zgodna z formatem DD.MM.YYYY!"
    przeglad=$(pobierz_dane "datę ostatniego przeglądu" "daty przeglądu")
done

przebieg=$(pobierz_dane "przebieg" "przebiegu")



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


