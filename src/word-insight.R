#' Determine word frequency
#'
#' @param .data character vector of words
#'
#' @return numeric vector of word frequencies
word_freq <- function(.data){
  ## .data %>%
  ##   map_dbl(function(x){sum(x == .data, na.rm = TRUE)})
  .data %>%
  as_tibble %>%
  add_count(value) %>%
  mutate(n = if_else(is.na(value),
		     as.integer(NA),
		     n))  %>%
  .$n
}

#' Determine bigrams
#'
#' @param .data character vector of words
#'
#' @return character vector of bigrams
get_bigram <- function(.data){
  1:length(.data) %>%
    map_chr(index_bigram, .data, .data[-1])
	## mutate(bigram = paste(word, lead(word)))%>%
	## add_count(bigram) %>%
	## rename(bigram_freq = n)
}

#' get bigram at index i of list1 & 2
#'
#' @param i numeric index to attain bigram at
#'
#' @param list1 list or vector for first bigram token
#'
#' @param list2 list or vector for second bigram token
#'
#' @return bigram of list1 and list2 at index i, skipping NA's
index_bigram <- function(i, list1, list2){
  ifelse(length(list2) < i | is.na(list1[i]),
	  as.character(NA),
  ifelse(!(is.na(list1[i]) | is.na(list2[i])),
	 paste(list1[i], list2[i]),
	 index_bigram(i,list1, list2[-1])))
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

#' Determine AFINN sentiment of words
#'
#' @param std_tib
#' 
#' @return std_tib with additonal column of the sentiments of words
word_sentiment_AFINN <- function(std_tib){
    sentiments %>%
        filter(lexicon == "AFINN") %>%
        select(word, score) %>%
        right_join(std_tib, by="word")
}

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
