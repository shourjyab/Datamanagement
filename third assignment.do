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

save gdp

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.CHEM.ZS.UN - Chemicals) long clear

save chemicals

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.FBTO.ZS.UN - Food beverages and tobacco)long clear 

save food

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.MTRN.ZS.UN - Machinery and transport equipment)long clear 

save machine

clear

**********shaping data to see the result clearly*****************

use gdp 

drop countrycode iso2code region regioncode indicatorname indicatorcode

save gdpworkfile

clear

use chemicals

drop countrycode iso2code region regioncode year

save chemicalsworkfile

clear

use food

drop countrycode iso2code region regioncode year

save foodworkfile

clear

use machine

drop countrycode iso2code region regioncode year

save machineworkfile

clear

******************merging**************

//four of the saved workfiles created above will be used

//gdpworkfile and chemicalsworkfile is merged and saved as merge1

use gdpworkfile 

merge 1:m countryname using chemicalsworkfile

drop _merge

save merge1

clear

// merge1 is merged to foodworkfile, saved as merge2

use merge1

merge m:m countryname using foodworkfile

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






