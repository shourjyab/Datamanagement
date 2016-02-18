//Shourjya Deb
//Data Management Class Assignment 2 - 17th Feb, 2015
/* 1.label 3 variables 2. merge two data sets 3. use collapse or bys: egen to calculate group statistics*/

**********************regular commands**************************
clear //to clear previous memory

set matsize 10000 //to indicate the number of variable that can be a

version 14 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically

 //always cite your data! where is it comming from! what is the name of it!

// links for the four data sets 
// 1. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/argentina%20middle%20class.dta?attredirects=0&d=1
// 2. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/bolivia%20middle%20class.dta?attredirects=0&d=1
// 3. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/brazil%20middle%20class.dta?attredirects=0&d=1
// 4. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/chile%20middle%20class.dta?attredirects=0&d=1

//could cd here to project dir
cd /tmp
*************************************append and labelling*************************************
//these links are broken--you've copied from comman window and it added '> '; i fixed them; again always run FULL
//file before submitting--it must run as it is!
use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/argentina%20middle%20class.dta?attredirects=0&d=1"

save argentinamiddleclass, replace

clear

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/bolivia%20middle%20class.dta?attredirects=0&d=1"

save boliviamiddleclass, replace

clear

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/brazil%20middle%20class.dta?attredirects=0&d=1"

save brazilmiddleclass, replace

clear

//to create first label using append and gen 

use argentinamiddleclass, clear

append using boliviamiddleclass brazilmiddleclass, gen(newvariable)

//label define missingdata 0"4yearsdatamissing" 1"2yearsdatamissing" 2"2yearsdatamissing" //hmmm
//maybe better:
label define missingdata 0"argentina" 1"bolivia" 2"brazil"
//but i am not sure, not sure what you meant by these labels

label values newvariable missingdata

save firvallabel, replace  //browse to see result

clear

//to create second label using append and gen
//yeach, but that's really the same what you did above--not sure what is the purpose of this
//and same for the third time you do below--can be much more efficient 

use argentinamiddleclass, clear

append using boliviamiddleclass brazilmiddleclass, gen(newvariable2)

label define capital 0"buenos aires" 1"sucre" 2"rio de janeiro"

label values newvariable2 capital

save secvallabel, replace //browse to see result

clear

//to create third label using append and gen

use argentinamiddleclass, clear

append using boliviamiddleclass brazilmiddleclass, gen(newvariable3)

label define currency 0"peso" 1"boliviano" 2"real"

label values newvariable3 currency

save thirdvallabel, replace //browse to see result 

clear

**************************************merging***************************

//using two different data sets 

//using the website www.cdc.gov/nchs/nhanes/ 

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/demops2.dta?attredirects=0&d=1"
 
//this doesnt have portability; you should have done this at the top:
//loc wd "C:\Users\DURGA\Documents\"
//cap mkdir `wd'
//cd  `wd'
//and then just work there

/* save as per your convenience 
save "C:\Users\DURGA\Documents\demops2.dta" 
*/

clear

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/chps2.dta?attredirects=0&d=1"

/*save as per your convenience
save /* as per convenience "save "C:\Users\DURGA\Documents\chps2.dta" */
*/

clear

//saving past is optional, the code runs without saving too 
//always cite your data! where is it comming from! what is the name of it!
use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/demops2.dta?attredirects=0&d=1", clear

merge 1:1 seqn using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/chps2.dta?attredirects=0&d=1"

//save the mmerge file as you want

/*
save "C:\Users\DURGA\Documents\mergedps2.dta"
*/

*******************************group statistics*********************


use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/chps2.dta?attredirects=0&d=1"
//yeach, but collapse ideally should be by some group
collapse (mean) ridagemn

collapse (median) ridagemn

clear

 




