//the repo somewhat messy; filenames shouldnthave spaces;again: need more data!
//there arent't 300 lines! but rather 150 or so!!
//again: more data, more descriptive stats and more data exploration will add lines
//do stop by my office and email me if questions!
//this code is very inefficient--a lot unnecessary repetition--it could have been much more concise; it's likea as if lines are added just for a skae of adding lines

 //Shourjya Deb
 //Data Management Class Assignment 4 - 22nd Feb, 2015
 
 
 *******************regular commands******************************

clear //to clear previous memory

set matsize 10000 //to indicate the number of variable that can be a

version 14 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\4hw14"

cap mkdir `worDir'

cd  `worDir'

************getting data****************

wbopendata, language(en - English) country(IND;) topics() indicator()

save indiadata, replace

clear

use indiadata

drop if indicatorname != "GDP growth (annual %)"

save gdp, replace

clear

wbopendata, language(en - English) country() topics(4 - Education) indicator()

drop if countryname != "India"

save education, replace

drop if indicatorname !="Gross enrolment ratio, primary, gender parity index (GPI)" 

save gpi, replace

clear

use education 

drop if indicatorname !="Enrolment in primary education, both sexes (number)"

save enrol, replace

clear  

use education 

drop if indicatorname !="Gross enrolment ratio, primary, both sexes (%)"

save genrol, replace

clear

use education 

drop if indicatorname !="Enrolment in secondary education, both sexes (number)"

save enrolse, replace

clear

use education 

drop if indicatorname !="Unemployment, total (% of total labor force)"

save unemp, replace

clear

use education 

drop if indicatorname !="Youth literacy rate, population 15-24 years, both sexes (%)"

save ylit, replace

clear

use education 

drop if indicatorname !="Adult literacy rate, population 15+ years, both sexes (%)"

save alit, replace

clear

wbopendata, language(en - English) country() topics(15 - Social Development) indicator()

drop if countryname != "India"

save socdev, replace

clear

use socdev

drop if indicatorname !="Labor force participation rate for ages 15-24, total (%) (modeled ILO estimate)"

save lfpr, replace

clear

use socdev

drop if indicatorname !="Unemployment, female (% of female labor force)"

save unempf, replace

clear

use socdev

drop if indicatorname !="Unemployment, male (% of male labor force)"

save unempm, replace

clear

wbopendata, language(en - English) country() topics(10 - Social Protection & Labor) indicator()

drop if countryname !="India" 

save socpl, replace

clear

use socpl 

drop if indicatorname !="Unemployment, youth female (% of female labor force ages 15-24) (modeled ILO estimate)"

save unempyf, replace

clear

use socpl 

drop if indicatorname !="Unemployment, youth male (% of male labor force ages 15-24) (modeled ILO estimate)"

save unempym, replace

clear

use socpl 

drop if indicatorname !="Unemployment with primary education (% of total unemployment)"

save unemppe, replace

clear

************appending data sets to form two composite data sets*************

use gdp 
 
append using alit

save file1, replace

clear
//
use file1

append using enrol

save file2, replace

clear

use file2

append using enrolse

save file3, replace

clear

use file3

append using genrol

save file4, replace

clear

use file4

append using gpi

save file5, replace

clear

use file5

append using lfpr

save file6, replace

clear

use file6

append using unemp

save file7, replace

clear

use file7

append using unempf

save file8, replace

clear

use file8

append using unempm

save file9, replace

clear

use file9

append using unemppe

save file10, replace

clear

use file10

append using unempyf

save file11, replace

clear

use file11

append using unempym

save file12, replace

clear

use file12

append using ylit

save datasetwide, replace

clear

*****************changing data set shape************

use datasetwide

drop countryname countrycode iso2code region regioncode indicatorcode

drop yr1960 yr1961 yr1962 yr1963 yr1964 yr1965 yr1966 yr1967 yr1968 yr1969

drop yr1970 yr1971 yr1972 yr1973 yr1974 yr1975 yr1976 yr1977 yr1978 yr1979

drop yr1980 yr1981 yr1982 yr1983 yr1984 yr1985 yr1986 yr1987 yr1988 yr1989 yr1990

