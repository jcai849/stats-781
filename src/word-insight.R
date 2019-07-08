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

#' Determine word frequency
#'
#' @param std_tib the standard dataframe given as per the import functions
#'
#' @return std_tib with an additional column of counts.
word_freq <- function(std_tib){
    std_tib %>%
        add_count(word) %>%
        rename(word_freq = n)
}

#' Determine bigram frequency
#'
#' @param std_tib the standard dataframe given as per the import functions
#'
#' @return std_tib with an additional column of associated bigrams for each word and their counts
bigram_freq <- function(std_tib){
    std_tib %>%
        mutate(bigram = paste(word, lead(word)))%>%
        add_count(bigram) %>%
        rename(bigram_freq = n)
}

#' Determine keyword ranking
#'
#' @param std_tib the standard dataframe given as per the import functions
#'
#' @return std_tib with additional columns of the textrank keyword
#'     ranking (rank) and pagerank score (pagerank)
keywords_tr <- function(std_tib){
    tr <- std_tib$word  %>%
        textrank_keywords()
    kw <- tibble(word = names(tr$pagerank$vector),
           pagerank = tr$pagerank$vector) %>%
        arrange(desc(pagerank)) %>%
        mutate(rank = row_number())
    return(full_join(std_tib, kw, by="word"))
}

#' Determine correlation between words within a given group
#'
#' @param std_tib the standard dataframe given as per the import functions
#'
#' @param within_group group within which to calculate pairwise correlation between words
#'
#' @return non_std_tib; dataframe with two word columns, and a column of their pairwise correlation coefficients
## word_corr


