#' formats imported data into an analysis-ready format
#'
#' @param data a tibble formatted with a text and (optional) group
#'     column
#'
#' @return a tibble formatted such that columns correspond to
#'     identifiers of group, line, sentence, word (groups ignored)
format_data <- function(data){
    data %>%
	mutate(line_id = row_number()) %>% 
		unnest_tokens(output = sentence, input = text, token = "sentences", to_lower = FALSE) %>%
		mutate(sentence_id = row_number()) %>%
	group_by(sentence_id, add=TRUE) %>%
	group_modify(~ {
	    .x %>%
		unnest_tokens(output = word, input = sentence, token = "words", to_lower=FALSE) %>%
		mutate(word_id = row_number())
	}) %>%
	ungroup_by("sentence_id")
}

#' Gets stopwords from a default list and user-provided list
#'
#' @param sw_list a string name of a stopword list, one of "smart",
#'     "snowball", or "onix"
#'
#' @param addl user defined character vector of additional stopwords,
#'     each element being a stopword
#'
#' @return a tibble with one column named "word"
get_sw <- function(lexicon = "snowball", addl = NA){
  addl_char <- as.character(addl)
  get_stopwords(source = lexicon) %>%
    select(word) %>%
    bind_rows(., tibble(word = addl_char)) %>%
    na.omit() %>%
    as_vector %>%
    tolower() %>%
    as.character()
}

#' determine stopword status
#'
#' @param .data vector of words
#'
#' @param ... arguments of get_sw
#'
#' @return a dataframe equivalent to the input dataframe, with an additional stopword column
determine_stopwords <- function(.data, ...){
  sw_list <- get_sw(...)
  .data %in% sw_list
}

text_prep <- function(.data, lemmatize=TRUE, stopwords=TRUE, sw_lexicon="snowball", addl_stopwords=NA){
  formatted <- .data %>%
    format_data()

  text <- ifexp(lemmatize,
		       ifexp(stopwords,
			     mutate(formatted, lemma = tolower(lemmatize_words(word)),
				    stopword = determine_stopwords(lemma, sw_lexicon, addl_stopwords),
				    text = if_else(stopword,
							  as.character(NA),
							  lemma)),
			     mutate(formatted, lemma = tolower(lemmatize_words(word)),
				    text = lemma)),
		       ifexp(stopwords,
			     mutate(formatted, stopword = determine_stopwords(word, sw_lexicon, addl_stopwords),
				    text = if_else(stopword,
							  as.character(NA),
							  word)),
			     mutate(formatted, text = word)))
  return(text)
}

#' creates a search closure to section text
#'
#' @param search a string regexp for the term to seperate on, e.g. "Chapter"
#'
#' @return closure over search expression 
get_search <- function(search){
  #' section based on search result 
  #' 
  #' @param .data vector to section
  #'
  #' @return vector of same length as .data with section numbers
  function(.data){
    .data %>%
      str_detect(search) %>%
      accumulate(sum, na.rm=TRUE)
    }
}

get_chapters <- get_search("^[\\s]*[Cc][Hh][Aa]?[Pp][Tt]([Ee][Rr])?")
get_parts <- get_search("^[\\s]*[Pp]([Aa][Rr])?[Tt]")
get_sections <- get_search("^[\\s]*([Ss][Ss])|([Ss][Ee][Cc][Tt][Ii][Oo][Nn])")

#' helper function to ungroup for dplyr. functions equivalently to
#' group_by() but with standard (string) evaluation
ungroup_by <- function(x,...){
    group_by_at(x, group_vars(x)[!group_vars(x) %in% ...])
}
