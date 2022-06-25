#1/bin bash

echo -n $1- 
grep -i "$1 $2 $3" 031*_Dealer_schedule | awk '{print $1, $2, $5, $6}'
