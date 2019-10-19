p <- c("base", "readr", "tibble", "stringr", "dplyr", "readxl",
       "purrr", "tidytext", "textstem", "magrittr", "stats",
       "textrank", "lexRankr", "ggpage", "ggplot2", "forcats",
       "shiny", "ggwordcloud", "textdata", "tm", "quanteda",
       "sentimentr", "dygraphs", "gutenbergr", "rtweet", "udpipe",
       "BTM", "crfsuite", "humaniformat", "gganimate", "WikipediaR")

filename <- "Rcitations.bib"
file.create(filename)
invisible(lapply(lapply(p, function(x)toBibtex(citation(x))),
                 write, filename, append = TRUE))

missing <- c("qdap")
