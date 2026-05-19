#! /bin/bash


read -p "Podaj liczbę km" km
read -p "Podaj liczbę zatantowanych litrów: " litr

litr=$(echo "$litr" | tr ',' '.')


spalanie=$(echo "scale=2; 100*$litr/$km" | bc -l)

echo "Spanianie wyniosło: $spalanie"


read -p "Podaj nymer rejestracyjny samochodu: " nr_rej


f_dir=$(find $HOME/Baza_pojazdow/ -type f -name $nr_rej)

echo $f_dir
