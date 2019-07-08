## ------------------------------ Dependencies

source("../src/depends.R")

## ------------------------------ Importing Novel

source("../src/prep-for-insight.R")

filename <- "../data/raw/11-0.txt"

imported <- import_txt(filename) %>%
    ## get_parts() %>%
    ## group_by(part) %>%
    get_chapters() %>%
    group_by(chapter, add=TRUE) %>%
    format_data()

stopwords <- get_sw(addl = c("lewis", "alice's", "alice’s",
                             "EbOoK", "said", "project", "gutenberg"))

std_tib <- imported %>%
    remove_stopwords(stopwords)
## ------------------------------ Importing Free-Response

source("../src/prep-for-insight.R")

filepath <- "../data/raw/Schonlau1.xls"
textcol<- "expert clinical summary"

imported <- import_excel(filepath, textcol) %>%
    group_by(!! sym("record ID"), add=TRUE) %>%
    group_by(!! sym("expert AE causation score"), add=TRUE) %>%
    format_data()

stopwords <- get_sw()

std_tib <- imported %>%
    remove_stopwords(stopwords)
## ------------------------------ Word-Level insights

source("../src/word-insight.R")

wf <- std_tib %>%
    get_insight(word_freq)

bf <- std_tib %>%
    get_insight(bigram_freq)

## ------------------------------ Visualisation

source("../src/vis-insight.R")

wf %>%
    get_vis(word_dist, "word_freq")

wf %>%
    get_vis(word_bar, "word", "word_freq")

