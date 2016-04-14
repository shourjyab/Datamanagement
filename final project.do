 //Shourjya Deb
 //Data Management Final Project - 1st April, 2016
 
 
 *******************regular commands******************************

clear //to clear previous memory

set matsize 10000 //to indicate the number of variable that can be a

version 14 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\fp2try"

cap mkdir `worDir'

cd  `worDir'

***************data*****************

//link to wgidata set: http://info.worldbank.org/governance/wgi/index.aspx#home

//data on world wide governance indicators

//weblink: https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("VoiceandAccountability")

save roughfile, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
 
drop in 1/2

drop if country!="INDIA"

destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace

xpose, clear varname

move _varname v1

drop in 1/2

renvars _varname v1\ year voiacc

save voacc, replace

clear

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("Political StabilityNoViolence") 

save roughfile1, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
 
drop in 1/2

drop if country!="INDIA"

destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace

xpose, clear varname

move _varname v1

drop in 1/2

renvars _varname v1\ year polstb

save polstbv, replace 

clear

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("GovernmentEffectiveness") 

save roughfile2, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
 
drop in 1/2

drop if country!="INDIA"

destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace

xpose, clear varname

move _varname v1

drop in 1/2

renvars _varname v1\ year goef

save goveff, replace 

clear

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("RegulatoryQuality") 

save roughfile3, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
 
drop in 1/2

drop if country!="INDIA"

destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace

xpose, clear varname

move _varname v1

drop in 1/2

renvars _varname v1\ year requ

save regq, replace 

clear 

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("RuleofLaw") 

save roughfile4, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
 
drop in 1/2

drop if country!="INDIA"

destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace

xpose, clear varname

move _varname v1

drop in 1/2

renvars _varname v1\ year rol

save rulelaw, replace 

clear

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("ControlofCorruption") 

save roughfile5, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
 
drop in 1/2

drop if country!="INDIA"

destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace

xpose, clear varname

move _varname v1

drop in 1/2

renvars _varname v1\ year cc

save concorup, replace 

clear

//world bank data on education 

wbopendata, language(en - English) country() topics(4 - Education) indicator()

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

keep if countryname=="India"

drop if indicatorname!= "Out-of-school children of primary school age, both sexes (number)" ///
& indicatorname!="Enrolment in primary education, both sexes (number)" ///
& indicatorname!="Enrolment in secondary education, both sexes (number)" ///
& indicatorname!="Teachers in primary education, both sexes (number)" ///
& indicatorname!="Teachers in secondary education, both sexes (number)" ///

drop countryname countrycode

xpose, clear varname

move _varname v1

renvars _varname v1 v2 v3 v4 v5\year outchi epe ese tpe tse 

drop in 1

label variable year "the year of osbervation"

label variable outchi "Out-of-school children of primary school age, both sexes (number)"

label variable epe "Enrolment in primary education, both sexes (number)"

label variable ese "Enrolment in secondary education, both sexes (number)"

label variable tpe "Teachers in primary education, both sexes (number)"

label variable tse "Teachers in secondary education, both sexes (number)" 

save educ, replace

clear 

//world bank data on economy and growth

wbopendata, language(en - English) country() topics(3 - Economy & Growth) indicator() 

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

keep if countryname=="India"

drop countryname countrycode

drop if indicatorname!="Foreign direct investment, net inflows (BoP, current US$)" & indicatorname!="GDP per capita (current US$)" & indicatorname!="Foreign direct investment, net inflows (BoP, current US$)" & indicatorname!="Gross national expenditure (current US$)" & indicatorname!="Net official development assistance received (current US$)"

xpose, clear varname

move _varname v1

renvars _varname v1 v2 v3 v4 \year fdi nod gne gnp   

drop in 1

label variable year "the year of osbervation"

label variable fdi "Foreign direct investment, net inflows (BoP, current US$)"

label variable nod "Net official development assistance received (current US$)"

label variable gne "Gross national expenditure (current US$)"

label variable gnp "GDP per capita (current US$)"

