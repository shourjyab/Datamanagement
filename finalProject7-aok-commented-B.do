/*aok: take into account initial comments from A file; and this file shows
alternative way of doing things--i am sure there are other ways too--and you */
/*pick whichever way you like; the only thing is that there is way too much */
/*repretition and the code must be tighter/more efficient--eithr need to use */
/*loops or ado programs, something; otherwhise this is great!

guess specifically for you the thing to keep in mind is to have look at code
 after you have written it and find ways of simplifying it/making more
 efficient; otherwhise all good

and one more thing per descriptive stats; and related to this:
your code is kind of automatic/robot-like

instead of mechanistic

use compositedata
scatter fdi nod gne gnp year if country=="INDIA"
graph save ecoonti, replace
scatter fdi nod gne gnp year if country=="NEPAL"
graph save ecoontnp, replace
scatter fdi nod gne gnp year if country=="PAKISTAN"
graph save ecoontp, replace
scatter fdi nod gne gnp year if country=="SRI LANKA"
graph save ecoontsl, replace
scatter fdi nod gne gnp year if country=="BHUTAN"
graph save ecoontbh, replace
scatter fdi nod gne gnp year if country=="BANGLADESH"
graph save ecoontba, replace
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="INDIA"
regress va ge rq rl cc fdi nod gne gnp if country=="INDIA"
regress va ge rq rl cc infd ufd neod matd hec if country=="INDIA"
regress va ge rq rl cc into meimp meexp inve invt if country=="INDIA"
regress va ge rq rl cc tr me brd afp if country=="INDIA"
regress va ge rq rl cc airt rail mob fts fbs if country=="INDIA"
outreg2 using govonothersi
clear


just run fewer, but ones that make substantive sense--find sopmething
 interesting AND interpret results

now, it is totally fine to be mechanistic, robot-like, but then need to loop say

foreach country in "INDIA" "etc"{
scatter fdi nod gne gnp year if country==`country'
graph save ecoon-`country', replace
}

and then still have few graphs that make substantive sense!
and interpet them
*/


 //Shourjya Deb
 //Data Management Final Project - 1st April, 2016
 
 
 *******************regular commands******************************

clear //to clear previous memory
set matsize 10000 //to indicate the number of variable that can be a
version 14 //to indicate which version of stata has been used
set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\fpttrial3"
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
 
  
cap program drop ado1
program define ado1
 drop countryname countrycode 
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
end

cap program drop ado2
program define ado2
  drop in 1 
  drop _varname
  generate year=2000
  replace year = 2002 in 2
  replace year = 2003 in 3
  replace year = 2004 in 4
  replace year = 2005 in 5
  replace year = 2006 in 6
  replace year = 2007 in 7
  replace year = 2008 in 8
  replace year = 2009 in 9
  replace year = 2010 in 10
  replace year = 2011 in 11
  replace year = 2012 in 12
  replace year = 2013 in 13
  replace year = 2014 in 14
 end


//india
wbopendata, language(en - English) country() topics(4 - Education) indicator()
save edui, replace
clear
wbopendata, language(en - English) country() topics(3 - Economy & Growth) indicator()
save econgroi, replace
clear
wbopendata, language(en - English) country() topics(8 - Health) indicator()
save healthi, replace
clear
wbopendata, language(en - English) country() topics(12 - Private Sector) indicator()
save pvtseci, replace
clear
wbopendata, language(en - English) country() topics(13 - Public Sector) indicator()
save pubseci, replace
clear 
wbopendata, language(en - English) country() topics(9 - Infrastructure) indicator()
save infrai, replace
clear


