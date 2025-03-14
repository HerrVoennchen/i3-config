#!/bin/bash
 
scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
convert /tmp/screen.png -scale 25% -scale 400% -fill black -colorize 50% /tmp/screen.png
 
if [[ -f $1 ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $1 | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    for RES in $SR
    do
	#echo $RES
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))

	#echo "SRX " $SRX
	#echo "SRY " $SRY
	#echo "RX " $RX
	#echo "RY " $RY
	#echo "SROX " $SROX
	#echo "SROY " $SROY
	#echo "PX " $PX
	#echo "PY " $PY
 
        convert /tmp/screen.png $1 -geometry +$PX+$PY -composite -matte  /tmp/screen.png
        #echo "done"
    done
fi
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
# i3lock  -I 10 -d -e -u -n -i /tmp/screen.png
i3lock -e -n -i /tmp/screen.png
rm /tmp/screen.png
