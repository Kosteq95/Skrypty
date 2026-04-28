#! /bin/bash
# skrypt dla korposzczura


read -p "Podaj o której kończysz prace" godzina_z minuty_z

if [ -z $minuty_z ]
then
    minuty_z=0

fi

if ((minuty_z < 0 || minuty_z > 60))
then
    echo "Nie poprowanie wprowadzone minuty!" 1>&2
    exit 1
fi


godzina="$(($(date +%H)+2))-$(date +%M)"
h_now=$(($(date +%H)+2))
m_now=$(date +%M)

h_zostalo=$((godzina_z - h_now))

if [ $minuty_z -lt $m_now ]
then
    h_zostalo=$((h_zostalo-1))
    minuty_z=$((minuty_z+60))
fi

m_zostalo=$((minuty_z-m_now))

echo "Jest aktualnie $godzina"
echo "Zostało do końca szychty zostało $h_zostalo h $m_zostalo min"
echo "test"
echo "Test githuba"