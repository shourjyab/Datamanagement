//Shourjya Deb
//Data Management Class Assignment 1 - 4th Feb, 2015
/* 1. find data set, 2. open and read data set into Stata 3. save in three different formats 4. use descriptive statistics */
//
//
// link location http://www.icpsr.umich.edu/cgi-bin/bob/terms2?study=22626&ds=2&bundle=&path=ICPSR
// didn't use the link because it's a zipfile, downloaded, extracted and then used to be safe

clear //to clear previous memory

set matsize 700 //to indicate the number of variable that can be a

version 12 //to indicate which version of stata has been used

set more off // to run without pressing more options - runs automatically

//opening the .dta file from the file option
use "D:\stata code and datasets\data 2\ICPSR_20520\ICPSR_20520\DS0001\20520-0001-Data.dta", clear
(Children of Immigrants Longitudinal Study (CILS), 1991-2006)

// demonstration of how to use a log file
cap log close // to ensure that errors are fixe and prod doesn't stop working due to the error
set type logtext // sets text format for logfile
log using "logfilefordatman1.txt", text append

// now I can do whatever function - for ex I run the sum command
sum // gives descriptive statistics for all the variables - point 4 completed
log close // closes the log file 

// the summary of stats will be saved in the logfile, saved in documents
// point 1 completed, data set found
edit //data set opens up on stata on a different window
// point 2 completed
//opening file again 
use "D:\stata code and datasets\data 2\ICPSR_20520\ICPSR_20520\DS0001\20520-0001-Data.dta", clear
(Children of Immigrants Longitudinal Study (CILS), 1991-2006)
//saving the file 

save "D:\stata code and datasets\data 2\ICPSR_20520\ICPSR_20520\DS0001\datman1-1.dta"
file D:\stata code and datasets\data 2\ICPSR_20520\ICPSR_20520\DS0001\datman1-1.dta saved

// reopening the file
use "D:\stata code and datasets\data 2\ICPSR_20520\ICPSR_20520\DS0001\datman1-1.dta", clear
(Children of Immigrants Longitudinal Study (CILS), 1991-2006)

// lists out variables
list


//tab file format
// Not sure about the explanations of the commands 
/*the outsheet command is used to open a file called the datmantab1 */
outsheet using datman1tab 
/* the type command produces file datman1tab which is tab separated */
/* the .out after the filename indicates that file is in tab separate format */ 
type datman1tab.out


// comma file format . csv
/* outsheet opens the file called datman2.csv */
//by adding comma function we can save it as comma separated file
outsheet using datman2.csv, comma
type datman2.csv

//space separated file
//.raw file is for data to be separated by space  
outfile using datman1.raw
type datman1.raw

//point 3 completed



 