drop yr2013 yr2014 yr2015

save datasetw1, replace

clear

/*use datasetw1 

drop yr1996 yr1997 yr1998 yr1999 yr2000 yr2001 yr2002 yr2003 yr2004 yr2005

drop yr2006 yr2007 yr2008 yr2009 yr2010 yr2011 yr2012

save datasetw2, replace

clear*/

use datasetw1

xpose, clear varname

save datasettl1, replace

xpose, clear 

use datasettl1, clear

move _varname v1

drop if _varname == "indicatorname"

rename _varname Year

rename v1 gdpgrowth

rename v2 adultlit 

rename v3 enrolmentprimaryedu

rename v4 enrolmentsecedu

rename v5 grossenrolmentprimary

rename v6 grossenrolmentprimaryp 

rename v7 labourforceparticipation

rename v8 unemploymentboth

rename v9 unemplymentf

rename v10 unemploymentm

rename v11 unemploymentwithpe

rename v12 unemplymentyouthf

rename v13 unemplymentyouthm

rename v14 youthlitrate

save datasetl2, replace

clear

use datasetl2, clear

label variable gdpgrowth "GDP growth (annual %)"

label variable adultlit "Adult literacy rate, population 15+ years, both sexes (%)"

label variable enrolmentprimaryedu "Enrolment in primary education, both sexes (number)"

label variable enrolmentsecedu "Enrolment in secondary education, both sexes (number)"

label variable grossenrolmentprimary "Gross enrolment ratio, primary, both sexes (%)" 

label variable grossenrolmentprimaryp "Gross enrolment ratio, primary, gender parity index (GPI)"

label variable labourforceparticipation "Labor force participation rate for ages 15-24, total (%) (modeled ILO estimate)"

label variable unemploymentboth "Unemployment, total (% of total labor force)"

label variable unemplymentf "Unemployment, female (% of female labor force)"

label variable unemploymentm "Unemployment, male (% of male labor force)"

label variable unemploymentwithpe "Unemployment with primary education (% of total unemployment)"

label variable unemplymentyouthf "Unemployment, youth female (% of female labor force ages 15-24) (modeled ILO estimate)"

label variable unemplymentyouthm "Unemployment, youth male (% of male labor force ages 15-24) (modeled ILO estimate)"

label variable youthlitrate "Youth literacy rate, population 15-24 years, both sexes (%)"

clear

*************regressions with macros************

use datasetl2, clear

local m1 adultlit youthlitrate

local m2 enrolmentprimaryedu enrolmentsecedu

local m3 labourforceparticipation unemploymentm

local m4 unemplymentyouthf unemplymentyouthm

local m5 unemplymentf unemploymentm

regress gdpgrowth `m1'

regress gdpgrowth `m2'

regress gdpgrowth `m3'

regress gdpgrowth `m4'

regress gdpgrowth `m5'

clear


*************loops************ 

use datasetl2, clear

foreach y in enrolmentprimaryedu enrolmentsecedu {
regress `y' grossenrolmentprimary grossenrolmentprimaryp
}


foreach y in grossenrolmentprimary grossenrolmentprimaryp {
regress `y' unemplymentf unemploymentm
}

foreach y in unemplymentf unemploymentm {
regress `y' unemplymentyouthf unemplymentyouthm
}

foreach y in enrolmentprimaryedu enrolmentsecedu grossenrolmentprimary {
foreach x in unemploymentwithpe unemplymentyouthf unemplymentyouthm {
regress `y' `x'
}
}

**************if then**************
 use datasetl2, clear

 forval i=1/22{
   if gdpgrowth[`i']>5 {
   display "high gdp growth in `i'"
   display "primary enrolement" enrolmentprimaryedu[`i'] 
   display "secondary enrolment" enrolmentsecedu [`i']
   
   }
   else {
   display "low GDP growth in `i'"
   display "unemoplyment in males" unemploymentm[`i']
   display "unemployment in females" unemplymentf[`i']
      }
}

*************************************************************   
   
 

 
 
   
   
   
   
   
   
   
   
   
   
   
   
   
   



















