
#' Visualizing and exploring the returned occupation percentile rank
#' @inheritParams occ_rank
#' @param plot_occ pick up an occupation and plot the percentile ranks in
#' different birth cohort in the existing data
#' @return occupation index or a data frame including all detailed information
#' @examples
#' library(OccRank)
#' library(haven)
#'
#' # load data
#' data("gss1972")
#' # mapping to 2010 occupation code and visualize the percentile rank for
#' # selected occupations
#' # Accountants
#' occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
#'               input_year = 1970,
#'               output_year = 2010,plot_occ = 1)
#'
#' # Shipping and receiving clerks
#' occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
#'               input_year = 1970,
#'               output_year = 2010,plot_occ = 374)
#' # if the occupation code is wrong, there will be an error message
#' # Do not run:
#' occ_rank_plot(occ = gss1972$occ, cohort = gss1972$birthyr,
#'               input_year = 1970,
#'                 output_year = 2010,plot_occ = 800)
#'
#' @export
#' @import ggplot2
#' @importFrom stats na.omit

occ_rank_plot <- function(occ, cohort, input_year, output_year,
                          plot_occ=NULL){
  prank <- occ_rank(occ, cohort,
           input_year,
           output_year,
           export="table")
  if(!(plot_occ%in%prank$input_occ)){
    message("Error: Not a valid occupation code")
  }else{
  ggplot2::ggplot(na.omit(prank[prank$input_occ == plot_occ,]),aes(x = cohort, y = prank))+
    geom_point()+
    geom_line()+
    ylim(c(0,100))+
    theme_classic()+
    labs(x = "Birth Cohort",
         y = "Percentile Rank",
         title = unique(na.omit(prank[prank$input_occ==plot_occ,
                                      "input_description"])),
         subtitle = paste(output_year,"occ description:",
                          unique(na.omit(prank[prank$input_occ==plot_occ,
                                               "output_description"]))))+
    scale_x_continuous(breaks = sort(na.omit(prank[prank$input_occ == plot_occ,"cohort"])),
                       labels = sort(na.omit(prank[prank$input_occ == plot_occ,"cohort"])))+
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5))
    }
}