save econgro, replace

clear 

//world bank data on health

wbopendata, language(en - English) country() topics(8 - Health) indicator()

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

keep if countryname=="India"

drop countryname countrycode

drop if indicatorname!="Number of infant deaths" & indicatorname!="Number of under-five deaths" & indicatorname!="Number of neonatal deaths" & indicatorname!="Number of maternal deaths" & indicatorname!="Health expenditure per capita (current US$)"

xpose, clear varname

move _varname v1

renvars _varname v1 v2 v3 v4 v5 \year infd ufd neod matd hec   

drop in 1

label variable year "the year of osbervation"

label variable infd "Number of infant deaths"

label variable ufd "Number of under-five deaths"

label variable neod "Number of neonatal deaths"

label variable matd "Number of maternal deaths"

label variable hec "Health expenditure per capita (current US$)"

save health, replace

clear  

//world bank data on private sector 

wbopendata, language(en - English) country() topics(12 - Private Sector) indicator()

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

keep if countryname=="India"

drop countryname countrycode

drop if indicatorname!="International tourism, number of arrivals" & indicatorname!="Merchandise imports (current US$)" & indicatorname!="Merchandise exports (current US$)" & indicatorname!="Number of maternal deaths" & indicatorname!="Investment in energy with private participation (current US$)" & indicatorname!="Investment in transport with private participation (current US$)"

xpose, clear varname

move _varname v1

renvars _varname v1 v2 v3 v4 v5 \year into meimp meexp inve invt   

drop in 1

label variable year "the year of osbervation"

label variable into "International tourism, number of arrivals"

label variable meimp "Merchandise imports (current US$)"

label variable meexp "Merchandise exports (current US$)"

label variable inve "Investment in energy with private participation (current US$)"

label variable invt "Investment in transport with private participation (current US$)"

save pvtsec, replace

clear  

//world bank data on public sector

wbopendata, language(en - English) country() topics(13 - Public Sector) indicator()

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

keep if countryname=="India"

drop countryname countrycode

drop if indicatorname!="Tax revenue (current LCU)" & indicatorname!="Military expenditure (current LCU)" & indicatorname!="Battle-related deaths (number of people)" & indicatorname!="Armed forces personnel, total" 

xpose, clear varname

move _varname v1

renvars _varname v1 v2 v3 v4\year tr me brd afp   

drop in 1

label variable year "the year of osbervation"

label variable tr "Tax revenue (current LCU)"

label variable me "Military expenditure (current LCU)"

label variable brd "Battle-related deaths (number of people)"

label variable afp "Armed forces personnel, total"

save pubsec, replace

clear 

//world bank data on infrastructure 

wbopendata, language(en - English) country() topics(9 - Infrastructure) indicator()

keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014

keep if countryname=="India"

drop countryname countrycode

drop if indicatorname!="Air transport, registered carrier departures worldwide" & indicatorname!="Rail lines (total route-km)" & indicatorname!="Mobile cellular subscriptions" & indicatorname!="Fixed telephone subscriptions" & indicatorname!="Fixed broadband subscriptions" 

xpose, clear varname

move _varname v1

renvars _varname v1 v2 v3 v4 v5\year airt rail mob fts fbs   

drop in 1

label variable year "the year of osbervation"

label variable airt "Air transport, registered carrier departures worldwide"

label variable rail "Rail lines (total route-km)"

label variable mob "Mobile cellular subscriptions"

label variable fts "Fixed telephone subscriptions"

label variable fbs "Fixed broadband subscriptions"

save infra, replace

clear 

****************************************************************************
****merging****
//m1 = merger of voacc & polstbv
//m2 = merger of voacc,polstbv & goveff
//m3 = merger of voacc,polstbv,goveff & regq
//m4 = merger of voacc,polstbv,goveff,regq & rulelaw
//govinda = merger of voacc,polstbv,goveff,regq,rulelaw & concurup
//govinda contains all the governance indicators

use voacc

merge 1:1 year using polstbv

drop _merge

save m1, replace

clear

