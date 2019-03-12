# Text Analytics Journal

[TOC]

## [TODO](./TODO.md#2019-03-06)

## Initial Survey

### Meetings

- [2019-03-06](./meeting_notes.md#2019-03-06)
- [2019-03-13](./meeting_notes.md#2019-03-13)

### Prescribed Reading

[Text Mining with R](https://www.tidytextmining.com): [notes](./text_mining_with_r.md)

### Consideration of Application Features

UX/UI: Must be intuitive, modelling the inherently non-linear workflow, while fitting in with the iNZight / lite environment. I wrote some notes on UX/UI [here](./ux_ui.md).

Text Classification seems to be a hot topic in sentiment analysis, but the question remains of whether it is within our scope (I suspect not). If it were, [openNLP](https://cran.r-project.org/web/packages/openNLP/), along with some pre-made [models](https://datacube.wu.ac.at/src/contrib/), would likely serve this topic well. An interesting example of text classification in the Dewey Decimal System is given [here](http://creatingdata.us/models/SRP-classifiers).

[Zipf's law](../reading/Thurner2015 - Understanding Zipfs Law of Word Frequencies through Sample Space Collapse in Sentence Formation.pdf) is referred to regularly in text analysis. Should we demonstrate this directly, as part of some other analysis, or not at all?

The form of analysis will vary enormously with different forms of text. There are some things constant for all forms of text, but a good deal is very specific. For example, the information of interest will differ between novels, discourse (interviews, plays, scripts), twitter posts, survey response data, or others. It may be worthwhile to either focus solely on one, or give the option to specify the type of text. 

Twitter data looks particularly interesting, as it is a constantly updating, rich source of information. I wrote up some notes on text mining twitter [here](./text_mining_twitter.md). It would be particularly interesting to view twitter data in the context of discourse analysis.

Data structures will change based on the text type, and the packages used. With a tidy dataframe as our base structure, it is easy enough to convert to specific objects required by various packages, harder to convert back

There is a natural link between text analysis and Linguistics, and a significant amount of the terminology in the field reflects that. Our application requires far more market share than one that a mention in a third year linguistics paper provides, and so linguistics is not going to be our primary focus. Regardless, many forms of analysis require some linguistic theory, such as those dependent on Part of Speech tagging, so it is still worthwhile to keep in mind

### R Packages

[Here](https://quanteda.io/articles/pkgdown/comparison.html) is a useful comparison between the major text mining packages

CRAN also has a [task view](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html) specifically for Natural Language Processing, offering many packages relevant to this project. Interestingly, they are split by linguistic category; Syntax, Semantics, and Pragmatics. The further from syntax the package is, the far more interesting it intuitively appears (eg. word count vs. sentiment analysis)

[tidytext](https://github.com/juliasilge/tidytext) is a text-mining package using tidy principles, providing excellent interactivity with the tidyverse, as documented in the book [Text Mining with R](https://www.tidytextmining.com)

[tm](http://tm.r-forge.r-project.org/) is a text-mining framework that was the go-to for text mining in R, but appears to have been made redundant by tidytext and quanteda of late

[quanteda](https://quanteda.io/) sits alone next to qdap in the Pragmatics section of the NLP task view, and offers a similar capability to tidytext, though from a more object-oriented paradigm, revolving around *corpus* objects. It also has extensions such as offering readability scores, something that may be worth implementing.

[qdap](https://trinker.github.io/qdap/vignettes/qdap_vignette.html) is a "quantitative discourse analysis package", an extremely rich set of tools for the analysis of discourse in text, such as may arise from plays, scripts, interviews etc. Includes output on length of discourse for agents, turn-taking, and sentiment within passages of speech. This looks to me like the most insight that could be gained from a text.

[sentimentr](https://github.com/trinker/sentimentr) is a rich sentiment analysis and tokenising package, with features including dealing with negation, amplification, etc. in multi-sentence level analysis. An interesting feature is the ability to output text with sentences highlighted according to their inferred sentiment

[dygraphs](https://rstudio.github.io/dygraphs/) is a time-series visualisation package capable of outputting very clear interactive time-series graphics, useful for any time-series in the text analysis module

[gganimate](https://github.com/thomasp85/gganimate) produces animations on top of the [ggplot](https://github.com/tidyverse/ggplot2) package, offering powerful insights. [Here](https://www.r-bloggers.com/investigating-words-distribution-with-r-zipfs-law-2/) is an example demonstrating Zipf's Law

[textrank](https://github.com/bnosac/textrank) has the unique idea of extracting keywords automatically from a text using the pagerank algorithm (pagerank studied in depth in STATS 320)

Packages for obtaining text:

- [gutenbergr](https://cran.r-project.org/web/packages/gutenbergr/index.html) - from Project Gutenberg
- [rtweet](https://rtweet.info/) - from Twitter
- [wikipediar](https://cran.r-project.org/web/packages/WikipediaR/index.html) - from Wikipedia