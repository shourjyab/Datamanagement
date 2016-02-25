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

local worDir "C:\Users\DURGA\Desktop\a-3-2"

cap mkdir `worDir'

cd  `worDir'

*****************getting datasets******************

//source of data - http://data.worldbank.org/ 

//installed command to directly access the wb data from stata

//the commands below give direct access to dataset

wbopendata, language(en - English) country() topics() indicator(NY.GDP.MKTP.KD.ZG - GDP GROWTH) long clear

save gdp, replace

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.CHEM.ZS.UN - Chemicals)

save chemicals, replace

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.FBTO.ZS.UN - Food beverages and tobacco) long clear

save food, replace

clear

wbopendata, language (en - English) country () topics () indicator (NV.MNF.MTRN.ZS.UN - Machinery and transport equipment) long clear

save machine, replace

clear

******************shaping the data******************

use gdp

drop countrycode iso2code region regioncode

save gdp1, replace 

clear

use chemicals

drop countrycode iso2code region regioncode

save chem1, replace 

clear

use food

drop countrycode iso2code region regioncode

save food1, replace 

clear

use machine

drop countrycode iso2code region regioncode

save mach1, replace 

clear





******************merging**************

//four files are added gdp,chemicals,food,machine

//gdp and chemicals is merged and saved as merge1

use gdp1 

merge m:1 countryname using chem1

drop _merge

save merge1, replace

clear

// merge1 is merged to food, saved as merge2

use merge1

merge 1:1 countryname year using food1

drop _merge

save merge2 

clear 

// merge2 is merged to machine, saved in merge3

use merge2

merge 1:1 countryname year using machine

drop _merge

save merge3

clear

********************done*****************






