README
ECON 388 Data Assignment 3
Ben Widgren

Research Question: What effect did county-level per-capita Covid-19 mortality
rates in 2020 have on housing prices in 2021?

==========================================================================
RAW DATA FILES (original datasets/)
==========================================================================

1. us-counties-2020.csv
   Description: County-day Covid-19 cases and deaths, aggregated to 2020
                yearly totals
   Source: https://www.nytimes.com/article/coronavirus-county-data-us.html

2. co-est2020-alldata.csv
   Description: County-level 2020 population estimates from the U.S.
                Census Bureau
   Source: https://www.census.gov/programs-surveys/popest/technical-
           documentation/research/evaluation-estimates/2020-evaluation-
           estimates/2010s-counties-total.html

3. hpi_at_zip3.xlsx
   Description: Annual house price index by 3-digit ZIP code from the FHFA
   Source: https://www.fhfa.gov/hpi/download/annual/hpi_at_zip3.xlsx

4. ZIP_COUNTY_122020.xlsx
   Description: ZIP-to-county crosswalk, Q4 2020, from HUD
   Source: https://www.huduser.gov/portal/datasets/usps_crosswalk.html

==========================================================================
CODE AND OUTPUT FILES
==========================================================================

1. Data_Assignment_3.do
   Description: Stata .do file that reads all raw data, cleans and merges
                into a final analysis dataset, and runs the regression.
                In order to replicate, change the global root macro on line 2 to
                your local path of the repository.

2. Data_Assignment_3_log.txt
   Description: Log file produced by the do-file showing all results.

3. README.txt
   Description: This file.

==========================================================================
NOTE
==========================================================================

The intermediate datasets/ folder is included in this repository for
reference but is not needed to replicate the results. The do-file
generates all intermediate files automatically when run.