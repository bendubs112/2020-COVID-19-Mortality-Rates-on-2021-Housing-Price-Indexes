# 2020-COVID-19-Mortality-Rates-on-2021-Housing-Price-Indexes
An econometric analysis of 2020 county-level per-capita COVID-19 mortality rates on county-level housing prices in 2021.

**Research Question:** What effect did county-level per-capita COVID-19 mortality rates in 2020 have on housing prices in 2021?

---

## Raw Data Files (`original datasets/`)

| # | File | Description | Source |
|---|------|-------------|--------|
| 1 | `us-counties-2020.csv` | County-day COVID-19 cases and deaths, aggregated to 2020 yearly totals | [New York Times](https://www.nytimes.com/article/coronavirus-county-data-us.html) |
| 2 | `co-est2020-alldata.csv` | County-level 2020 population estimates from the U.S. Census Bureau | [Census Bureau](https://www.census.gov/programs-surveys/popest/technical-documentation/research/evaluation-estimates/2020-evaluation-estimates/2010s-counties-total.html) |
| 3 | `hpi_at_zip3.xlsx` | Annual house price index by 3-digit ZIP code from the FHFA | [FHFA](https://www.fhfa.gov/hpi/download/annual/hpi_at_zip3.xlsx) |
| 4 | `ZIP_COUNTY_122020.xlsx` | ZIP-to-county crosswalk, Q4 2020, from HUD | [HUD](https://www.huduser.gov/portal/datasets/usps_crosswalk.html) |

---

## Code and Output Files

| # | File | Description |
|---|------|-------------|
| 1 | `Data_Assignment_3.do` | Stata do-file that reads all raw data, cleans and merges into a final analysis dataset, and runs the regression. To replicate, change the global `root` macro on line 2 to your local path of the repository. |
| 2 | `Data_Assignment_3_log.txt` | Log file produced by the do-file showing all results. |
| 3 | `covid_county_mortality.dta` | Final dataset created by cleaning and merging above datasets, used for econemetric analysis. |
| 4 | `hist_mort_rate.png` | Histogram of county COVID-19 mortality rate, 2020. |
| 5 | `hist_AnnualChange2021.png` | Histogram of county HPI annual change, 2021. |
| 6 | `README.md` | This file. |

---

## Note

The final dataset "covid_county_mortality.dta" is sufficient to run the code that executes the econometric analysis. If running the code that creates this dataset from the raw data files is desired, first download those datasets to the appropriate directory and execute the code.
