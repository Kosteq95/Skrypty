#! /bin/bash
# skrypt dla korposzczura

read -p "Podaj o której kończysz prace" godzina_z minuty_z

if [ $minuty_z = "00" ]
then
    minuty_z=60
fi

godzina="$(($(date +%H)+2))-$(date +%M)"
h_now=$(($(date +%H)+2))
m_now=$(date +%M)

h_zostalo=$((godzina_z - h_now - 1))
m_zostalo=$((minuty_z-m_now))

echo "Jest aktualnie $godzina"
echo "Zostało do końca szychty zostało $h_zostalo:$m_zostalo"
echo "test"
echo "Test githuba"