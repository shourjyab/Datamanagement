//Shourjya Deb
//Data Management Class Assignment 3 - 22nd Feb, 2015
// 1. merge 4 data sets 2. t least one of the 4 merges has to be m:1 (or 1:m)
// 
*******************regular commands******************************

clear //to clear previous memory

set matsize 10000 //to indicate the number of variable that can be a

version 14 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\assignment3"

cap mkdir `worDir'

cd  `worDir'

*****************getting datasets******************

//source of data - http://data.worldbank.org/ 

//installed command to directly access the wb data from stata

//the commands below give direct access to dataset

wbopendata, language(en - English) country() topics() indicator(NY.GDP.MKTP.KD.ZG - GDP GROWTH)

save gdp, replace //always give replace to save

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.CHEM.ZS.UN - Chemicals) long clear

save chemicals, replace

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.FBTO.ZS.UN - Food beverages and tobacco)long clear 

save food, replace

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.MTRN.ZS.UN - Machinery and transport equipment)long clear 

save machine, replace

clear

**********shaping data to see the result clearly*****************

use gdp 

drop countrycode iso2code region regioncode indicatorname indicatorcode

save gdpworkfile, replace

clear

use chemicals

drop countrycode iso2code region regioncode year  

save chemicalsworkfile, replace

clear

use food

drop countrycode iso2code region regioncode year

save foodworkfile, replace

clear

use machine

drop countrycode iso2code region regioncode year

save machineworkfile, replace

clear

******************merging**************

//four of the saved workfiles created above will be used

//gdpworkfile and chemicalsworkfile is merged and saved as merge1

use gdpworkfile 

merge 1:m countryname using chemicalsworkfile  //this is fine, but for this to make sense, there should be year in using file

drop _merge

save merge1, replace

clear

// merge1 is merged to foodworkfile, saved as merge2

use merge1

merge m:m countryname using foodworkfile //like above: foodworkfile doesnt make sense there should be year retained
//so the key is to merge on both countryname AND year !! then it is "1:1   countryname year etc etc"

drop _merge

save merge2 

clear 

// merge2 is merged to machineworkfile, saved in merge3

use merge2

merge m:m countryname using machineworkfile

drop _merge

save merge3

clear

********************done*****************






