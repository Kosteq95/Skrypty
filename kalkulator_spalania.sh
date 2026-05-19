#! /bin/bash


read -p "Podaj liczbę km" km
read -p "Podaj liczbę zatantowanych litrów: " litr

litr=$(echo "$litr" | tr ',' '.')


spalanie=$(echo "scale=2; 100*$litr/$km" | bc -l)

echo "Spanianie wyniosło: $spalanie"


read -p "Podaj numer rejestracyjny samochodu: " nr_rej


f_dir=$(find $HOME/Baza_pojazdow/ -type f -name $nr_rej.pc)
cat $f_dir

ilelinii=$(wc -l $f_dir | cut -d " " -f 1) 

czyspalanie=$(grep -c Spalanie $f_dir)
echo $czyspalanie

if [ $czyspalanie -gt 0 ]
then
    sed -i $(($ilelinii-1))"d" $f_dir 
    sed -i $(($ilelinii-1))"d" $f_dir 
else
    sed -i $ilelinii"d" $f_dir 
fi

ilelinii=$(wc -l $f_dir | cut -d " " -f 1) 

sed -i $ilelinii"a  Spalanie: $spalanie" $f_dir
sed -i "$((ilelinii+1))a  Ostania aktualizacja odbyła się  $(date +%d).$(date +%m).$(date +%Y) $(date +%R):$(date +%S) przez $USER" $f_dir
