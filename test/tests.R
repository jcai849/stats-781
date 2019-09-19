library(inzightta)

imported <- import_files(tcltk::tk_choose.files())
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
  word_sentiment = term_sentiment(text),
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
  ggpage::ggpage_build() %>%
  dplyr::bind_cols(insighted) %>%
  ggpage::ggpage_plot(ggplot2::aes(colour=mean_aggregate_sentiment_sentence)) +
  ggplot2::scale_color_gradient2()

insighted %>%
  dplyr::pull(word) %>%
  ggpage::ggpage_build() %>%
  dplyr::bind_cols(insighted) %>%
  ggpage::ggpage_plot(ggplot2::aes(colour=term_count_sentence)) +
  ggplot2::labs(title = "Word Count of Sentences")

## Distribution: Histogram --------------------------------

insighted %>%
  ggplot2::ggplot(ggplot2::aes(term_freq)) +
  ggplot2::geom_histogram() +
  ggplot2::labs(title = "Histogram of Word Frequency")

## Score: barplot --------------------------------

n <- 10

insighted %>%
  dplyr::distinct(bigram, .keep_all = TRUE) %>%
  dplyr::top_n(n, bigram_freq) %>%
  dplyr::mutate(bigram = forcats::fct_reorder(bigram, dplyr::desc(bigram_freq))) %>%
  ggplot2::ggplot(ggplot2::aes(bigram, bigram_freq)) +
    ggplot2::geom_col() +
    ggplot2::coord_flip() +
  ggplot2::labs(title = "Bigrams by Bigram Frequency")

imported <- import_files(tcltk::tk_choose.files())
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
groups <- dplyr::group_vars(insighted)

insighted %>% #base data
  dplyr::group_modify(~ { #build ggpage
    .x %>%
      dplyr::pull(word) %>%
      ggpage::ggpage_build() %>%
      dplyr::bind_cols(.x)  
  }) %>%
  ggpage::ggpage_plot(ggplot2::aes(colour=mean_aggregate_sentiment_sentence)) + #plot ggpage
  ggplot2::scale_color_gradient2() +
  ggplot2::facet_wrap(groups) +
  ggplot2::labs(title = glue::glue("Mean Sentiment of Sentences by {paste(groups, collapse = \", \")}"))

ggplot2::ggsave(filename = "mean-sent-ggpage.png", device = "png", path="~/stats-781/out/")

insighted %>% #base data
  dplyr::group_modify(~ { #build ggpage
    .x %>%
      dplyr::pull(word) %>%
      ggpage::ggpage_build() %>%
      dplyr::bind_cols(.x)  
  }) %>%
  ggpage::ggpage_plot(ggplot2::aes(colour=sd_aggregate_sentiment_sentence)) + #plot ggpage
  ggplot2::scale_color_gradient2() +
  ggplot2::facet_wrap(groups) +
    ggplot2::labs(title = glue::glue("Sentiment Standard Deviation of Sentences by {paste(groups, collapse = \", \")}"))


ggsave(filename = "sd-sent-ggpage.png", device = "png", path="~/stats-781/out/")


insighted %>% #base data
   dplyr::group_modify(~ { #build ggpage
    .x %>%
      dplyr::pull(word) %>%
      ggpage::ggpage_build() %>%
      dplyr::bind_cols(.x)  
  }) %>%
  ggpage::ggpage_plot(ggplot2::aes(colour=term_count_sentence)) + #plot ggpage
  ## scale_color_gradient2() +
  ggplot2::facet_wrap(groups) +
  ggplot2::labs(title = glue::glue("Word Count of Sentences by {paste(groups, collapse = \", \")}"))

insighted %>%
  dplyr::pull(word) %>%
  ggpage::ggpage_build() %>%
  dplyr::bind_cols(insighted) %>%
  ggpage::ggpage_plot(ggplot2::aes(colour=term_count_sentence)) +
  ggplot2::labs(title = "Word Count of Sentences")

## Distribution: Histogram --------------------------------

insighted %>%
  ggplot2::ggplot(ggplot2::aes(term_freq)) +
  ggplot2::geom_histogram() +
  ggplot2::labs(title = "Histogram of Word Frequency") +
  ggplot2::facet_wrap(groups)

ggplot2::ggsave(filename = "word-freq-hist.png", device = "png", path="~/stats-781/out/")

## Score: barplot --------------------------------

n <- 10

