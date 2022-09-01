#' Occupation Code and Occupation Titles
#'
#' A data set containing occupation code, title, and the year the occupational
#' code was coded.
#'
#' \itemize{
#'   \item occ Occupational codes.
#'   \item occ_desc Occupational titles.
#'   \item input The year occupations are coded (e.g., 1950, 1960, 1970, 1980,
#'   1990, 2000, 2010).
#' }
#'
#' @docType data
#' @keywords datasets
#' @name input_yearocc
#' @usage data(input_yearocc)
#' @format A data frame with 2,917 rows and 3 variables. This data is used for
#' internal functions in
#' extracting occupational titles.
NULL


#' Integrated Occupational Codes Crosswalk File
#'
#' An integrated crosswalk table mapping occupational codes from the input year
#' to the output year (i.e., 1950, 1990, and 2010).
#'
#' The variables are as follows:
#'
#' \itemize{
#'   \item year The input year of occupation code(s).
#'   \item dict1950 Crosswalk input occupation code(s) to the code(s) in census
#'   1950.
#'   \item dict1990 Crosswalk input occupation code(s) to the code(s) in census
#'   1990.
#'   \item dict2010 Crosswalk input occupation code(s) to the code(s) in census
#'   2010.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name year_refocc
#' @usage data(year_refocc)
#' @format A data frame with 17 rows and 4 variables
NULL

#' The General Social Survey 1972
#'
#' The general Social Survey (GSS) 1972 data.
#' The variables are as follows:
#'
#' \itemize{
#'   \item age Age of respondents.
#'   \item occ10 Census occupation code (2010).
#'   \item occ Census occupation code (1970).
#'   \item birthyr Birth cohort of respondents.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name gss1972
#' @usage data(gss1972)
#' @format A data frame with 1,613 rows and 4 variables
NULL

#' The General Social Survey 1989
#'
#' The general Social Survey (GSS) 1989 data.
#'
#' The variables are as follows:
#'
#' \itemize{
#'   \item age Age of respondents.
#'   \item occ10 Census occupation code (2010).
#'   \item occ Census occupation code (1970).
#'   \item occ80 Census occupation code (1980).
#'   \item birthyr Birth cohort of respondents.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name gss1989
#' @usage data(gss1989)
#' @format A data frame with 1,537 rows and 5 variables
NULL

#' The General Social Survey 2018
#'
#' The general Social Survey (GSS) 2018 data.
#'
#' The variables are as follows:
#'
#' \itemize{
#'   \item age Age of respondents.
#'   \item occ10 Census occupation code (2010).
#'   \item birthyr Birth cohort of respondents.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name gss2018
#' @usage data(gss2018)
#' @format A data frame with 2,348 rows and 3 variables
NULL


#' Occupational Percentile Rank for Census Occupations (1950)
#'
#' Occupational percentile rank for census occupations in 1950.
#'
#' The variables are as follows:
#'
#' \itemize{
#'   \item cohort Birth cohort
#'   \item occupation Occupation titles
#'   \item OCC1950 Census occupation code (1950)
#'   \item prank Calculated percentile rank
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ipums_data_occ1950_rank
#' @usage data(ipums_data_occ1950_rank)
#' @format A data frame with 5,033 rows and 4 variables
NULL




#' Occupational Percentile Rank for Census Occupations (1990)
#'
#' Occupational percentile rank for census occupations in 1990.
#' The variables are as follows:
#'
#' \itemize{
#'   \item OCC1990 Census occupation code (1990)
#'   \item Title Occupation titles
#'   \item cohort Birth cohort
#'   \item prank Calculated percentile rank
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ipums_data_occ1990_rank
#' @usage data(ipums_data_occ1990_rank)
#' @format A data frame with 3,940 rows and 4 variables
NULL



#' Occupational Percentile Rank for Census Occupations (2010)
#'
#' Occupational percentile rank for census occupations in 2010.
#' The variables are as follows:
#'
#' \itemize{
#'   \item OCC2010 Census occupation code (2010)
#'   \item Title Occupation titles
#'   \item cohort Birth cohort
#'   \item prank Calculated percentile rank
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ipums_data_occ2010_rank
#' @usage data(ipums_data_occ2010_rank)
#' @format A data frame with 4,650 rows and 13 variables
NULL


