#' Import text file to analysis-ready format
#'
#' @param filepath a string indicating the relative or absolut
#'     filepath of the file to import
#'
#' @return a tibble formatted such that columns correspond to
#'     identifiers of "line", "sentence_id", and "word"
import_txt <- function(filepath){
    read_lines(filepath) %>%
        tibble(text=.) %>%
        mutate(doc_id = 1,
               line_id = row_number()) %>%
        unnest_tokens(output = sentence, input = text, token = "sentences") %>%
        mutate(sentence_id = row_number()) %>%
        unnest_tokens(output = word, input = sentence, token = "words") %>%
        mutate(word_id = row_number()) %>%
        select(doc_id, line_id, sentence_id, word_id, word)
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
get_sw <- function(sw_list = "snowball", addl = NA){
    get_stopwords(source=sw_list) %>%
        select(word) %>%
        bind_rows(tibble(word = addl)) %>%
        na.omit() %>%
        mutate(word = tolower(word))
}

#' removes stopwords
#'
#' @param data a tibble formatted such that columns correspond to
#'     identifiers of line, sentence, and word
#'
#' @param sw_list tibble with single column of stopwords
#'
#' @return a dataframe equivalent to the input dataframe, with stopwords removed
remove_stopwords <- function(data, sw_list){
    anti_join(data, sw_list, by = "word")
}
