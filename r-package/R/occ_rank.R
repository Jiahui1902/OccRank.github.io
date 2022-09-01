#' Constructing an occupation-based socioeconomic index that can easily incorporate occupational structure changes
#' with the method proposed by Song and Xie (2020).
#'
#' @param occ occupation code in the input year
#' @param cohort birth cohort
#' @param input_year input year of occupational code(s), e.g., 1950, 1960, 1970, 1980, 1990, 2000, 2010.
#' @param output_year The year occupational code(s) is/are crosswalked to, can only be 1950, 1990, and 2010
#' @param export the format of returned results, "prank" or "table". If NULL, the default is "prank",
#' a vector of occupation percentile rank(s) for input occupation(s). Otherwise, "table" returns a data
#' frame including input year, input occupational code(s), output year, output occupational code(s), and
#' percentile rank(s) for the specified occupation(s).
#' @return occupational index or a data frame including all detailed information.
#' @examples
#' library(OccRank)
#' library(haven)
#' occ_rank(occ = 2, cohort = 1970, input_year = 1970, output_year = 1950)
#' occ_rank(occ = 2, cohort = 1970, input_year = 1970,
#'          output_year = 1950,export="table")
#' occ_rank(occ = 2, cohort = 1970, input_year = 1970,
#'          output_year = 1950,export="prank")
#'
#' # with GSS 1972 data, occopations are coded with 1970 census code:
#' data("gss1972")
#' # mapping to 2010 occupation code and export a data frame showing the
#' # detailed information about code mapping and occ percentile rank
#' # check data
#' head(gss1972)
#' gen_prank1 <- occ_rank(occ = gss1972$occ, cohort = gss1972$birthyr,
#'                        input_year = 1970,
#'                        output_year = 2010,export="table")
#' head(gen_prank1)
#'
#' # add the generated occupation rank to the input data
#' gss1972$occ_prank <- occ_rank(occ = gss1972$occ, cohort = gss1972$birthyr,
#'                               input_year = 1970,
#'                               output_year = 2010,export="prank")
#' head(gss1972)
#'
#' # with GSS 1989 data, occupations are coded with 1980 census code:
#' data("gss1989")
#'  # mapping 1980 code to 1990 and export the percentile rank
#' gen_prank2 <- occ_rank(occ = gss1989$occ80, cohort = gss1989$birthyr,
#'          input_year = 1980,
#'          output_year = 1990,export="prank")
#' head(gen_prank2)
#'
#' # with GSS 2018 data, occupations are coded with 2010 census code.
#' # Then the index are directly based on 2010 occupation code
#' data("gss2018")
#' gen_prank3 <- occ_rank(occ = gss2018$occ10, cohort = gss2018$birthyr,
#'         input_year = 2010,
#'         output_year = 2010,export="table")
#' head(gen_prank3)
#' @export
#' @import haven

