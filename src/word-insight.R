#' perform group-aware operation on the standard dataframe
#'
#' @param std_tib the standard dataframe given as the output of the format_data function
#'
#' @param operation insight function to be performed on the dataframe
#'
#' @return grouped output from the operation
get_insight <- function(std_tib, operation){
    std_tib %>%
        group_modify(~ {
            .x %>%
                operation
        })
}
