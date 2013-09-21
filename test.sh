SCRIPTNAME="${0##*/}"
echo $SCRIPTNAME
echo $0
echo 1 is $1
if [ "$1" == "" ] 
then
	echo 1 is empty
else 
	echo 1 is full
fi

