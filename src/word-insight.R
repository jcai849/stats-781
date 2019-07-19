#' Determine word frequency
#'
#' @param .data character vector of words
#'
#' @return numeric vector of word frequencies
word_freq <- function(.data){
  ## .data %>%
  ##   map_dbl(function(x){sum(x == .data, na.rm = TRUE)})
  .data %>%
  enframe %>%
  add_count(value) %>%
  mutate(n = if_else(is.na(value),
		     as.integer(NA),
		     n))  %>%
  pull(n)
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

#' Determine textrank score for vector of words
#'
#' @param .data character vector of words
#'
#' @return vector of scores for each word
keywords_tr <- function(.data){
  relevent <- !is.na(.data)
  tr <- textrank_keywords(.data, relevent, p=+Inf)
  score <- tr$pagerank$vector %>% enframe
  data <- .data %>% enframe("number", "name")
  full_join(data, score, by="name") %>%
    pull(value)
}

#' Determine AFINN sentiment of words
#'
#' @param .data vector of words
#'
#' @param lexicon sentiment lexicon to use, based on the corpus
#'   provided by tidytext
#' 
#' @return vector with sentiment score of each word in the vector
word_sentiment <- function(.data, lexicon="AFINN"){
  data <- enframe(.data, "number", "word")
    sentiments %>%
      filter(lexicon == !! lexicon) %>%
      select(word, score) %>%
      right_join(data, by="word") %>%
      pull(score)
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
