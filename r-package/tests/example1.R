library(OccRank)
library(haven)
library(ggplot2)
# single observation
occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 1950)
occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 1990)
occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 2010)

# simulation data
sim_data <- data.frame(id = 1:4, occ = c(1,1,2,NA),birth_cohort = c(1960,1974,1972,1971))
sim_data

# export index table
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970,
         output_year = 1950,export="table")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970,
         output_year = 1990,export="table")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970,
         output_year = 2010,export="table")

# export a vector of occupation percentile rank
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970,
         output_year = 1950,export="prank")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970,
         output_year = 1990,export="prank")
occ_rank(occ = sim_data$occ, cohort = sim_data$birth_cohort, input_year = 1970,
         output_year = 2010,export="prank")

# test with gss data
data("gss1972")
# input year is 1972 and output year is 2010
# check data
head(gss1972)
gen_prank1 <- occ_rank(occ = gss1972$occ, cohort = gss1972$birthyr,
         input_year = 1970,
         output_year = 2010,export="table")
head(gen_prank1)

# add the generated occupation rank to the input data
gss1972$occ_prank <- occ_rank(occ = gss1972$occ, cohort = gss1972$birthyr,
                       input_year = 1970,
                       output_year = 2010,export="prank")
head(gss1972)

data("gss1989")
gen_prank2 <- occ_rank(occ = gss1989$occ80, cohort = gss1989$birthyr,
         input_year = 1980,
         output_year = 1990,export="table")

data("gss2018")
gen_prank3 <- occ_rank(occ = gss2018$occ10, cohort = gss2018$birthyr,
         input_year = 2010,
         output_year = 2010,export="table")



# plot the percentile ranks
# Accountants
occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
              input_year = 1970,
              output_year = 2010,plot_occ = 1)

# Shipping and receiving clerks
occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
              input_year = 1970,
              output_year = 2010,plot_occ = 374)

# if the occupation code is wrong
# Do not run
# occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
#               input_year = 1970,
#               output_year = 2010,plot_occ = 800)

