library(tidyverse)
library(tidytext)

source("../src/summ-wrapper.R")

article <-
  read_table("../data/raw/lex-text.txt", col_names = FALSE)$X1 %>%
  paste(collapse = "\n")

article_sentences <- tibble(text = article) %>%
  unnest_tokens(sentence, text, token = "sentences") %>%
  mutate(sentence_id = row_number()) %>%
  select(sentence_id, sentence)

article_words <- article_sentences %>%
    unnest_tokens(word, sentence)

article_summary <- textrank_sentences(data = article_sentences)

article_lexsentences <-
    lexRank(article_sentences$sentence, sentencesAsDocs = TRUE, n = 8)


text_summ(algorithm)
text_summ(algorithm="textrank")
text_summ(algorithm="nonsense")
