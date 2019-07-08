#' create a group-aware visualisation
#'
#' @param std_tib the standard dataframe, modified so the last column
#'     is the output of some insight function (eg. output from
#'     word_freq)
#'
#' @param vis visualisation function
#'
#' @param ... visualisation function arguments
get_vis <- function(std_tib, operation, ...){
    if (is_grouped_df(std_tib)){
        grouping <- group_vars(std_tib)
        std_tib %>%
            operation(...) + facet_wrap(syms(grouping), scales="free_x", labeller = "label_both") #
    } else {
        std_tib %>%
            operation(...)
    }
}

#' output a histogram of the distribution of some function of words
#'
#' @param std_tib the standard dataframe, modified so the last column
#'     is the output of some insight function (eg. output from
#'     word_freq)
#'
#' @param insight_col string name of the column insight was
#'     performed on
word_dist <- function(std_tib, insight_col){
std_tib %>%
    ggplot(aes(x = !! sym(insight_col))) +
    geom_density()
}

#' output a bar graph of the top words from some insight function
#'
#' @param std_tib the standard dataframe, modified so the last column
#'     is the output of some insight function (eg. output from
#'     word_freq)
#'
#' @param insight_name string name of the column insight
#'     was performed on
#' 
#' @param insight_col string name of the column insight was
#'     outputted to
#'
#' @param n number of bars to display
#'
#' @param desc bool: show bars in descending order
#'
word_bar <- function(std_tib, insight_name, insight_col,
                     n = 15, desc = TRUE){
    std_tib %>%
        distinct(word, .keep_all=TRUE) %>%
        arrange(rank) %>%
        group_modify(~{.x %>% head(n)})%>%
        ungroup() %>%
        mutate(!! sym(insight_name) := fct_reorder(!! sym(insight_name),
                                                   !! sym(insight_col),
                                                   .desc = desc)) %>%
        ggplot(aes(x = !! sym(insight_name))) +
        geom_col(aes(y = !! sym(insight_col)))
}