foreach file in "edui" "econgroi" "healthi" "pvtseci" "pubseci" "infrai" {
foreach country in "India" "etc" "etc"  {
  use `file', clear
  keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
  keep if countryname==`country'
  ado1 
  xpose, clear varname
  ado2  
  save `file'-`country', replace
  clear
}  


//aok
//######then continue from here--rewrite the following to match the past accordingly



///// labelling variables 
//education data

foreach file in "edui" "eduba" "edusl" "edunp" "edubh" "edupk" {
  use `file', clear
  move year v1
  renvars v1 v2 v3 v4 v5\outchi epe ese tpe tse
  label variable outchi "Out-of-school children of primary school age, both sexes (number)"
  label variable epe "Enrolment in primary education, both sexes (number)"
  label variable ese "Enrolment in secondary education, both sexes (number)"
  label variable tpe "Teachers in primary education, both sexes (number)"
  label variable tse "Teachers in secondary education, both sexes (number)"
  save `file', replace
  clear
}
  ////economic growth
  
foreach file in "econgroi" "econgroba" "econgrosl" "econgronp" "econgrobh" "econgropk" {
  use `file', clear
  move year v1
  renvars v1 v2 v3 v4 \fdi nod gne gnp
  label variable year "the year of osbervation"
  label variable fdi "Foreign direct investment, net inflows (BoP, current US$)"
  label variable nod "Net official development assistance received (current US$)"
  label variable gne "Gross national expenditure (current US$)"
  label variable gnp "GDP per capita (current US$)"
  save `file', replace
  clear
}  
/// health 
foreach file in "healthi" "healthba" "healthsl" "healthnp" "healthbh" "healthpk" {
  use `file', clear
  move year v1
  renvars v1 v2 v3 v4 v5 \infd ufd neod matd hec 
  label variable infd "Number of infant deaths"
  label variable ufd "Number of under-five deaths"
  label variable neod "Number of neonatal deaths"
  label variable matd "Number of maternal deaths"
  label variable hec "Health expenditure per capita (current US$)"   
  save `file', replace
  clear
  }
  
  /// private sector 
 foreach file in "pvtseci" "pvtsecba" "pvtsecsl" "pvtsecnp" "pvtsecbh" "pvtsecpk" {
  use `file', clear
  move year v1
  renvars v1 v2 v3 v4 v5 \into meimp meexp inve invt   
  label variable into "International tourism, number of arrivals"
  label variable meimp "Merchandise imports (current US$)"
  label variable meexp "Merchandise exports (current US$)"
  label variable inve "Investment in energy with private participation (current US$)"
  label variable invt "Investment in transport with private participation (current US$)"
  save `file', replace
  clear
} 
  
/// public sector 
 foreach file in "pubseci" "pubsecba" "pubsecsl" "pubsecnp" "pubsecbh" "pubsecpk" {
  use `file', clear
  move year v1
  renvars v1 v2 v3 v4\tr me brd afp   
  label variable tr "Tax revenue (current LCU)"
  label variable me "Military expenditure (current LCU)"
  label variable brd "Battle-related deaths (number of people)"
  label variable afp "Armed forces personnel, total"
  save `file', replace
  clear
} 
 

/// infra 
 foreach file in "infrai" "infraba" "infrasl" "infranp" "infrabh" "infrapk" {
  use `file', clear
  move year v1
  renvars v1 v2 v3 v4 v5\airt rail mob fts fbs    
  label variable airt "Air transport, registered carrier departures worldwide"
  label variable rail "Rail lines (total route-km)"
  label variable mob "Mobile cellular subscriptions"
  label variable fts "Fixed telephone subscriptions"
  label variable fbs "Fixed broadband subscriptions"
  save `file', replace
  clear
}

///add india 
foreach file in "edui" "econgroi" "healthi" "pvtseci" "pubseci" "infrai" {
  use `file', clear
  gen str20 country="INDIA"
  save `file', replace
  clear
}

// bangladesh
foreach file in "eduba" "econgroba" "healthba" "pvtsecba" "pubsecba" "infraba" {
  use `file', clear
  gen str20 country="BANGLADESH"
  save `file', replace
  clear
}

//sri lanka 
foreach file in "edusl" "econgrosl" "healthsl" "pvtsecsl" "pubsecsl" "infrasl" {
  use `file', clear
  gen str20 country="SRI LANKA"
  save `file', replace
  clear
}

// nepal 
foreach file in "edunp" "econgronp" "healthnp" "pvtsecnp" "pubsecnp" "infranp" {
  use `file', clear
  gen str20 country="NEPAL"
  save `file', replace
  clear
}
// bhutan 
foreach file in "edubh" "econgrobh" "healthbh" "pvtsecbh" "pubsecbh" "infrabh" {
  use `file', clear
  gen str20 country="BHUTAN"
  save `file', replace
  clear
}
// pakitsan 

foreach file in "edupk" "econgropk" "healthpk" "pvtsecpk" "pubsecpk" "infrapk" {
  use `file', clear
  gen str20 country="PAKISTAN"
  save `file', replace
  clear
}

//// appending
use infraba
append using infrabh
append using infrai  
append using infrasl
append using infranp
append using infrapk 
save infrast, replace
clear

use pubsecba
append using pubsecbh
append using pubseci  
append using pubsecsl
append using pubsecnp
append using pubsecpk 
save publicsector, replace
clear

use pvtsecba
append using pvtsecbh
append using pvtseci  
append using pvtsecsl
append using pvtsecnp
append using pvtsecpk 
save privatesector, replace
clear

use healthba
append using healthbh
append using healthi  
append using healthsl
append using healthnp
append using healthpk 
save health, replace
clear

use eduba
append using edubh
append using edui  
append using edusl
append using edunp
append using edupk 
save education, replace
clear

use econgroba
append using econgrobh
append using econgroi  
append using econgrosl
append using econgronp
append using econgropk 
save economicgrowth, replace
clear

//merging 

use govind
merge 1:1 country year using infrast
drop _merge
merge 1:1 country year using publicsector
drop _merge
merge 1:1 country year using privatesector
drop _merge
merge 1:1 country year using health
drop _merge
merge 1:1 country year using education
drop _merge
merge 1:1 country year using economicgrowth
drop _merge
save compositedata, replace
clear

******************************analysis******************************

//contains description and summarize results, helps while writing code
//for graphs

use compositedata
log using description.log
describe
sum
log close
clear 

// looks at governance indicators against time for each country 

use compositedata
scatter va ge rq rl cc year if country=="BANGLADESH"
graph save govontba, replace
scatter va ge rq rl cc year if country=="INDIA"
graph save govonti, replace
scatter va ge rq rl cc year if country=="PAKISTAN"
graph save govontp, replace
scatter va ge rq rl cc year if country=="NEPAL"
graph save govontnp, replace
scatter va ge rq rl cc year if country=="BHUTAN"
graph save govontbh, replace
scatter va ge rq rl cc year if country=="SRI LANKA"
graph save govontsl, replace
clear

use compositedata
scatter tr me brd afp year if country=="INDIA"
graph save pubonti, replace
scatter tr me brd afp year if country=="NEPAL"
graph save pubontnp, replace
scatter tr me brd afp year if country=="PAKISTAN"
graph save pubontp, replace
scatter tr me brd afp year if country=="SRI LANKA"
graph save pubontsl, replace
scatter tr me brd afp year if country=="BHUTAN"
graph save pubontbh, replace
scatter tr me brd afp year if country=="BANGLADESH"
graph save pubontba, replace
clear 

use compositedata
scatter into meimp meexp inve invt year if country=="INDIA"
graph save pvtonti, replace
scatter into meimp meexp inve invt year if country=="NEPAL"
graph save pvtontnp, replace
scatter into meimp meexp inve invt year if country=="PAKISTAN"
graph save pvtontp, replace
scatter into meimp meexp inve invt year if country=="SRI LANKA"
graph save pvtontsl, replace
scatter into meimp meexp inve invt year if country=="BHUTAN"
graph save pvtontbh, replace
scatter into meimp meexp inve invt year if country=="BANGLADESH"
graph save pvtontba, replace
clear 

use compositedata
scatter infd ufd neod matd hec year if country=="INDIA"
graph save healthonti, replace
scatter infd ufd neod matd hec year if country=="NEPAL"
graph save healthontnp, replace
scatter infd ufd neod matd hec year if country=="PAKISTAN"
graph save healthontp, replace
scatter infd ufd neod matd hec year if country=="SRI LANKA"
graph save healthontsl, replace
scatter infd ufd neod matd hec year if country=="BHUTAN"
graph save healthontbh, replace
scatter infd ufd neod matd hec year if country=="BANGLADESH"
graph save healthontba, replace
clear 

use compositedata
scatter outchi epe ese tpe tse year if country=="INDIA"
graph save eduonti, replace
scatter outchi epe ese tpe tse year if country=="NEPAL"
graph save eduontnp, replace
scatter outchi epe ese tpe tse year if country=="PAKISTAN"
graph save eduontp, replace
scatter outchi epe ese tpe tse year if country=="SRI LANKA"
graph save eduontsl, replace
scatter outchi epe ese tpe tse year if country=="BHUTAN"
graph save eduontbh, replace
scatter outchi epe ese tpe tse year if country=="BANGLADESH"
graph save eduontba, replace
clear

use compositedata
scatter fdi nod gne gnp year if country=="INDIA"
graph save ecoonti, replace
scatter fdi nod gne gnp year if country=="NEPAL"
graph save ecoontnp, replace
scatter fdi nod gne gnp year if country=="PAKISTAN"
graph save ecoontp, replace
scatter fdi nod gne gnp year if country=="SRI LANKA"
graph save ecoontsl, replace
scatter fdi nod gne gnp year if country=="BHUTAN"
graph save ecoontbh, replace
scatter fdi nod gne gnp year if country=="BANGLADESH"
graph save ecoontba, replace
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="INDIA"
regress va ge rq rl cc fdi nod gne gnp if country=="INDIA"
regress va ge rq rl cc infd ufd neod matd hec if country=="INDIA"
regress va ge rq rl cc into meimp meexp inve invt if country=="INDIA"
regress va ge rq rl cc tr me brd afp if country=="INDIA"
regress va ge rq rl cc airt rail mob fts fbs if country=="INDIA"
outreg2 using govonothersi
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="PAKISTAN"
regress va ge rq rl cc fdi nod gne gnp if country=="PAKISTAN"
regress va ge rq rl cc infd ufd neod matd hec if country=="PAKISTAN"
regress va ge rq rl cc into meimp meexp inve invt if country=="PAKISTAN"
regress va ge rq rl cc tr me brd afp if country=="PAKISTAN"
regress va ge rq rl cc airt rail mob fts fbs if country=="PAKISTAN"
outreg2 using govonothersp
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="BANGLADESH"
regress va ge rq rl cc fdi nod gne gnp if country=="BANGLADESH"
regress va ge rq rl cc infd ufd neod matd hec if country=="BANGLADESH"
regress va ge rq rl cc into meimp meexp inve invt if country=="BANGLADESH"
regress va ge rq rl cc tr me brd afp if country=="BANGLADESH"
regress va ge rq rl cc airt rail mob fts fbs if country=="BANGLADESH"
outreg2 using govonothersba
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="BHUTAN"
regress va ge rq rl cc fdi nod gne gnp if country=="BHUTAN"
regress va ge rq rl cc infd ufd neod matd hec if country=="BHUTAN"
regress va ge rq rl cc into meimp meexp inve invt if country=="BHUTAN"
regress va ge rq rl cc tr me brd afp if country=="BHUTAN"
regress va ge rq rl cc airt rail mob fts fbs if country=="BHUTAN"
outreg2 using govonothersbh
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="SRI LANKA"
regress va ge rq rl cc fdi nod gne gnp if country=="SRI LANKA"
regress va ge rq rl cc infd ufd neod matd hec if country=="SRI LANKA"
regress va ge rq rl cc into meimp meexp inve invt if country=="SRI LANKA"
regress va ge rq rl cc tr me brd afp if country=="SRI LANKA"
regress va ge rq rl cc airt rail mob fts fbs if country=="SRI LANKA"
outreg2 using govonotherssl
clear

use compositedata 
regress va ge rq rl cc outchi epe ese tpe tse if country=="NEPAL"
regress va ge rq rl cc fdi nod gne gnp if country=="NEPAL"
regress va ge rq rl cc infd ufd neod matd hec if country=="NEPAL"
regress va ge rq rl cc into meimp meexp inve invt if country=="NEPAL"
regress va ge rq rl cc tr me brd afp if country=="NEPAL"
regress va ge rq rl cc airt rail mob fts fbs if country=="NEPAL"
outreg2 using govonothersnp
clear

use compositedata
scatter va ge rq rl cc year, mlabel(country)
graph save govontall, replace
scatter tr me brd afp year, mlabel(country)
graph save pubontall, replace
scatter into meimp meexp inve invt year, mlabel(country)
graph save pvtontall, replace
scatter infd ufd neod matd hec year, mlabel(country)
graph save infraontall, replace 
scatter outchi epe ese tpe tse year, mlabel(country)
graph save eduontall, replace
scatter fdi nod gne gnp year, mlabel(country)
graph save econontall, replace
clear

use compositedata
regress va ge rq rl cc outchi epe ese tpe tse
regress va ge rq rl cc fdi nod gne gnp
regress va ge rq rl cc infd ufd neod matd hec
regress va ge rq rl cc into meimp meexp inve invt
regress va ge rq rl cc tr me brd afp
regress va ge rq rl cc airt rail mob fts fbs
outreg2 using govonothersall
clear
**************************************************************



