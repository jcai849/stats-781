source("../src/depends.R")
source("../src/prep-for-insight.R")
source("../src/word-insight.R")
source("../src/sentence-insight.R")
source("../src/vis-insight.R")

imported <- import_files()
lemmatize <- TRUE
stopwords <- TRUE
sw_lexicon <- "snowball"
addl_stopwords <- NA
data <- text_prep(imported, lemmatize, stopwords, sw_lexicon, addl_stopwords)

insighted <- data %>%
  mutate(
  word_freq = word_freq(text),
  bigram = get_bigram(text),
  bigram_freq = word_freq(bigram),
  word_sentiment = word_sentiment(text),
  word_count_sentence = word_count(text, sentence_id),
  mean_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, mean),
  sd_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, sd)
  )

insighted %>%
  ggpage_build()

imported <- import_files()
lemmatize <- TRUE
stopwords <- TRUE
sw_lexicon <- "snowball"
addl_stopwords <- NA
prepped <- text_prep(imported, lemmatize, stopwords, sw_lexicon, addl_stopwords)
sectioned <- prepped %>% mutate(chapter = get_chapters(text))
data <- sectioned ## %>%
  ## group_by(doc_id,chapter)

## .data <- data$text
## aggregate_by <- data$chapter

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