occ_rank <- function(occ, cohort, input_year, output_year,
                     export = "prank"){
  # load data
  ipums_data_occ1950_rank <- OccRank::ipums_data_occ1950_rank
  ipums_data_occ1990_rank <- OccRank::ipums_data_occ1990_rank
  ipums_data_occ2010_rank <- OccRank::ipums_data_occ2010_rank
  year_refocc <- OccRank::year_refocc
  input_yearocc <- OccRank::input_yearocc

  # if the occupation code is already in 1950, 1990, or 2010,
  # directly use the corresponding year to get the occupation index
  if(input_year==1950|input_year==1990|input_year==2010){
     output_year <- input_year
  }

  # otherwise, map occupation code to the year of 1950, 1990, or 2010
  # in this case, users must specify which year they would like to map to
  # occ description in input year
  occ. <- occ <- as.numeric(occ)
  occ_des <- suppressMessages(dplyr::left_join(data.frame(occ=occ,input=input_year),input_yearocc, na_matches = "never")$occ_desc)

  # update occ code to the output year: 1 input year and 1 output year (ask this?)
  occdict <- year_refocc[year_refocc$year==input_year,paste0("dict",output_year)]
  occdict <- tidyr::unnest(occdict,cols = paste0("dict",output_year))
  occ <- suppressMessages(as.numeric(dplyr::left_join(data.frame(input=occ),occdict, na_matches = "never")$output))


  # map to 1950
  if(output_year==1950){
  cohort. <- ifelse(cohort%%10>=6,ceiling(cohort/10)*10,floor(cohort/10)*10)
  cohort.. <- cohort

  occ_index <- data.frame(output_occ = occ, cohort = cohort.,input_occ = occ.)
  occ_index <- suppressMessages(dplyr::left_join(occ_index,ipums_data_occ1950_rank,by=c("output_occ"="OCC1950","cohort"="cohort"),na_matches = "never"))
  occ_index$input_year <- input_year
  occ_index$output_year <- output_year
  occ_index$input_description = occ_des
  occ_index$output_description = occ_index$occupation
  occ_index$occupation=NULL

  occ_index <- dplyr::select(occ_index,cohort,input_occ,input_year,input_description,
                                  output_occ,output_year,output_description,
                                  prank)


  if(length(occ)==1){
  # display occupation index on the screen only if there is only one occupation
  cat(c("occupation index:","\n",
        "cohort:",cohort..,"\n",
        "occ code 1950:",occ_index$output_occ,"\n",
        "percentile rank:",sprintf("%.2f",occ_index$prank),"\n",
        "occ description:",occ_index$output_description,"\n"))}
  }

  # map to 1990
  if(output_year==1990){
    cohort. <- ifelse(cohort%%10>=6,ceiling(cohort/10)*10,floor(cohort/10)*10)
    cohort.. <- cohort

    occ_index <- data.frame(output_occ = occ, cohort = cohort.,input_occ = occ.)
    occ_index <- suppressMessages(dplyr::left_join(occ_index,ipums_data_occ1990_rank,by=c("output_occ"="OCC1990","cohort"="cohort"),na_matches = "never"))
    occ_index$input_year <- input_year
    occ_index$output_year <- output_year
    occ_index$input_description = occ_des
    occ_index$output_description = occ_index$Title
    occ_index$Title=NULL

    occ_index <- dplyr::select(occ_index,cohort,input_occ,input_year,input_description,
                               output_occ,output_year,output_description,
                               prank)

    if(length(occ)==1){
      # display occupation index on the screen only if there is only one occupation
    cat(c("occupation index:","\n",
          "cohort:",cohort..,"\n",
          "occ code 1990:",occ_index$output_occ,"\n",
          "percentile rank:",sprintf("%.2f",occ_index$prank),"\n",
          "occ description:",occ_index$output_description,"\n"))}
  }

  # map to 2010
  if(output_year==2010){
    cohort. <- ifelse(cohort%%10>=6,ceiling(cohort/10)*10,floor(cohort/10)*10)
    cohort.. <- cohort

    occ_index <- data.frame(output_occ = occ, cohort = cohort.,input_occ = occ.)
    occ_index <- suppressMessages(dplyr::left_join(occ_index,ipums_data_occ2010_rank,by=c("output_occ"="OCC2010","cohort"="cohort"),na_matches = "never"))
    occ_index$input_year <- input_year
    occ_index$output_year <- output_year
    occ_index$input_description = occ_des
    occ_index$output_description = occ_index$Title
    occ_index$Title=NULL

    occ_index <- dplyr::select(occ_index,cohort,input_occ,input_year,input_description,
                               output_occ,output_year,output_description,
                               prank)

    if(length(occ)==1){
    # display occupation index on the screen only if there is only one occupation
    cat(c("occupation index:","\n",
          "cohort:",cohort..,"\n",
          "occ code 2010:",occ_index$output_occ,"\n",
          "percentile rank:",sprintf("%.2f",occ_index$prank),"\n",
          "occ description:",occ_index$output_description,"\n"))}
  }

  # return results: a data frame (tibble) for later calculation or a vector of prank
  if(export == "table"){return(occ_index)}
  if(export == "prank"){return(occ_index$prank)}
}

# occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 1950)
# occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 1990)
# occ_rank(occ = 1, cohort = 1970, input_year = 1970, output_year = 2010)

