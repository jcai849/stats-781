source("../src/depends.R")
source("../src/prep-for-insight.R")
source("../src/word-insight.R")
source("../src/vis-insight.R")

filename <- "../data/raw/11-0.txt"

stopwords <- get_sw(addl = c("lewis", "alice's", "alice’s",
			     "EbOoK", "said", "project", "gutenberg"))

std_tib <- import_txt(filename) %>%
    format_data() %>%
    determine_stopwords(stopwords)

wf <- std_tib %>%
    get_insight(word_freq)

bf <- std_tib %>%
    get_insight(bigram_freq)

kw <- std_tib %>%
    get_insight(keywords_tr)

ws <- std_tib %>%
    get_insight(word_sentiment_AFINN)

wf %>%
    get_vis(word_dist, "word_freq")

wf %>%
    get_vis(word_bar, "word", "word_freq")

kw %>%
    get_vis(word_bar, "word", "rank", desc=FALSE)

ws %>%
    get_vis(word_dist, "score")

filename <- "../data/raw/11-0.txt"

imported <- import_txt(filename) 

imported %>%
    ggpage_build() %>%
    filter(page == 1) %>%
    ggpage_plot()

imported %>%
    ggpage_build() %>%
    filter(page == 1) %>%
    get_insight(word_freq) %>%
    ggpage_plot(aes(fill=word_freq))

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

imported %>%
    ggpage_build() %>%
    get_insight(word_sentiment_AFINN) %>%
    ggpage_plot(aes(fill=score)) +
    scale_fill_gradient2(low = "red", high = "blue", mid = "grey", midpoint = 0)

filename <- "../data/raw/11-0.txt"

stopwords <- get_sw(addl = c("lewis", "alice's", "alice’s",
                             "EbOoK", "said", "project", "gutenberg"))

std_tib <- import_txt(filename) %>%
    format_data() %>%
    determine_stopwords(stopwords) %>%
    get_chapters() %>%
    group_by(chapter, add=TRUE)

wf <- std_tib %>%
    get_insight(word_freq)

bf <- std_tib %>%
    get_insight(bigram_freq)

kw <- std_tib %>%
    get_insight(keywords_tr)

ws <- std_tib %>%
    get_insight(word_sentiment_AFINN)

wf %>%
    get_vis(word_dist, "word_freq")

wf %>%
    get_vis(word_bar, "word", "word_freq")

kw %>%
    get_vis(word_bar, "word", "rank", desc=FALSE)

ws %>%
    get_vis(word_dist, "score")

filepath <- "../data/raw/Schonlau1.xls"
textcol<- "expert clinical summary"

stopwords <- get_sw()

std_tib <- import_excel(filepath, textcol) %>%
    format_data() %>%
    group_by(!! sym("record ID"), add=TRUE) %>%
    group_by(!! sym("expert AE causation score"), add=TRUE) %>%
    determine_stopwords()

wf <- std_tib %>%
    get_insight(word_freq)

bf <- std_tib %>%
    get_insight(bigram_freq)

kw <- std_tib %>%
    get_insight(keywords_tr)

ws <- std_tib %>%
    get_insight(word_sentiment_AFINN)

wf %>%
    get_vis(word_dist, "word_freq")

wf %>%
    get_vis(word_bar, "word", "word_freq")

kw %>%
    get_vis(word_bar, "word", "rank", desc=FALSE)

ws %>%
    get_vis(word_dist, "score")
