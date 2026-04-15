capture log close

*** After downloading the reposity and verifying its setup is correct (contains "original datasets" and "intermediate datasets" subfolders), update the global root path to the path of the downloaded reposity on your machine
global root "C:\Users\ebw26\Box\ECON 388 Stata\Data Assignment 3"

** no need to change **
global orig  "$root\original datasets"
global inter "$root\intermediate datasets"
log using "$root\Data_Assignment_3_log.txt", replace text

/*

ECON 388 STATA EXERCISE TEMPLATE

  Use this template DO file as the
  basis for all Stata exercises.

  For each assignment, make sure to
  enter your name and the problem 
  set number in the appropriate
  spaces below.

NAME: Ben Widgren

DATA ASSIGNMENT #3


  Begin your do file in the space 
  below the stars, adding additional
  lines as needed */

************************************
* choose directory
cd "$orig"

*** Clean Datasets Before Merging ***

* clean the census data
import delimited "co-est2020-alldata", clear
keep if sumlev == 50
keep state county popestimate2020
gen county_fips = state*1000 + county
drop state county

cd "$inter"
save "census_cleaned.dta", replace

* prepare ZIP_COUNTY dataset to merge with hpi data
cd "$orig"
import excel "ZIP_COUNTY_122020.xlsx", firstrow clear
drop BUS_RATIO OTH_RATIO TOT_RATIO
gen zip3_str = substr(ZIP, 1, 3)
* in a county, keep the zip with largest RES_RATIO to represent that county
bysort zip3_str (RES_RATIO): keep if _n==_N

cd "$inter"
save "zip_county.dta", replace

* prepare hpi_at_zip3 for merge
cd "$orig"
import excel "hpi_at_zip3.xlsx", cellrange(A6) firstrow clear
keep if (Year==2020 | Year==2021)
drop HPI HPIwith1990base HPIwith2000base G
gen zip3_str = string(ThreeDigitZIPCode, "%03.0f")

cd "$inter"
save "hpi_at_zip3_2020_2021.dta", replace

* merge the two to add county codes to 3 digit zip observation in hpi_at_zip3 data
merge m:1 zip3_str using "zip_county.dta"
drop if Year==.
drop ThreeDigitZIPCode zip3_str ZIP RES_RATIO _merge
destring COUNTY, replace
rename COUNTY county_fips
save "county_hpi.dta", replace

* merge the census data to county_hpi data
merge m:1 county_fips using census_cleaned.dta
drop _merge
drop if Year==.
save "county_hpi_population.dta", replace

* import covid data and merge with county_hpi_population dataset
cd "$orig"
import delimited "us-counties-2020", clear
rename fips county_fips
* keep the last row for each county to get yearly totals for each county
bysort county_fips (date): keep if _n==_N

cd "$inter"
save "county_covid_deaths_2020.dta", replace

* merge with county_hpi_population dataset
use "county_hpi_population.dta", clear
merge m:1 county_fips using "county_covid_deaths_2020.dta"
drop _merge date
drop if popestimate2020==.
order state county county_fips popestimate2020 AnnualChange Year cases deaths
sort county_fips Year

* reshape so 2020 AnnualChange can be used as a control in the regression
* requires collapsing per county bc of the 3-digit ZIP approximations made earlier
collapse (mean) AnnualChange deaths popestimate2020, by(county_fips Year)
reshape wide AnnualChange, i(county_fips) j(Year)

* generate 2020 county COVID mortality rate
gen mort_rate = (deaths / popestimate2020) * 100000

cd "$root"
save "covid_county_mortality.dta", replace

* regression
reg AnnualChange2021 mort_rate AnnualChange2020

* histograms
sum mort_rate if mort_rate < 400
histogram mort_rate if mort_rate < 400, frequency ///
    title("Distribution of County COVID-19 Mortality Rate, 2020") ///
    xtitle("Deaths per 100,000 Population") ///
    ytitle("Number of Counties") ///
    note("Mean = `: display %5.2f r(mean)', SD = `: display %5.2f r(sd)', n = 753." ///
         "One county omitted from display (mort_rate = 763.07) for visual clarity. Included in all analyses.")
graph export "$root\hist_mort_rate.png", replace

sum AnnualChange2021
histogram AnnualChange2021, frequency ///
    title("Distribution of County HPI Annual Change, 2021") ///
    xtitle("Annual HPI Change (%)") ///
    ytitle("Number of Counties") ///
    note("Mean = `: display %5.2f r(mean)', SD = `: display %5.2f r(sd)', n = 754")
graph export "$root\hist_AnnualChange2021.png", replace

* summary statistics on other variables
sum mort_rate AnnualChange2021 AnnualChange2020 popestimate2020, detail

*This line should always be at the end
log close
