#' Determine the number of words at each aggregate level
#'
#' @param .data character vector of words
#'
#' @param aggregate_on vector to split .data on for insight
#'
#' @return vector of number of words for each aggregate level, same
#'   length as .data
word_count <- function(.data, aggregate_on){
  split(.data, aggregate_on) %>%
    map(function(x){rep(length(x), length(x))}) %>%
    combine()
}

#' get score for key sentences as per Lexrank
#'
#' @param .data character vector of words
#'
#' @param aggregate_on vector to aggregate .data over; ideally, sentence_id
key_sentences <- function(.data, aggregate_on){
  ## prepare .data for lexrank
  base <-  tibble(word = !! .data, aggregate = aggregate_on)
  aggregated <- base %>%
    group_by(aggregate) %>%
    na.omit() %>%
    summarise(sentence = paste(word, collapse = " ")) %>%
    dplyr::mutate(sentence = paste0(sentence, "."))
  ## lexrank
  lr <- aggregated %>%
    dplyr::pull(sentence) %>%
    lexRank(., n=length(.),removePunc = FALSE, returnTies = FALSE,
	    removeNum = FALSE, toLower = FALSE, stemWords = FALSE,
	    rmStopWords = FALSE, Verbose = TRUE)
  ## match lexrank output to .data
  lr %>%
    distinct(sentence, .keep_all = TRUE) %>% 
    full_join(aggregated, by="sentence") %>%
    full_join(base, by="aggregate") %>%
    arrange(aggregate) %>%
    dplyr::pull(value)
}

#' Get statistics for sentiment over some group, such as sentence.
#'
#' @param .data character vector of words
#'
#' @param aggregate_on vector to aggregate .data over; ideally,
#'   sentence_id, but could be chapter, document, etc.
#'
#' @param statistic function that accepts na.rm argument; e.g. mean,
#'   median, sd.
aggregate_sentiment <- function(.data, aggregate_on, statistic){
  tibble::enframe(.data, "nil1", "word") %>%
    bind_cols(tibble::enframe(aggregate_on, "nil2", "aggregate")) %>%
    dplyr::select(word, aggregate) %>%
    dplyr::mutate(sentiment = word_sentiment(word)) %>%
    group_by(aggregate) %>%
    dplyr::mutate(aggregate_sentiment =
	     (function(.x){
	       rep(statistic(.x, na.rm = TRUE), length(.x))
	     })(sentiment)) %>%
    dplyr::pull(aggregate_sentiment)
}