insighted %>%
    dplyr::group_modify(~ {.x %>%
		    dplyr::distinct(bigram, .keep_all = TRUE) %>%
		    dplyr::arrange(desc(bigram_freq)) %>%
		    head(n)
  }) %>%
  dplyr::ungroup() %>%
    dplyr::mutate(bigram = tidytext::reorder_within(bigram,
                                                    bigram_freq,
                                                    !! ifexp(length(groups) > 1,
                                                             dplyr::syms(groups),
							     dplyr::sym(groups)))) %>% 
  ggplot2::ggplot(ggplot2::aes(bigram, bigram_freq)) +
  ggplot2::geom_bar(stat="identity") +
  ggplot2::facet_wrap(groups, scales = "free_y") +
  tidytext::scale_x_reordered() +
  ggplot2::coord_flip() +
    ggplot2::labs(title = "Bigrams by Bigram Frequency")

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

library(shiny)
 library(inzightta)
 library(rlang)

 input <- list(file1 = list(datapath = "~/stats-781/data/raw/11-0.txt"),
               lemmatise = TRUE,
               stopwords = TRUE,
               sw_lexicon = "snowball",
               filter_var = NULL,
               filter_pred = NULL,
               section_by = "chapter",
               group_var = NULL,
               get_term_insight = TRUE,
               term_insight = "Lagged Term Sentiment",
               get_aggregate_insight = NULL,
               aggregate_insight = NULL,
               aggregate_var = NULL,
               vis = "struct_ts_ungrouped", ###  "struct_ggpage_ungrouped" "dist_density_ungrouped" "score_bar_ungrouped" "dist_hist_ungrouped" "struct_ts_ungrouped"
               vis_col = "Lagged Term Sentiment",
               vis_facet = "chapter",
               scale_fixed = TRUE)

                                       # Import & Process
 imported <- inzightta::import_files(input$file1$datapath)

 prepped <- {
     data <- imported
     if (isTruthy(input$lemmatise) |
         isTruthy(input$stopwords)){
         data <- data %>%
             text_prep(input$lemmatise, input$stopwords, input$sw_lexicon, NA)
     }
     data}

 filtered <- {
     data <- prepped
     if (isTruthy(input$filter_var) &
         isTruthy(input$filter_pred)){
         data <- data %>%
             dplyr::filter(!! dplyr::sym(input$filter_var) == input$filter_pred)
     }
     data
 }

 sectioned <- {
     data <- filtered
     if (isTruthy(input$section_by)){
         data <- data %>%
             section(input$section_by)
     }
     data
 }

 grouped <- {
     data <- sectioned
     if (isTruthy(input$group_var)){
         data <- data %>%
             dplyr::group_by(!! dplyr::sym(input$group_var))
     }
     data
 }

 term_insights <- {
     data <- grouped
     if (isTruthy(input$get_term_insight) &
         isTruthy(input$term_insight)){
         data <- data %>%
             get_term_insight(input$term_insight)
     }
     data
 }
get_term_insight(prepped, "Term Frequency") 
 aggregate_insights <- {
     data <- term_insights
     if (isTruthy(input$get_aggregate_insight) &
         isTruthy(input$aggregate_insight) &
         isTruthy(input$aggregate_var)){
         data <- data %>%
             get_aggregate_insight(input$aggregate_insight, input$aggregate_var)
     }
     data
 }

 get_vis(aggregate_insights, input$vis, input$vis_col, input$vis_facet, input$scale_fixed)

datapath = "~/stats-781/data/raw/11-0.txt"
imported <- inzightta::import_files(datapath)
prepped <- text_prep(imported)
insighted <- get_term_insight(prepped, "Term Frequency")
insighted <- get_term_insight(insighted, c("n-grams", "n-gram Frequency"), 3)

get_ngram()
get_term_insight(prepped, "Key Words", "sodfj")
get_term_insight(prepped, "Term Sentiment", "afinn")
get_term_insight(prepped, "n-gram Frequency", 3)
get_term_insight(prepped, "Moving Average Term Sentiment", "afinn", 20)
get_aggregate_insight(prepped, "Aggregated Term Count", "sentence_id")
get_aggregate_insight(prepped, "Key Sections", "sentence_id")
get_aggregate_insight(prepped, "Aggregated Sentiment", "sentence_id", "afinn", mean)
get_vis(insighted, "Page View", "Term Frequency", facet_by = "", scale_fixed = TRUE, num_terms = 10, term_index = 3, palette = "dosfj")
get_vis(insighted, "Time Series", "Term Frequency", facet_by = "", scale_fixed = TRUE)
get_vis(insighted, "Bar", "Term Frequency", facet_by = "", scale_fixed = TRUE, n = 20)
k <- "n-grams"
get_vis(insighted, "Bar", "n-gram Frequency", facet_by = "", scale_fixed = TRUE, n = 20, x = !! dplyr::sym(k))
get_vis(insighted, "Density", "Term Frequency", facet_by = "", scale_fixed = TRUE)
get_vis(insighted, "Histogram", "Term Frequency", facet_by = "", scale_fixed = TRUE)
