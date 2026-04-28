#! /bin/bash
# skrypt dla korposzczura
godzina_z=15
godzina="$(($(date +%H)+2))-$(date +%M)"
h_now=$(($(date +%H)+2))
m_now=$(date +%M)

h_zostalo=$(($godzina_z - $h_now - 1))
m_zostalo=$((60-$m_now))

echo "Jest aktualnie $godzina"
echo "Zostało do końca szychty zostało $h_zostalo:$m_zostalo"
echo "test"
echo "Test githuba"