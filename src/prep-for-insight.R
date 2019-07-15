#' Get filetype
#'
#' @param filepath string filepath of document
#'
#' @return filetype (string) - NA if no extension
get_filetype <- function(filepath){
  filepath %>%
    basename %>%
    str_extract('[a-zA-Z0-9]+\\.[a-zA-Z0-9]+$') %>% #ensure filename.extension form
    str_extract('[a-zA-Z0-9]+$')                  #extract extension
}

#' Interactively determine and automatically mark the text column of a table
#'
#' @param data dataframe with column requiring marking
#'
#' @return same dataframe with text column renamed to "text"
table_textcol <- function(data){
cols <- colnames(data)
print("Please enter the number of the column you want selected for text analytics")
print(cols)
textcol_index <- get_valid_input(as.character(1:ncol(data))) %>%
  as.integer 
textcol <- cols[textcol_index]  
data %>%
    rename(text = !! sym(textcol))
}

#' helper function to get valid input (recursively)
#'
#' @param options vector of options that valid input should be drawn from
#'
#' @return readline output that exists in the vector of options
get_valid_input <- function(options, init=TRUE){
  input <- ifelse(init,
		  readline(),
		  readline(prompt = "Invalid option. Please try again: "))
  ifelse(input %in% options,
	 input,
	 get_valid_input(options, init=FALSE))
}

#' Import text file 
#'
#' @param filepath a string indicating the relative or absolute
#'     filepath of the file to import
#'
#' @return tibble of each row corrresponding to a line of the text
#'     file, with the column named "text"
import_txt <- function(filepath){
    read_lines(filepath) %>%
	tibble(text=.)
}

#' Import csv file
#'
#' @param filepath a string indicating the relative or absolute
#'     filepath of the file to import
#'
#' @return tibble of each row corrresponding to a line of the text
#'     file, with the column named "text"
import_csv <- function(filepath){
  read_csv(filepath) %>%
  table_textcol()
}

#' Import excel file
#'
#' @param filepath a string indicating the relative or absolute
#'     filepath of the file to import
#'
#' @return tibble of each row corrresponding to a line of the text
#'     file, with the column named "text"
import_excel <- function(filepath){
    read_excel(filepath) %>%
	table_textcol()
}

#' Base case for file import
#'
#' @param filepath string filepath of file for import
#'
#' return imported file with document id
import_base_file <- function(filepath){
  filetype <- get_filetype(filepath)
  filename <- basename(filepath)
  if (filetype == "csv"){
    imported <- import_csv(filepath)
  } else if (filetype == "xlsx" | filetype == "xls") {
    imported <- import_excel(filepath)
  } else {
    imported <- import_txt(filepath)
  }
  imported %>%
    mutate(doc_id = filename)
}

import_files <- function(){
  filepaths <- tk_choose.files()
  filepaths %>%
    map(import_base_file) %>%
    bind_rows
}

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
        group_modify(~ {
            .x %>%
                unnest_tokens(output = sentence, input = text, token = "sentences", to_lower = FALSE) %>%
                mutate(sentence_id = row_number())
        }) %>%
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
get_sw <- function(sw_list = "snowball", addl = NA){
    get_stopwords(source=sw_list) %>%
        select(word) %>%
        bind_rows(tibble(word = addl)) %>%
        na.omit() %>%
        mutate(word = tolower(word))
}

#' Adds stopwords column
#'
#' @param data a tibble formatted such that columns correspond to
#'     identifiers of line, sentence, and word
#'
#' @param sw_list tibble with single column of stopwords
#'
#' @return a dataframe equivalent to the input dataframe, with an additional stopword column
determine_stopwords <- function(data, sw_list){
    data %>%
        mutate(stopword = word %in% sw_list$word)
}

#' creates a search closure to section text
#'
#' @param search a string regexp for the term to seperate on, e.g. "Chapter"
#'
#' @param name string name for the sectioning column
#'
#' @return closure over search expression and named column
get_search <- function(search, name){
    #' add section column by occurance of words
    #' 
    #' @param data tibble of each row corrresponding to a line of the text
    #'     file, with the column named "text"
    #' @return the original data with the addition of a sectioned column
    function(data){
	data %>%
	    mutate(!! name := str_detect(text, search) %>% cumsum())
    }
}

get_chapters <- get_search("^[\\s]*[Cc][Hh][Aa]?[Pp][Tt]([Ee][Rr])?", "chapter")
get_parts <- get_search("^[\\s]*[Pp]([Aa][Rr])?[Tt]", "part")
get_sections <- get_search("^[\\s]*([Ss][Ss])|([Ss][Ee][Cc][Tt][Ii][Oo][Nn])", "section")
get_verse <- get_search("^[\\s]*[Vv][Ee][Rr][Ss][Ee]", "verse")

#' helper function to ungroup for dplyr. functions equivalently to
#' group_by() but with standard (string) evaluation
ungroup_by <- function(x,...){
    group_by_at(x, group_vars(x)[!group_vars(x) %in% ...])
}


