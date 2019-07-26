source("../src/depends.R")
source("../src/prep-for-insight.R")
source("../src/word-insight.R")
source("../src/sentence-insight.R")
source("../src/vis-insight.R")

imported <- import_files(tk_choose.files())
lemmatize <- TRUE
stopwords <- TRUE
sw_lexicon <- "snowball"
addl_stopwords <- NA
data <- text_prep(imported, lemmatize, stopwords, sw_lexicon, addl_stopwords)

insighted <- data %>%
  dplyr::mutate(
  term_freq = term_freq(text),
  bigram = get_bigram(text),
  bigram_freq = term_freq(bigram),
  word_sentiment = word_sentiment(text),
  term_count_sentence = term_count(text, sentence_id),
  mean_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, mean),
  sd_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, sd)
  )

# … with 29,944 more rows, and 13 more variables: line_id <int>, word1 <chr>,
#   word_id <int>, lemma <chr>, stopword <lgl>, text <chr>, term_freq <int>,
#   bigram <chr>, bigram_freq <int>, word_sentiment <int>,
#   term_count_sentence <int>, mean_aggregate_sentiment_sentence <dbl>,
#   sd_aggregate_sentiment_sentence <dbl>


## Structure: ggpage --------------------------------

insighted %>%
  dplyr::pull(word) %>%
  ggpage_build() %>%
  bind_cols(insighted) %>%
  ggpage_plot(aes(colour=mean_aggregate_sentiment_sentence)) +
  scale_color_gradient2()

insighted %>%
  dplyr::pull(word) %>%
  ggpage_build() %>%
  bind_cols(insighted) %>%
  ggpage_plot(aes(colour=term_count_sentence)) +
  labs(title = "Word Count of Sentences")

## Distribution: Histogram --------------------------------

insighted %>%
  ggplot(aes(term_freq)) +
  geom_histogram() +
  labs(title = "Histogram of Word Frequency")

## Score: barplot --------------------------------

n <- 10

insighted %>%
  dplyr::distinct(bigram, .keep_all = TRUE) %>%
  top_n(n, bigram_freq) %>%
  dplyr::mutate(bigram = reorder(bigram, desc(bigram_freq))) %>%
  ggplot(aes(bigram, bigram_freq)) +
  geom_col() +
  labs(title = "Bigrams by Bigram Frequency")

imported <- import_files(tk_choose.files())
lemmatize <- TRUE
stopwords <- TRUE
sw_lexicon <- "snowball"
addl_stopwords <- NA
prepped <- text_prep(imported, lemmatize, stopwords, sw_lexicon, addl_stopwords)
sectioned <- prepped %>% dplyr::mutate(chapter = get_chapters(text))
data <- sectioned %>%
  dplyr::group_by(doc_id, chapter)

## .data <- data$text
## aggregate_by <- data$chapter

insighted <- data %>%
  dplyr::mutate(
  term_freq = term_freq(text),
  bigram = get_bigram(text),
  bigram_freq = term_freq(bigram),
  word_sentiment = word_sentiment(text),
  term_count_sentence = term_count(text, sentence_id),
  mean_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, mean),
  sd_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, sd)
  )

## alt_insighted <- data %>%
##   group_modify(~ {
##     .x %>%
##   dplyr::mutate(
##   term_freq = term_freq(text),
##   bigram = get_bigram(text),
##   bigram_freq = term_freq(bigram),
##   word_sentiment = word_sentiment(text),
##   term_count_sentence = term_count(text, sentence_id),
##   mean_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, mean),
##   sd_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, sd)
##   )      
##   })

## testthat::test_that("groups work with dplyr::mutate as with group_modify",
## {
##   expect_equal(insighted, alt_insighted)
## })

## Structure: ggpage --------------------------------
groups <- group_vars(insighted)

