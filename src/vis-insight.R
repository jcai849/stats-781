#' output a histogram of the distribution of some function of words
#'
#' @param std_tib the standard dataframe, modified so the last column
#'     is the output of some insight function (eg. output from
#'     word_freq)
#'
#' @param insight_col non-standard eval name of the column insight was
#'     performed on
word_hist <- function(std_tib, insight_col){
std_tib %>%
    ggplot(aes(x = !! enquo(insight_col))) +
    geom_histogram()
}

#' output a bar graph of the top words from some insight function
#'
#' @param std_tib the standard dataframe, modified so the last column
#'     is the output of some insight function (eg. output from
#'     word_freq)
#'
#' @param insight_name non-standard eval name of the column insight
#'     was performed on
#' 
#' @param insight_col non-standard eval name of the column insight was
#'     outputted to
#'
#' @param n number of bars to display
#'
#' @param desc bool: show bars in descending order
#'
word_bar <- function(std_tib, insight_name, insight_col,
                     n = 15, desc = TRUE){
std_tib %>%
    distinct(!! enquo(insight_name), .keep_all = TRUE) %>%
    arrange(desc(!! enquo(insight_col))) %>%
    top_n(n, !! enquo(insight_col)) %>%
    mutate(!! enquo(insight_name) := fct_reorder(!! enquo(insight_name),
                                                 !! enquo(insight_col),
                                                 .desc = desc)) %>%
    ggplot(aes(x = !! enquo(insight_name))) +
    geom_col(aes(y = !! enquo(insight_col)))

}
