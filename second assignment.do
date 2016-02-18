//Shourjya Deb
//Data Management Class Assignment 2 - 17th Feb, 2015
/* 1.label 3 variables 2. merge two data sets 3. use collapse or bys: egen to calculate group statistics*/

**********************regular commands**************************
clear //to clear previous memory

set matsize 10000 //to indicate the number of variable that can be a

version 14 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically


// links for the four data sets 
// 1. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/argentina%20middle%20class.dta?attredirects=0&d=1
// 2. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/bolivia%20middle%20class.dta?attredirects=0&d=1
// 3. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/brazil%20middle%20class.dta?attredirects=0&d=1
// 4. https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/chile%20middle%20class.dta?attredirects=0&d=1


*************************************append and labelling*************************************

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/argentina%20middle%20class.dta?attredirect> s=0&d=1"

save argentinamiddleclass, replace

clear

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/bolivia%20middle%20class.dta?attredirects=> 0&d=1"

save boliviamiddleclass, replace

clear

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2nd-assignment-d1/brazil%20middle%20class.dta?attredirects=0&d=1"

save brazilmiddleclass, replace

clear

//to create first label using append and gen 

use argentinamiddleclass, clear

append using boliviamiddleclass brazilmiddleclass, gen(newvariable)

label define missingdata 0"4yearsdatamissing" 1"2yearsdatamissing" 2"2yearsdatamissing"

label values newvariable missingdata

save firvallabel, replace  //browse to see result

clear

//to create second label using append and gen

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

use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/demops2.dta?attredirects=0&d=1", clear

merge 1:1 seqn using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/chps2.dta?attredirects=0&> d=1"

//save the mmerge file as you want

/*
save "C:\Users\DURGA\Documents\mergedps2.dta"
*/

*******************************group statistics*********************


use "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/2ndassignmentdata/chps2.dta?attredirects=0&d=1"

collapse (mean) ridagemn

collapse (median) ridagemn

clear

 




