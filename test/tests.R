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

# … with 29,944 more rows, and 13 more variables: line_id <int>, word1 <chr>,
#   word_id <int>, lemma <chr>, stopword <lgl>, text <chr>, word_freq <int>,
#   bigram <chr>, bigram_freq <int>, word_sentiment <int>,
#   word_count_sentence <int>, mean_aggregate_sentiment_sentence <dbl>,
#   sd_aggregate_sentiment_sentence <dbl>


## Structure: ggpage --------------------------------

insighted %>%
  pull(word) %>%
  ggpage_build() %>%
  bind_cols(insighted) %>%
  ggpage_plot(aes(colour=mean_aggregate_sentiment_sentence)) +
  scale_color_gradient2()

insighted %>%
  pull(word) %>%
  ggpage_build() %>%
  bind_cols(insighted) %>%
  ggpage_plot(aes(colour=word_count_sentence)) +
  labs(title = "Word Count of Sentences")

## Distribution: Histogram --------------------------------

insighted %>%
  ggplot(aes(word_freq)) +
  geom_histogram() +
  labs(title = "Histogram of Word Frequency")

## Score: barplot --------------------------------

n <- 10

insighted %>%
  distinct(bigram, .keep_all = TRUE) %>%
  top_n(n, bigram_freq) %>%
  mutate(bigram = reorder(bigram, desc(bigram_freq))) %>%
  ggplot(aes(bigram, bigram_freq)) +
  geom_col() +
  labs(title = "Bigrams by Bigram Frequency")

imported <- import_files()
lemmatize <- TRUE
stopwords <- TRUE
sw_lexicon <- "snowball"
addl_stopwords <- NA
prepped <- text_prep(imported, lemmatize, stopwords, sw_lexicon, addl_stopwords)
sectioned <- prepped %>% mutate(chapter = get_chapters(text))
data <- sectioned %>%
  group_by(doc_id, chapter)

## .data <- data$text
## aggregate_by <- data$chapter

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

## alt_insighted <- data %>%
##   group_modify(~ {
##     .x %>%
##   mutate(
##   word_freq = word_freq(text),
##   bigram = get_bigram(text),
##   bigram_freq = word_freq(bigram),
##   word_sentiment = word_sentiment(text),
##   word_count_sentence = word_count(text, sentence_id),
##   mean_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, mean),
##   sd_aggregate_sentiment_sentence = aggregate_sentiment(text, sentence_id, sd)
##   )      
##   })

## testthat::test_that("groups work with mutate as with group_modify",
## {
##   expect_equal(insighted, alt_insighted)
## })

## Structure: ggpage --------------------------------
groups <- group_vars(insighted)

insighted %>% #base data
  group_modify(~ { #build ggpage
    .x %>%
      pull(word) %>%
      ggpage_build() %>%
      bind_cols(.x)  
  }) %>%
  ggpage_plot(aes(colour=mean_aggregate_sentiment_sentence)) + #plot ggpage
  scale_color_gradient2() +
  facet_wrap(groups) +
  labs(title = glue("Mean Sentiment of Sentences by {paste(groups, collapse = \", \")}"))

insighted %>% #base data
  group_modify(~ { #build ggpage
    .x %>%
      pull(word) %>%
      ggpage_build() %>%
      bind_cols(.x)  
  }) %>%
  ggpage_plot(aes(colour=word_count_sentence)) + #plot ggpage
  ## scale_color_gradient2() +
  facet_wrap(groups) +
  labs(title = glue("Word Count of Sentences by {paste(groups, collapse = \", \")}"))

insighted %>%
  pull(word) %>%
  ggpage_build() %>%
  bind_cols(insighted) %>%
  ggpage_plot(aes(colour=word_count_sentence)) +
  labs(title = "Word Count of Sentences")

## Distribution: Histogram --------------------------------

insighted %>%
  ggplot(aes(word_freq)) +
  geom_histogram() +
  labs(title = "Histogram of Word Frequency") +
  facet_wrap(groups)

## Score: barplot --------------------------------

n <- 10

insighted %>%
  group_modify(~ {.x %>%
		    distinct(bigram, .keep_all = TRUE) %>%
		    arrange(desc(bigram_freq)) %>%
		    head(n)
  }) %>%
  ungroup() %>%
  mutate(bigram = reorder_within(bigram, bigram_freq, !! ifexp(length(groups) > 1,
								syms(groups),
								sym(groups)))) %>% 
  ggplot(aes(bigram, bigram_freq)) +
  geom_bar(stat="identity") +
  facet_wrap(groups, scales = "free_y") +
  scale_x_reordered() +
  coord_flip() +
  labs(title = "Bigrams by Bigram Frequency")

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
