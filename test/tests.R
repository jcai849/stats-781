
source("../src/depends.R")

## ------------------------------ Importing

source("../src/prep-for-insight.R")

read_lines("../data/raw/11-0.txt") %>% # Without import function
    tibble(text=.)

imported <- import_txt("../data/raw/11-0.txt") # Import function

stopwords <- get_sw(addl = c("lewis", "alice's", "alice’s",
                             "EbOoK", "said", "project", "gutenberg"))

sw_removed <- imported %>%
    remove_stopwords(stopwords)

## ------------------------------ Word-Level insights

source("../src/word-insight.R")

wf <- sw_removed %>%
    word_freq()

bf <- sw_removed %>%
    bigram_freq()

## ------------------------------ Visualisation

source("../src/vis-insight.R")

n <- 10
desc <- TRUE

wf %>%
    word_hist(word_freq)

wf %>%
    word_bar(word, word_freq)

bf %>%
    word_hist(bigram_freq)

bf %>%
    word_bar(bigram, bigram_freq)

## ------------------------------ Stack

import_txt("../data/raw/11-0.txt") %>%
    remove_stopwords(stopwords) %>%
    word_freq() %>%
    word_hist(word_freq)
