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

kw <- std_tib %>%
    get_insight(keywords_tr)

ws <- std_tib %>%
    get_insight(word_sentiment_AFINN)

## ------------------------------ Visualisation

source("../src/vis-insight.R")

wf %>%
    get_vis(word_dist, "word_freq")

wf %>%
    get_vis(word_bar, "word", "word_freq")

kw %>%
    get_vis(word_bar, "word", "rank", desc=FALSE)

ws %>%
    get_vis(word_dist, "score")

## ------------------------------ ggpage

filename <- "../data/raw/11-0.txt"

imported <- import_txt(filename) 

## ggpage_quick(imported[["text"]]) #doesn't seem to work

imported %>%
    ggpage_build() %>%
    ggpage_plot()

imported %>%
    ggpage_build() %>%
    get_insight(word_freq) %>%
    ggpage_plot(aes(fill=word_freq))

## ------------------------------ ggpage_more

stopwords <- get_sw()

imported <- import_txt(filename) %>%
    format_data() %>%
    remove_stopwords(stopwords) %>%
    reconstruct()

imported %>%
    ggpage_build() %>%
    get_insight(word_freq) %>%
    ggpage_plot(aes(fill=word_freq))

imported %>%
    ggpage_build() %>%
    get_insight(keywords_tr) %>%
    ggpage_plot(aes(fill=rank))

## ------------------------------

std_tib %>%
    reconstruct() %>%
    ggpage_build() %>%
    get_insight(word_sentiment_AFINN) %>%
    ggpage_plot(aes(fill=score)) +
    scale_fill_gradient2(low = "red", high = "blue", mid = "grey", midpoint = 0)