use m1

merge 1:1 year using goveff

drop _merge

save m2, replace

clear

use m2

merge 1:1 year using regq

drop _merge

save m3, replace

clear

use m3

merge 1:1 year using rulelaw

drop _merge

save m4, replace

clear

use m4

merge 1:1 year using concorup

drop _merge

label variable voiacc "Voice and Accountability"

label variable  polstb"Political Stability and No Violence"

label variable goef "Government Effectiveness"

label variable requ "Regularity Quality"

label variable rol "Rule of Law"

label variable cc "Control of corruption"

save govinda,replace

clear

*********merging to form final dataset***************
// govinda - contains all governance indicators
// educ - contains all education indicators indicators
//econgro - contains all economic growth indicators
//health - contains all health indicators
//pvtsec - contains all private sector indicators
//pubsec - contains all public sector indicators
//infra - contains all infrastructure indicators
//mm1 - merger of govinda & educ
//mm2 - merger of govinda,educ & econgro
//mm3 - merger of govinda,educ,econgro & health
//mm4 - merger of govinda,educ,econgro,health & pvtsec
//mm5 - merger of govinda,educ,econgro,health,pvtsec & pubsec
// finaldat - merger of govinda,educ,econgro,health,pvtsec,pubsec & infra

use govinda 

merge 1:1 year using educ

drop _merge

save mm1, replace

clear

use mm1

merge 1:1 year using econgro

drop _merge

save mm2, replace

clear

use mm2

merge 1:1 year using health

drop _merge

save mm3, replace

clear

use mm3

merge 1:1 year using pvtsec

drop _merge

save mm4, replace

clear

use mm4

merge 1:1 year using pubsec

drop _merge

save mm5, replace

clear

use mm5

merge 1:1 year using infra 

drop _merge

save finaldat, replace 

clear

use finaldat

generate timeline = 2000

replace timeline = 2002 in 2

replace timeline = 2003 in 3

replace timeline = 2004 in 4

replace timeline = 2005 in 5

replace timeline = 2006 in 6

replace timeline = 2007 in 7

replace timeline = 2008 in 8

replace timeline = 2009 in 9

replace timeline = 2010 in 10

replace timeline = 2011 in 11

replace timeline = 2012 in 12

replace timeline = 2013 in 13

replace timeline = 2014 in 14

move timeline voiacc

save indiadata, replace 
 
************************************************************************
*************analysis*************

use indiadata

tsset timeline

clear

//log file to produce a list of variables & summary statistics 

use indiadata 

log using destats.log

describe 

sum

log close

//descriptive graphs 

//graph to see changes in governance indicators over time

use indiadata

scatter voiacc polstb goef requ rol cc timeline

save graph govont

clear

//graph to see changes in education indicators over time

use indiadata

scatter outchi epe ese tpe tse

save graph educont

clear

//graph to see changes in economic growth indicators over time

use indiadata

scatter fdi nod gne gnp

save graph econgont

clear

//graph to see changes in health indicators over time

use indiadata

scatter infd ufd neod matd hec

save graph healthont 

clear

//graph to see changes in private sector indicators

use indiadata

scatter into meimp meexp inve invt

save graph pvtsecont 

clear

//graph to see changes in public sector indicators

use indiadata

scatter tr me brd afp

save graph pubsecont 

clear

//graph to see changes in infrastructure indicators

use indiadata

scatter airt rail mob fts fbs

save graph infraont 

clear

//for regression do regressions then outreg2 using myreg.doc 

//connection of governance with other indicators 

use indiadata 

regress voiacc polstb goef requ rol cc outchi epe ese tpe tse

regress voiacc polstb goef requ rol cc fdi nod gne gnp

regress voiacc polstb goef requ rol cc infd ufd neod matd hec

regress voiacc polstb goef requ rol cc into meimp meexp inve invt

regress voiacc polstb goef requ rol cc tr me brd afp

regress voiacc polstb goef requ rol cc airt rail mob fts fbs

outreg2 using govonothers

clear
 
****************************************************************************

