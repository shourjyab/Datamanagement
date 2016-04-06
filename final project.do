 //Shourjya Deb
 //Data Management Class Assignment 4 - 22nd Feb, 2015
 
 
 *******************regular commands******************************

clear //to clear previous memory

set matsize 10000 //to indicate the number of variable that can be a

version 14 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically

********************* directory****************

//change directory location as per convenience

local worDir "C:\Users\DURGA\Desktop\final project"

cap mkdir `worDir'

cd  `worDir'

***************data*****************

//link to wgidata set: http://info.worldbank.org/governance/wgi/index.aspx#home

//data uplaaoded on google site

//weblink: https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1

//save in the ssame directory: "C:\Users\DURGA\Desktop\final project"

import excel using "https://sites.google.com/a/scarletmail.rutgers.edu/shourjyadatamanagement/wgidataset/wgidataset.xlsx?attredirects=0&d=1", sheet("VoiceandAccountability")

save roughfile, replace

drop in 1/13

keep A B O U AA AG AM AS AY BE BK BQ BW CC CI CO

//question - can the renaming process be done more effciently using macros? 
//am waiting here, because whatever I do here can be utilized to work with 2 more sheets from this data set?? 

rename A country

rename B countrycode

rename O yr2000 

rename U yr2002 

rename AA yr2003 

rename AG yr2004 

rename AM yr2005
 
rename AS yr2006 

rename AY yr2007 

rename BE yr2008 

rename BK yr2009 

rename BQ yr2010 

rename BW yr2011 

rename CC yr2012 

rename CI yr2013 

rename CO yr2014 

drop in 1/2

drop if country!="INDIA"

save vacc, replace
 


 