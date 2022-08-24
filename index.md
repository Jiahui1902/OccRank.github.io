## Welcome to the homepage for `OccRank`
`OccRank` is used to generate occupation percentile rank according to Song and Xie (2020). 

### Installation

From CRAN:
```
install.packages("OccRank")
```

From GitHub:
```
library(devtools)
install_github("jiahui1902/OccRank")
```

### Examples

#### Single occupation

For example, there is an occupation, "accountants and auditors" with 1970 census occ code

Mapping to 1950 occ code:

```
library(OccRank)
test1 <- occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 1950)
```

Mapping to 1990 occ code:
```
test2 <- occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 1990)
```

Mapping to 2010 occ code:
```
test3 <- occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 2010)
```

#### simulated data

Export table

```
sim_data <- data.frame(id = 1:3, occ = c(1,2,NA),birth_cohort = c(1960,1972,1971))
sim_data
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970, 
         output_year = 1950,export="table")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970, 
         output_year = 1990,export="table")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970, 
         output_year = 2010,export="table")
```


Export a vector of prank

```
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970, 
         output_year = 1950,export="prank")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970, 
         output_year = 1990,export="prank")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970, 
         output_year = 2010,export="prank")

```

#### GSS data

```
# load GSS 1972 data
data("gss1972")
# in GSS 1972, occupations are coded with 1970 census code. 
# Return the percentile rank by mapping the occupation code to 2010 census code
gss1972_occrank <- occ_rank(occ = gss1972$occ[1:10], cohort = gss1972$birthyr[1:10],
         input_year = 1970,
         output_year = 2010,export="table")
head(gss1972_occrank)
```


```
# load GSS 1989 data
data("gss1989")
# in GSS 1989, occupations are coded with 1980 census code. 
# Return the percentile rank by mapping the occupation code to 1990 census code
gss1989_occrank <- occ_rank(occ = gss1989$occ, cohort = gss1989$birthyr,
         input_year = 1980,
         output_year = 1990,export="table")
head(gss1989_occrank)
```

```
# with GSS 2018 data, occupations are coded with 2010 census code.
# Then the index are directly based on 2010 occupation code
data("gss2018")
gss2018_occrank <- occ_rank(occ = gss2018$occ10, cohort = gss2018$birthyr,
       input_year = 2010,export="table")
head(gss2018_occrank)

# only export the percentile rank
prank <- occ_rank(occ = gss2018$occ10[1:10], cohort = gss2018$birthyr[1:10],
       input_year = 2010,export="prank")
head(prank)
```

# plot the percentile ranks
```
# Accountants
occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
              input_year = 1970,
              output_year = 2010,plot_occ = 1)
```

```
# Shipping and receiving clerks
occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
              input_year = 1970,
              output_year = 2010,plot_occ = 374)
```
![alt text](./figures/figure1.png?raw=true "Static Visualization for the Estimated Results")

# if the occupation code is wrong
```
occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
              input_year = 1970,
              output_year = 2010,plot_occ = 800)
```



### References

Song, Xi, and Yu Xie. 2020. "Occupation-Based Socioeconomic Index with Percentile Ranks." *University of Pennsylvania Population Center Working Paper (PSC/PARC)*, 2020-59. https://repository.upenn.edu/psc_publications/59.

