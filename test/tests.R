
source("../src/depends.R")

## ------------------------------ Importing

read_lines("../data/raw/11-0.txt") %>% # Without import function
    tibble(text=.)

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

## ------------------------------ Word-Level insights

source("../src/word-insight.R")

wf <- std_tib %>%
    get_insight(word_freq)

bf <- std_tib %>%
    get_insight(bigram_freq)

## ------------------------------ Visualisation

source("../src/vis-insight.R")

n <- 10
desc <- TRUE


wf %>%
    get_vis(word_dist, "word_freq")

wf %>%
    get_vis(word_bar, "word", "word_freq")

wf %>%
    word_dist("word_freq")

insight_name <- "word"
insight_col <- "word_freq"
std_tib <- wf
wf %>%
    word_bar(insight_name, insight_col)

bf %>%
    word_dist(bigram_freq)

bf %>%
    word_bar(bigram, bigram_freq)
