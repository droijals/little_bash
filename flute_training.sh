#!/bin/bash
clear
modprobe pcspkr
clear
echo -e "QUANTS SEGONS ENTRE NOTES? "; read segons;
clear
while :
do
  INPUT_STRING=$(( ( RANDOM % 8 )  + 1 ))
  case $INPUT_STRING in

        1)
                echo "DO BAIX"
                beep -f 261 -l 1000
                ;;
        2)
                echo "RE"
                beep -f 293 -l 1000
                ;;
        3)
                echo "MI"
                beep -f 329 -l 1000
                ;;
        4)
                echo "FA"
                beep -f 349 -l 1000
                ;;
        5)
                echo "SOL"
                beep -f 392 -l 1000
                ;;
        6)
                echo "LA"
                beep -f 440 -l 1000
                ;;
        7)
                echo "SI"
                beep -f 493 -l 1000
                ;;
        8)
                echo "DO ALT"
                beep -f 513 -l 1000
                ;;

        *)
                echo ""
                ;;
  esac

sleep $segons;
clear
done
echo
