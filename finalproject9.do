//Shourjya Deb
//Data Management Final Project - 1st April, 2016

/* The project collates data from two sources one on governace indicators and
the other on public sector, private sector, health, education, economic growth and 
health indicators. The time period of the data is 2000-2004, was the period of the time the
NDA allaince was in power, effecient but communal in nature and this period is followed by the
2005-14 which corresponds with the rule of the UPA government in India, considered secular 
and progressive but highly corrupt in functioning. My intention is to compare the indicators 
mentioned above for all the countries and see where India stands in reference. Lastly I would 
want to check if there is a palpable effect of the governance indicators on the other
indicators in the Indian context and in the sub-continent context*/ 
 
 *******************regular commands******************************

clear //to clear previous memory
set matsize 10000 //to indicate the number of variable that can be a
version 14 //to indicate which version of stata has been used
set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\finalprojecttrial2"
cap mkdir `worDir'
cd `worDir'

***************data*****************

//link to wgidata set: http://info.worldbank.org/governance/wgi/index.aspx#home
//data on world wide governance indicators
//weblink: https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidata set.xlsx?attredirects=0&d=1
//downloads the governance indicators at one go

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
//saves the data as individual files

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

//appending the file to have all the governance indicators plugged in together

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
 
//world bank data download

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
//to isolate data for the indicators we want to use

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

//keeps data for the necessary timeline and drops other years
  
keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

//reshapes data

generate id=_n
reshape long yr,i(id)j(year)
drop id

//tweaking the name so that I ccan rename them later as per convenience

replace indicatorname=strtoname(indicatorname)
replace indicatorname=substr(indicatorname,1,20)

//last reshape to bring it in the format the governance indicators are in

reshape wide yr, i(countrycode year)j(indicatorname)string

//renames so that I can understand the variables while designing graphs and regressions
//labels for the variables
 
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

//merges governance indicators with all the other indicators

use govind
merge 1:1 countrycode year using wbdata
drop _merge
move countryname countrycode
save compositedata, replace
clear

//small change in how Sri Lanka is written so that there are no problems 
//while running loops due to the gap in between the country's name

use compositedata
replace countryname="SriLanka" if countryname=="Sri Lanka"
save compositedata, replace
clear

 
***************analysis******************
//describes the dataset as a whole, useful for later analysis

use compositedata
log using description.log
describe
sum
log close
clear

//graphs for countries with the economic indicators
use compositedata
foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "SriLanka"{
gr matrix fdi nod gne gdp year if countryname=="`countryname'",half 
graph save ecoon-`countryname',replace
}

//graphs for countries with the governance indicators

foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "SriLanka"{
gr matrix va ge rq rl cc year if countryname=="`countryname'",half 
graph save gov-`countryname',replace
}

//graphs for countries with the public sector indicators

foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "SriLanka"{
gr matrix tr me brd afp year if countryname=="`countryname'",half 
graph save pub-`countryname',replace
}

//graphs for countries with the private sector indicators
 
foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "SriLanka"{
gr matrix into meimp meexp inve invt year if countryname=="`countryname'",half 
graph save pvt-`countryname',replace
}

//graphs for countries with the health indicators

foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "SriLanka"{
gr matrix infd ufd neod matd hec year if countryname=="`countryname'",half 
graph save health-`countryname',replace
}

//graphs for countries with the educational indicators

foreach countryname in "India" "Pakistan" "Bangladesh" "Nepal" "Bhutan" "SriLanka"{
gr matrix outchi epe ese tpe tse year if countryname=="`countryname'",half 
graph save edu-`countryname',replace
}
clear

//regress goverance indicators on other indicators across all countries

use compositedata
regress va ge rq rl cc outchi epe ese tpe tse
outreg2 using govonothersall 
regress va ge rq rl cc fdi nod gne gdp
outreg2 using govonothersall
regress va ge rq rl cc infd ufd neod matd hec
outreg2 using govonothersall
regress va ge rq rl cc into meimp meexp inve invt
outreg2 using govonothersall
regress va ge rq rl cc tr me brd afp
outreg2 using govonothersall
regress va ge rq rl cc airt rail mob fts fbs
outreg2 using govonothersall
clear

// governance indicators across years for different countries

use compositedata
scatter va ge rq rl cc year if countryname=="Bangladesh"
graph save govontba, replace
scatter va ge rq rl cc year if countryname=="India"
graph save govonti, replace
scatter va ge rq rl cc year if countryname=="Pakistan"
graph save govontp, replace
scatter va ge rq rl cc year if countryname=="Nepal"
graph save govontnp, replace
scatter va ge rq rl cc year if countryname=="Bhutan"
graph save govontbh, replace
scatter va ge rq rl cc year if countryname=="SriLanka"
graph save govontsl, replace
clear

//regresses government indicators on other indicators to look for correlation

use compositedata 
regress cc outchi epe ese tpe tse if countryname=="India"
outreg2 using cconothersi
regress cc fdi nod gne gdp if countryname=="India"
outreg2 using cconothersi
regress cc infd ufd neod matd hec if countryname=="India"
outreg2 using cconothersi
regress cc into meimp meexp inve invt if countryname=="India"
outreg2 using cconothersi
regress cc tr me brd afp if countryname=="India"
outreg2 using cconothersi
regress cc airt rail mob fts fbs if countryname=="India"
outreg2 using cconothersi
clear
********************end of analysis******************

/* final interpretation 
1. On running regressions, I find that the education indicators are the only ones
which are showing a direct relation to corruption in the country - values are 
ommitted becuae of collineraity 
2. There are some indicators in the groups which have show negative effects as well
3. When we run regressions for the entire dataset the same collinearity is not present
4. The indicators Regulatory and Control of Corruption have remained low almost the
entire 10 years of the UPA rule,but it shows a very significant dip further in the
fag end of the time line, evenetually landing up at a point lower than that of the 
2000-2004 estimates
5. During the UPA time governance indicators have been lower than the NDA time period
6. In comparison to other countries governance and education indicators have suffered
as we traverse over the timeline      
  
  
   
  
  
 
