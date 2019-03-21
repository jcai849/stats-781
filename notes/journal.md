# Text Analytics Journal

[TOC]

## [TODO](./TODO.md#2019-03-06)

## Initial Survey

### Meetings

- [2019-03-06](./meeting_notes.md#2019-03-06)
- [2019-03-13](./meeting_notes.md#2019-03-13)
- [2019-03-20](./meeting_notes.md#2019-03-20)

### Prescribed Reading

[Text Mining with R](https://www.tidytextmining.com): [notes](./text_mining_with_r.md)

[Text Analysis with R](https://m-clark.github.io/text-analysis-with-R/)

### Consideration of Application Features

**UX/UI** must be intuitive, modelling the inherently non-linear workflow, while fitting in with the iNZight / lite environment. I wrote some notes on UX/UI [here](./ux_ui.md).

**Text Classification** seems to be a hot topic in sentiment analysis, but the question remains of whether it is within our scope (I suspect not). If it were, [openNLP](https://cran.r-project.org/web/packages/openNLP/), along with some pre-made [models](https://datacube.wu.ac.at/src/contrib/), would likely serve this topic well. An interesting example of text classification in the Dewey Decimal System is given [here](http://creatingdata.us/models/SRP-classifiers).

**[Zipf's law](../reading/Thurner2015 - Understanding Zipfs Law of Word Frequencies through Sample Space Collapse in Sentence Formation.pdf)** is referred to regularly in text analysis. Should we demonstrate this directly, as part of some other analysis, or not at all?

The **form of analysis** will vary enormously with different forms of text. There are some things constant for all forms of text, but a good deal is very specific. For example, the information of interest will differ between novels, discourse (interviews, plays, scripts), twitter posts, survey response data, or others. It may be worthwhile to either focus solely on one, or give the option to specify the type of text. 

**Data structures** will change based on the text type, and the packages used. With a tidy dataframe as our base structure, it is easy enough to convert to specific objects required by various packages, harder to convert back.

There is a natural link between **text analysis and Linguistics**, and a significant amount of the terminology in the field reflects that. Our application requires far more market share than one that a mention in a third year linguistics paper provides, and so linguistics is not going to be our primary focus. Regardless, many forms of analysis require some linguistic theory, such as those dependent on Part of Speech tagging, so it is still worthwhile to keep in mind

### Twitter

Twitter data looks particularly interesting, as it is a constantly updating, rich source of information. I wrote up some notes on text mining twitter [here](./text_mining_twitter.md). It would be particularly interesting to view twitter data in the context of discourse analysis.

### Subtitles

Subtitles are a unique form of text that would be very interesting to analyse. Subtitles for films and TV Series can be obtained easily from the site [opensubtitles](https://www.opensubtitles.org/en/search/subs), though obtaining subtitles programatically may be more difficult. It clearly is possible, as VLC has an inbuilt feature, as does [subsync](https://github.com/zerratar/SubSync), which is written in C#, so would require a port to R (probably not worth it for us at this point). Subtitles usually come as .srt files, and once the file is obtained, it's easy enough to import and work with it in R with the package [subtools](https://github.com/fkeck/subtools).

### R Packages

[Here](https://quanteda.io/articles/pkgdown/comparison.html) is a useful comparison between the major text mining packages. CRAN also has a [task view](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html) specifically for Natural Language Processing, offering many packages relevant to this project. Interestingly, they are split by linguistic category; Syntax, Semantics, and Pragmatics. The further from syntax the package is, the far more interesting it intuitively appears (eg. word count vs. sentiment analysis). Some packages of interest include:

- [tidytext](https://github.com/juliasilge/tidytext) is a text-mining package using tidy principles, providing excellent interactivity with the tidyverse, as documented in the book [Text Mining with R](https://www.tidytextmining.com)
- [tm](http://tm.r-forge.r-project.org/) is a text-mining framework that was the go-to for text mining in R, but appears to have been made redundant by tidytext and quanteda of late
- [quanteda](https://quanteda.io/) sits alone next to qdap in the Pragmatics section of the NLP task view, and offers a similar capability to tidytext, though from a more object-oriented paradigm, revolving around *corpus* objects. It also has extensions such as offering readability scores, something that may be worth implementing.
- [qdap](https://trinker.github.io/qdap/vignettes/qdap_vignette.html) is a "quantitative discourse analysis package", an extremely rich set of tools for the analysis of discourse in text, such as may arise from plays, scripts, interviews etc. Includes output on length of discourse for agents, turn-taking, and sentiment within passages of speech. This looks to me like the most insight that could be gained from a text.
- [sentimentr](https://github.com/trinker/sentimentr) is a rich sentiment analysis and tokenising package, with features including dealing with negation, amplification, etc. in multi-sentence level analysis. An interesting feature is the ability to output text with sentences highlighted according to their inferred sentiment
- [dygraphs](https://rstudio.github.io/dygraphs/) is a time-series visualisation package capable of outputting very clear interactive time-series graphics, useful for any time-series in the text analysis module
- [gganimate](https://github.com/thomasp85/gganimate) produces animations on top of the [ggplot](https://github.com/tidyverse/ggplot2) package, offering powerful insights. [Here](https://www.r-bloggers.com/investigating-words-distribution-with-r-zipfs-law-2/) is an example demonstrating Zipf's Law
- [textrank](https://github.com/bnosac/textrank) has the unique idea of extracting keywords automatically from a text using the pagerank algorithm (pagerank studied in depth in STATS 320) - my exploration of the package is documented [here](./textrank_exploration.Rmd)
- Packages for obtaining text:
  - [gutenbergr](https://cran.r-project.org/web/packages/gutenbergr/index.html) - from Project Gutenberg
  - [rtweet](https://rtweet.info/) - from Twitter
  - [wikipediar](https://cran.r-project.org/web/packages/WikipediaR/index.html) - from Wikipedia

---

Additionally, there are some packages that may not necessarily be useful for the end user, but may help for our development needs. These include:
- [udpipe](https://github.com/bnosac/udpipe) performs tokenisation, parts of speech tagging (which serves as the foundation for textrank), and more, based on the well-recognised C++ [udpipe library](http://ufal.mff.cuni.cz/udpipe), using the [Universal Treebank](https://universaldependencies.org)
- [BTM](https://github.com/bnosac/BTM) performs Biterm Topic Modelling, which is useful for "finding topics in short texts (as occurs in short survey answers or twitter data)". It uses a somewhat complex sampling procedure, and like LDA topic modelling, requires a corpus for comparison. Based on [C++ BTM](https://github.com/xiaohuiyan/BTM)
- [crfsuite](https://github.com/bnosac/crfsuite) provides a modelling framework, which is currently outside our current scope, but could be useful later
- In the analysis / removal of names, an important component of a text, [humaniformat](https://github.com/ironholds/humaniformat/) is likely to be useful
- [CRAN Task View: Web Technologies and Services](https://cran.r-project.org/web/views/WebTechnologies.html) for importing texts from the internet

### Other Text Analytics Applications

The field of text analytics applications is rather diverse, with most being general analytics applications with text analytics as a feature of the application. Some of the applications (general and specific) are given:

- [txtminer](http://www.bnosac.be/index.php/products/txtminer) is a web app for analysing text at a deep level (with something of a linguistic focus) over multiple languages, for an "educated citizen researcher"


### Scope Determination

The scope of the project is naturally limited by the amount of time available to do it. As such, exploration of topics such as discourse analysis, while interesting, is beyond the scope of the project. Analysis of text must be limited to regular texts, and comparisons between them. The application must give the greatest amount of insight to a regular user, in the shortest amount of time, into what the text is actually about.

[Cassidy's project](http://usresp-student.shinyapps.io/text_analysis) was intended to create this, and I have written notes on it [here](./cassidy_notes.md).

Ultimately, I am not completely sold on the idea that term frequencies and other base-level statistics really give that clear a picture of what a text is about. It can give some direction, and it can allow for broad classification of works (eg. a novel will usually have character names at the highest frequency ranks, scientific works usually have domain specific terms), but I think word frequencies are less useful to the analyst than to the algorithms they feed into, such as tf-idf, that may be more useful. As such, I don't think valuable screen space should be taken up by low-level statistics such as term frequencies. To me, the situation is somewhat akin to [Anscombe's Quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet), where the base statistics leave a good deal of information out, term frequencies being analogous to the modal values.

Additionally, sentiment is really just one part of determining the semantics of a text. I think too much focus is put on sentiment, which in practice is something of a "happiness meter". I would like to include other measurement schemes, such as readability, formality, etc.

Some kind of context in relation to the universal set of texts would be ideal as well, I think a lot of this analysis occurs in a vacuum, and insights are hard to come by - something like Google n-grams would be ideal.

I'm picturing a single page, where the analyst can take one look and have a fair idea of what a text is about. In reality it will have to be more complex than that, but that is my lead at the moment. With this in mind, I want to see keywords, more on *structure* of a text, context, and clear, punchy graphics showing not *just* sentiment, but several other key measurements.

### Canon

It is essential to test on a broad variety of texts in order to create the most general base application, so a "test set" will have to be developed. The list could include:

- article
  - journal (scientific, social)
  - news
  - blog
  - wikipedia
- discourse
  - interview
  - subtitles
  - tweets
- documentation
  - product manual
  - technical user guide
- literature
  - novel
  - play
  - poetry
- sports commentary

- survey response data

  - reviews

- textbook

  