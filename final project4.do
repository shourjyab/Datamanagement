
 //Shourjya Deb
 //Data Management Final Project - 1st April, 2016
 
*******************regular commands******************************

clear //to clear previous memory
set matsize 10000 //to indicate the number of variable that can be a
version 14 //to indicate which version of stata has been used
set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience
local worDir "C:\Users\DURGA\Desktop\unendingtorture3"
cap mkdir `worDir'
cd  `worDir'

***************data*****************

//link to wgidata set: http://info.worldbank.org/governance/wgi/index.aspx#home

//data on world wide governance indicators

//weblink: https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1

//data for voice and accountability
import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("VoiceandAccountability")
drop in 1/13
keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
drop in 1/2
drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
reshape long yr, i(countrycode)j(var)
renvars var yr\year va
label variable countrycode "code used to denote country in dataset"
label variable year "the year of osbervation"
label variable country "name of country"
label variable va "voice and accountability estimate"
save voacc, replace
clear

//data for political stability
import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("Political StabilityNoViolence")
drop in 1/13
keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
drop in 1/2
drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
reshape long yr, i(countrycode)j(var)
renvars var yr\year ps
label variable countrycode "code used to denote country in dataset"
label variable year "the year of osbervation"
label variable country "name of country"
label variable ps "political stability estimate"
save polst, replace
clear

//data for government effectiveness

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("GovernmentEffectiveness")
drop in 1/13
keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
drop in 1/2
drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
reshape long yr, i(countrycode)j(var)
renvars var yr\year ge
label variable countrycode "code used to denote country in dataset"
label variable year "the year of osbervation"
label variable country "name of country"
label variable ge "government effectiveness estimate"
save govef, replace
clear

//data for regulatory quality
import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("RegulatoryQuality")
drop in 1/13
keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
drop in 1/2
drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
reshape long yr, i(countrycode)j(var)
renvars var yr\year rq
label variable countrycode "code used to denote country in dataset"
label variable year "the year of osbervation"
label variable country "name of country"
label variable rq "regulatory quality estimate"
save regqu, replace
clear

//data for rule of law
import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("RuleofLaw")
drop in 1/13
keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
drop in 1/2
drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
reshape long yr, i(countrycode)j(var)
renvars var yr\year rl
label variable countrycode "code used to denote country in dataset"
label variable year "the year of osbervation"
label variable country "name of country"
label variable rl "rule of law estimate"
save rulelaw, replace
clear

//date for control of corruption
import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("ControlofCorruption")
drop in 1/13
keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO
renvars A B O U AA AG AM AS AY BE BK BQ BW CC CI CO\country countrycode yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
drop in 1/2
drop if country!="INDIA" & country!="BANGLADESH" & country!="SRI LANKA" & country!="NEPAL" & country!="BHUTAN" & country!="PAKISTAN"
destring yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014, replace
reshape long yr, i(countrycode)j(var)
renvars var yr\year cc
label variable countrycode "code used to denote country in dataset"
label variable year "the year of osbervation"
label variable country "name of country"
label variable cc "control of corruption estimate"
save concup, replace
clear

//combining governance indicators

use voacc, clear
merge 1:1 countrycode year using polst
drop _merge
merge 1:1 countrycode year using govef
drop _merge
merge 1:1 countrycode year using regqu
drop _merge
merge 1:1 countrycode year using rulelaw
drop _merge
merge 1:1 countrycode year using concup
drop _merge
save govind, replace
clear

//data on education
wbopendata, language(en - English) country() topics(4 - Education) indicator()
keep countryname countrycode indicatorname yr2000 yr2002 yr2003 yr2004 yr2005 yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012 yr2013 yr2014
rename countryname country
drop if country!="India" & country!="Bangladesh" & country!="Pakistan" & country!="Sri Lanka" & country!="Nepal" & country!="Bhutan" 
drop if indicatorname!= "Out-of-school children of primary school age, both sexes (number)" /// 
& indicatorname!="Enrolment in primary education, both sexes (number)" /// 
& indicatorname!="Enrolment in secondary education, both sexes (number)" /// 
& indicatorname!="Teachers in primary education, both sexes (number)" /// 
& indicatorname!="Teachers in secondary education, both sexes (number)" 

reshape long yr, i(countrycode)j(var)