insighted %>% #base data
  group_modify(~ { #build ggpage
    .x %>%
      dplyr::pull(word) %>%
      ggpage_build() %>%
      bind_cols(.x)  
  }) %>%
  ggpage_plot(aes(colour=mean_aggregate_sentiment_sentence)) + #plot ggpage
  scale_color_gradient2() +
  facet_wrap(groups) +
  labs(title = glue("Mean Sentiment of Sentences by {paste(groups, collapse = \", \")}"))
ggsave(filename = "mean-sent-ggpage.png", device = "png", path="~/stats-781/out/")

insighted %>% #base data
  group_modify(~ { #build ggpage
    .x %>%
      dplyr::pull(word) %>%
      ggpage_build() %>%
      bind_cols(.x)  
  }) %>%
  ggpage_plot(aes(colour=sd_aggregate_sentiment_sentence)) + #plot ggpage
  scale_color_gradient2() +
  facet_wrap(groups) +
  labs(title = glue("Sentiment Standard Deviation of Sentences by {paste(groups, collapse = \", \")}"))
ggsave(filename = "sd-sent-ggpage.png", device = "png", path="~/stats-781/out/")


insighted %>% #base data
  group_modify(~ { #build ggpage
    .x %>%
      dplyr::pull(word) %>%
      ggpage_build() %>%
      bind_cols(.x)  
  }) %>%
  ggpage_plot(aes(colour=term_count_sentence)) + #plot ggpage
  ## scale_color_gradient2() +
  facet_wrap(groups) +
  labs(title = glue("Word Count of Sentences by {paste(groups, collapse = \", \")}"))

insighted %>%
  dplyr::pull(word) %>%
  ggpage_build() %>%
  bind_cols(insighted) %>%
  ggpage_plot(aes(colour=term_count_sentence)) +
  labs(title = "Word Count of Sentences")

## Distribution: Histogram --------------------------------

insighted %>%
  ggplot(aes(term_freq)) +
  geom_histogram() +
  labs(title = "Histogram of Word Frequency") +
  facet_wrap(groups)
ggsave(filename = "word-freq-hist.png", device = "png", path="~/stats-781/out/")

## Score: barplot --------------------------------

n <- 10

insighted %>%
  group_modify(~ {.x %>%
		    dplyr::distinct(bigram, .keep_all = TRUE) %>%
		    dplyr::arrange(desc(bigram_freq)) %>%
		    head(n)
  }) %>%
  ungroup() %>%
  dplyr::mutate(bigram = reorder_within(bigram, bigram_freq, !! ifexp(length(groups) > 1,
								syms(groups),
								sym(groups)))) %>% 
  ggplot(aes(bigram, bigram_freq)) +
  geom_bar(stat="identity") +
  facet_wrap(groups, scales = "free_y") +
  scale_x_reordered() +
  coord_flip() +
  labs(title = "Bigrams by Bigram Frequency")
ggsave(filename = "bigram-freq-bar.png", device = "png", path="~/stats-781/out/")

filename <- "../data/raw/11-0.txt"

imported <- import_txt(filename) 

imported %>%
    ggpage_build() %>%
    filter(page == 1) %>%
    ggpage_plot()

imported %>%
    ggpage_build() %>%
    filter(page == 1) %>%
    get_insight(term_freq) %>%
    ggpage_plot(aes(fill=term_freq))

stopwords <- get_sw()

imported <- import_txt(filename) %>%
    format_data() %>%
    remove_stopwords(stopwords) %>%
    reconstruct()

imported %>%
    ggpage_build() %>%
    get_insight(term_freq) %>%
    ggpage_plot(aes(fill=term_freq))

imported %>%
    ggpage_build() %>%
    get_insight(keywords_tr) %>%
    ggpage_plot(aes(fill=rank))

imported %>%
    ggpage_build() %>%
    get_insight(word_sentiment_AFINN) %>%
    ggpage_plot(aes(fill=score)) +
    scale_fill_gradient2(low = "red", high = "blue", mid = "grey", midpoint = 0)
