
clear
use cps_2ndgen

//recoding edattain
tab edattain
label list a_hga

* create a new variable
generate newed = 1
replace newed = 2 if edattain>38
replace newed=3 if edattain > 42 
tab edattain newed

* label the new variable's values
label def newedlbl 1 "school dropout" 2 "school grad & some college" 3 "college grad"
label val newed newedlbl
tab newed

//recoding - placdscp - MSA status of residence 1 yea
tab placdscp
label list placdscp 

generate newplacdscp=1
replace newplacdscp=2 if placdscp>0
replace newplacdscp=3 if placdscp>1
replace newplacdscp=4 if placdscp>2
replace newplacdscp=5 if placdscp>3
replace newplacdscp=6 if placdscp>4

label def newplacdscplbl 1 "NIU (under 1 year old)" 2 "Central city of an MSA/PMSA" 3 "Balance of an MSA/PMSA" 4 "Non-metro" 5 "Abroad" 6 "Not identified"
label val newplacdscp newplacdscplbl
tab newplacdscp 

//recoding pearnval   Recode - Total persons earnings
tab pearnval
label list pearnval

generate newpearnval=0
replace newpearnval=1 if pearnval>0
replace newpearnval=2 if pearnval>13000
  

     
     
