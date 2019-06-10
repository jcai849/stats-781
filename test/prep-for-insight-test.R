source("../src/prep-for-insight.R")

## Alice In Wonderland
read_lines(filepath) %>% # Without import function
    tibble(text=.)

import_txt("../data/raw/11-0.txt") # Import function

stopwords <- get_sw(addl = c("lewis", "alice's", "alice’s", "EbOoK"))

import_txt("../data/raw/11-0.txt") %>%
    stopword_remove(stopwords)
