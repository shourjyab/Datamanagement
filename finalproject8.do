 //Shourjya Deb
 //Data Management Final Project - 1st April, 2016
 
 
//aok: please put at the top a pargaraph or few saying what you are doing here
 
 *******************regular commands******************************

clear //to clear previous memory
set matsize 10000 //to indicate the number of variable that can be a
version 14 //to indicate which version of stata has been used
set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\finalprojecttrial1"
cap mkdir `worDir'
cd `worDir'

***************data*****************

//link to wgidata set: http://info.worldbank.org/governance/wgi/index.aspx#home
//data on world wide governance indicators
//weblink: https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidata set.xlsx?attredirects=0&d=1

foreach sheet in "VoiceandAccountability" "GovernmentEffectiveness" "RegulatoryQuality" "RuleofLaw" "ControlofCorruption" {
  import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet(`sheet') clear
  drop in 1/13
  keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
  renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
  drop in 1/2
  drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
  destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
  reshape long yr, i(countrycode)j(var)
  rename var year
  label variable countrycode "code used to denote country in dataset"
  label variable year "the year of observation"
  label variable country "name of country"
  save `sheet',replace
  clear
 } 
 
 
 //VoiceandAccountability - GovernmentEffectiveness - RegulatoryQuality - RuleofLaw - ControlofCorruption

use VoiceandAccountability
rename yr va
label variable va "voice and accountability estimate"
save, replace
clear

use GovernmentEffectiveness
rename yr ge
label variable ge "government effectiveness estimate"
save, replace
clear

use RegulatoryQuality
rename yr rq
label variable rq "regulatory quality estimate"
save, replace
clear

use RuleofLaw
rename yr rl
label variable rl "rule of law estimate"
save, replace
clear

use ControlofCorruption
rename yr cc
label variable cc "control of corruption estimate"
save, replace
clear

use VoiceandAccountability
merge 1:1 countrycode year using GovernmentEffectiveness
drop _merge
merge 1:1 countrycode year using RegulatoryQuality
drop _merge
merge 1:1 countrycode year using RuleofLaw
drop _merge
merge 1:1 countrycode year using ControlofCorruption
drop _merge
save govind, replace
clear 
 
//world bank data
wbopendata, language(en - English) country() topics(4 - Education) indicator()
save edupk, replace
clear
wbopendata, language(en - English) country() topics(3 - Economy & Growth) indicator()
save econgropk, replace
clear
wbopendata, language(en - English) country() topics(8 - Health) indicator()
save healthpk, replace
clear
wbopendata, language(en - English) country() topics(12 - Private Sector) indicator()
save pvtsecpk, replace
clear
wbopendata, language(en - English) country() topics(13 - Public Sector) indicator()
save pubsecpk, replace
clear 
wbopendata, language(en - English) country() topics(9 - Infrastructure) indicator()
save infrapk, replace
clear   


//appending to get all world bank indicators together

use edupk
append using econgropk
append using healthpk
append using pvtsecpk
append using pubsecpk
append using infrapk
save random, replace
clear


//to isolate data for the sub-continent 
use random
drop if countryname !="India" & countryname !="Bangladesh" & countryname !="Sri Lanka" & countryname !="Nepal" & countryname !="Bhutan" & countryname !="Pakistan"
  
  drop if indicatorname!= "Out-of-school children of primary school age, both sexes (number)" /// 
  & indicatorname!="Enrolment in primary education, both sexes (number)" /// 
  & indicatorname!="Enrolment in secondary education, both sexes (number)" /// 
  & indicatorname!="Teachers in primary education, both sexes (number)" /// 
  & indicatorname!="Teachers in secondary education, both sexes (number)" ///
  & indicatorname!="Number of infant deaths" ///
  & indicatorname!="Number of under-five deaths" ///
  & indicatorname!="Number of neonatal deaths" ///
  & indicatorname!="Number of maternal deaths" ///
  & indicatorname!="Health expenditure per capita (current US$)" ///
  & indicatorname!="Foreign direct investment, net inflows (BoP, current US$)" ///
  & indicatorname!="GDP per capita (current US$)" ///
  & indicatorname!="Foreign direct investment, net inflows (BoP, current US$)" ///
  & indicatorname!="Gross national expenditure (current US$)" ///
  & indicatorname!="Net official development assistance received (current US$)" ///
  & indicatorname!="International tourism, number of arrivals" ///
  & indicatorname!="Merchandise imports (current US$)" ///
  & indicatorname!="Merchandise exports (current US$)" ///
  & indicatorname!="Number of maternal deaths" ////
  & indicatorname!="Investment in energy with private participation (current US$)" ///
  & indicatorname!="Investment in transport with private participation (current US$)" ///
  & indicatorname!="Tax revenue (current LCU)" ///
  & indicatorname!="Military expenditure (current LCU)" ///
  & indicatorname!="Battle-related deaths (number of people)" ///
  & indicatorname!="Armed forces personnel, total" ///
  & indicatorname!="Air transport, registered carrier departures worldwide" ///
  & indicatorname!="Rail lines (total route-km)" ///
  & indicatorname!="Mobile cellular subscriptions" ///
  & indicatorname!="Fixed telephone subscriptions" ///
  & indicatorname!="Fixed broadband subscriptions"

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

generate id=_n
reshape long yr,i(id)j(year)
drop id


replace indicatorname=strtoname(indicatorname)
replace indicatorname=substr(indicatorname,1,20)

reshape wide yr, i(countrycode year)j(indicatorname)string

renvars yrAir_transpo~s yrArmed_force~n yrBattle_rela~h yrEnrolment_i~y \airt afp brd epe
renvars yrEnrolment_i~a yrFixed_broad~s yrFixed_telep~s yrForeign_dir~s yrGDP_per_cap~r\ese fbs fts fdi gdp
renvars yrGross_natio~n yrHealth_expe~p yrInternation~s yrInvestment_~y yrInvestment_~p\gne hec into inve invt
renvars yrMerch~xports_ yrMerch~mports_ yrMilitary_ex~e yrMobile_cell~s yrNet_officia~p\meexp meimp me mob nod
renvars yrNumber_of_i~a yrNumber_of_m~d yrNumber_of_n~d yrNumber_of_u~e yrOut_of_scho~r\infd matd neod ufd outchi
renvars yrRail_lines_~o yrTax_revenue~t yrTeachers_in~_ yrTeachers_in~r\rail tr tpe tse  
  label variable outchi "Out-of-school children of primary school age, both sexes (number)"
  label variable epe "Enrolment in primary education, both sexes (number)"
  label variable ese "Enrolment in secondary education, both sexes (number)"
  label variable tpe "Teachers in primary education, both sexes (number)"
  label variable tse "Teachers in secondary education, both sexes (number)"
  label variable year "the year of osbervation"
  label variable fdi "Foreign direct investment, net inflows (BoP, current US$)"
  label variable nod "Net official development assistance received (current US$)"
  label variable gne "Gross national expenditure (current US$)"
  label variable gdp "GDP per capita (current US$)"
  label variable infd "Number of infant deaths"
  label variable ufd "Number of under-five deaths"
  label variable neod "Number of neonatal deaths"
  label variable matd "Number of maternal deaths"
  label variable hec "Health expenditure per capita (current US$)"
  label variable into "International tourism, number of arrivals"
  label variable meimp "Merchandise imports (current US$)"
  label variable meexp "Merchandise exports (current US$)"
  label variable inve "Investment in energy with private participation (current US$)"
  label variable invt "Investment in transport with private participation (current US$)"
  label variable tr "Tax revenue (current LCU)"
  label variable me "Military expenditure (current LCU)"
  label variable brd "Battle-related deaths (number of people)"
  label variable afp "Armed forces personnel, total"
  label variable airt "Air transport, registered carrier departures worldwide"
  label variable rail "Rail lines (total route-km)"
  label variable mob "Mobile cellular subscriptions"
  label variable fts "Fixed telephone subscriptions"
  label variable fbs "Fixed broadband subscriptions"

save wbdata, replace 
clear 


use govind
merge 1:1 countrycode year using wbdata
drop _merge
move countryname countrycode
save compositedata, replace
clear
***************analysis******************
use compositedata
log using description.log
describe
sum
log close
clear

use compositedata
//will nnot run because India , etc are not individual files but observations inside a variable
foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter fdi nod gne gnp year if countryname==`countryname'
graph save ecoon-`countryname',replace
}

foreach country in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter fdi nod gne gnp year if country==`country'
graph save ecoon-`country', replace
}

foreach country in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter va ge rq rl cc year if country==`country'
graph save gov-`country', replace
}
foreach country in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter tr me brd afp year if country==`country'
graph save pub-`country', replace
}
foreach country in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter into meimp meexp inve invt year if country==`country'
graph save pvt-`country', replace
}
foreach country in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter infd ufd neod matd hec year if country==`country'
graph save health-`country', replace
}

foreach country in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "Sri Lanka"{
scatter outchi epe ese tpe tse year if country==`country'
graph save edu-`country', replace
} 
  
  ********************
  
  
   
  
  
 