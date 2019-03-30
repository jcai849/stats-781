Text Analytics Journal

[TOC]

# [TODO](./TODO.md#2019-03-06)

# Meetings

- [2019-03-06](./meeting_notes.md#2019-03-06)
- [2019-03-13](./meeting_notes.md#2019-03-13)
- [2019-03-20](./meeting_notes.md#2019-03-20)
- [2019-03-28](./meeting_notes.md#2019-03-28)

# Initial Survey

## Prescribed Reading

[Text Mining with R](https://www.tidytextmining.com): [notes](./text_mining_with_r.md)

[Text Analysis with R](https://m-clark.github.io/text-analysis-with-R/)

## Consideration of Application Features

**UX/UI** must be intuitive, modelling the inherently non-linear workflow, while fitting in with the iNZight / lite environment. I wrote some notes on UX/UI [here](./ux_ui.md).

**Text Classification** seems to be a hot topic in sentiment analysis, but the question remains of whether it is within our scope (I suspect not). If it were, [openNLP](https://cran.r-project.org/web/packages/openNLP/), along with some pre-made [models](https://datacube.wu.ac.at/src/contrib/), would likely serve this topic well. An interesting example of text classification in the Dewey Decimal System is given [here](http://creatingdata.us/models/SRP-classifiers).

**[Zipf's law](../reading/Thurner2015 - Understanding Zipfs Law of Word Frequencies through Sample Space Collapse in Sentence Formation.pdf)** is referred to regularly in text analysis. Should we demonstrate this directly, as part of some other analysis, or not at all?

The **form of analysis** will vary enormously with different forms of text. There are some things constant for all forms of text, but a good deal is very specific. For example, the information of interest will differ between novels, discourse (interviews, plays, scripts), twitter posts, survey response data, or others. It may be worthwhile to either focus solely on one, or give the option to specify the type of text. 

**Data structures** will change based on the text type, and the packages used. With a tidy dataframe as our base structure, it is easy enough to convert to specific objects required by various packages, harder to convert back.

There is a natural link between **text analysis and Linguistics**, and a significant amount of the terminology in the field reflects that. Our application requires far more market share than one that a mention in a third year linguistics paper provides, and so linguistics is not going to be our primary focus. Regardless, many forms of analysis require some linguistic theory, such as those dependent on Part of Speech tagging, so it is still worthwhile to keep in mind

## Twitter

Twitter data looks particularly interesting, as it is a constantly updating, rich source of information. I wrote up some notes on text mining twitter [here](./text_mining_twitter.md). It would be particularly interesting to view twitter data in the context of discourse analysis.

## Subtitles

Subtitles are a unique form of text that would be very interesting to analyse. Subtitles for films and TV Series can be obtained easily from the site [opensubtitles](https://www.opensubtitles.org/en/search/subs), though obtaining subtitles programatically may be more difficult. It clearly is possible, as VLC has an inbuilt feature, as does [subsync](https://github.com/zerratar/SubSync), which is written in C#, so would require a port to R (probably not worth it for us at this point). Subtitles usually come as .srt files, and once the file is obtained, it's easy enough to import and work with it in R with the package [subtools](https://github.com/fkeck/subtools).

## R Packages

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

## Other Text Analytics Applications

The field of text analytics applications is rather diverse, with most being general analytics applications with text analytics as a feature of the application. Some of the applications (general and specific) are given:

- [txtminer](http://www.bnosac.be/index.php/products/txtminer) is a web app for analysing text at a deep level (with something of a linguistic focus) over multiple languages, for an "educated citizen researcher"


## Scope Determination

The scope of the project is naturally limited by the amount of time available to do it. As such, exploration of topics such as discourse analysis, while interesting, is beyond the scope of the project. Analysis of text must be limited to regular texts, and comparisons between them. The application must give the greatest amount of insight to a regular user, in the shortest amount of time, into what the text is actually about.

[Cassidy's project](http://usresp-student.shinyapps.io/text_analysis) was intended to create this, and I have written notes on it [here](./cassidy_notes.md).

Ultimately, I am not completely sold on the idea that term frequencies and other base-level statistics really give that clear a picture of what a text is about. It can give some direction, and it can allow for broad classification of works (eg. a novel will usually have character names at the highest frequency ranks, scientific works usually have domain specific terms), but I think word frequencies are less useful to the analyst than to the algorithms they feed into, such as tf-idf, that may be more useful. As such, I don't think valuable screen space should be taken up by low-level statistics such as term frequencies. To me, the situation is somewhat akin to [Anscombe's Quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet), where the base statistics leave a good deal of information out, term frequencies being analogous to the modal values.

Additionally, sentiment is really just one part of determining the semantics of a text. I think too much focus is put on sentiment, which in practice is something of a "happiness meter". I would like to include other measurement schemes, such as readability, formality, etc.

Some kind of context in relation to the universal set of texts would be ideal as well, I think a lot of this analysis occurs in a vacuum, and insights are hard to come by - something like Google n-grams would be ideal.

I'm picturing a single page, where the analyst can take one look and have a fair idea of what a text is about. In reality it will have to be more complex than that, but that is my lead at the moment. With this in mind, I want to see keywords, more on *structure* of a text, context, and clear, punchy graphics showing not *just* sentiment, but several other key measurements.

# Feature Implementations
## Introduction

The application essentially consists of a feature-space, with the area  being divided in three; `Processing`, `Within-text Analytics`, and `Between-text Analytics`. This follows the general format of much of what is capable in text analysis, and what is of interest to us and our end users. The UI will likely reflect this, dividing into seperate windows/panes/tabs to accomodate. Let's look at them in turn:

### Processing

In order for text to be analysed, it must be imported and processed. A lot of this is an iterative process, coming back for further processing after analysis etc. Importing will have a "type" selection ability for the user, where they can choose from a small curated list of easy-access types, such as gutenberg search, twitter, etc. The option for a custom text-type is essential, allowing .txt, and for the particularly advanced end-user, .csv.

Once the file is imported/type is downloaded, the option should exist to allow the specification of divisions in the text. In a literary work, these include "chapter", "part", "canto", etc. A twitter type would allow division by author, by tweet, etc. An important aspect of this processing is to have a clear picture of what the data should look like. Division of a text should be associated with some visualisation of the resulting structure of the text, such as a horizontal bar graph showing the raw count of text (word count) for each division - this would allow immediate insight into the correctness of the division, by sighting obvious errors immediately, and allowing fine tuning so that, for example, the known number of chapters match up with the number of divisions. We could implement a few basic division operators in regex, while following the philosophy of allowing custom input if wanted. Example regex for "Chapter" could be `/[Cc]hapter[.:]?[ 	]{0,10}-?[ 	]{0,10}([0-9]|[ivxIVX]*))/g`, something the end user is likely not wanting to input themselves.

Removal and transformation is another important processing step for text, with stopwords and lemmatisation being invaluable. The option should exist to remove specific types of words, which can again come from prespecified lists. An aspect worth considering is if this should be done in a table manipulation, or a model - or both, with the length of the text deciding automatically based on sensible defaults. Again, the need for a clear picture of the data is essential, with some visual indication of the data during transformation and removal essential; this could take the form of some basic statistics, such as a ranking of terms by frequencies, and some random passage chosen.

Processing multiple documents is also essential. The importation is something that has to be got right, otherwise it'll be more complex than it already is, and the end-user will lose interest before the show even begins. My initial thoughts are of a tabbed import process, with each tab holding the processing tasks for each individual document, however this won't scale well to large corpus imports.

### Within-Text Analytics

Within-text analytics should have options to look at the whole text as it is, whether to look by division, or whether to look at the entire imported corpus as a whole.

A killer feature here is the production of a summary; a few key sentences that summarise the text. It's a case of using text to describe text, but done effectively, it has the potential to compress a large amount of information into a small, human-understandable object. 

Related to the summary, keywords in the text will give a good indication of topics and tone of the text, as well as perhaps more grammatical notions, such as authorial word choices. There is the possibility of using keywords as a basis for other features, such as the ability to use a search engine to find related texts from the keywords.

Bigrams and associated terms are also excellent indicators of a text. Something I particularly liked in Cassidy's project was the ability to search for a term, and see what was related to it. In that case, the text was "Peter Pan", and searching for a character's name yielded a wealth of information of the emotions and events attached to the character.

Sentiment is a feature that has been heavily developed by the field of text analytics, seeing a broad variety of uses. here, it would be worth examining sentiment, by word and over the length of the text overall.

### Between-Text Analytics

As in within-text analytics, between-text analytics should have options for specifying the component of the text that is of interest; here, the two major categories would be comparisons between divisions within an individual text, and comparisons between full texts.

Topic modelling gives an idea of what some topics are between texts - something odd to me is that there isn't a huge amount of information on topic modelling purely within a text, it always seems to be between texts (LDA etc.)

tf-idf for a general overview of terms more or less unique to different texts.

Summarisation between all texts would also be enormously useful.

## Test Corpus

It is essential to test on a broad variety of texts in order to create the most general base application, so a "test set" will have to be developed. All data is stored in the folder [data](./data/)

**Must have**

- Literature (eg. Dante's Divine Comedy)
- survey response data (eg. nzqhs, Cancer Society)
- Twitter
- transcript; lack of punctuation may cause difficulties in processing sentences.

**Would be nice**

- article
  - journal (scientific, social)
  - news
  - blog
  - wikipedia
- discourse
  - interview
  - subtitles
- documentation
  - product manual
  - technical user guide
- literature
  - novel
  - play
  - poetry
- textbook
## Text Summarisation

![Wikipedia Link](https://en.wikipedia.org/wiki/Automatic_summarization)

Text summarisation creates enormous insight, especially from a long text. There are a variety of different techniques, of varying effectiveness and efficiency. A famous example of automatic text summarisation comes from ![autotldr](https://www.reddit.com/user/autotldr), a bot on reddit that automatically generates summaries of news articles in 4-5 sentences. Autotldr is powered by ![SMMRY](https://smmry.com/about), which explains it's algorithm as working through the following steps:

1. Associate words with their grammatical counterparts. (e.g. "city" and "cities")
2. Calculate the occurrence of each word in the text.
3. Assign each word with points depending on their popularity.
4. Detect which periods represent the end of a sentence. (e.g "Mr." does not).
5. Split up the text into individual sentences.
6. Rank sentences by the sum of their words' points.
7. Return X of the most highly ranked sentences in chronological order.

The two main approaches to automatic summarisation are extractive and abstractive; **Extractive** uses some subset of the original text to form a summary, while **abstractive** techniques form semantic representations of the text. Here, we will stick to the clearer, simpler, extractive techniques for now.

[textrank](https://github.com/bnosac/textrank) has the unique idea of extracting keywords automatically from a text using the pagerank algorithm (pagerank studied in depth in STATS 320) - my exploration of the package is documented [here](./textrank_exploration.Rmd). At present, the R implementation of it creates errors for large text files, but it is worth exploring more into it - whether it is the implementation, or if it is the algorithm itself.

Hvidfeldt is a prolific blogger focussing on text analysis - he put up this tutorial on incorporating textrank with tidy methods: [tidy textRank](https://www.hvitfeldt.me/blog/tidy-text-summarization-using-textrank/)

Further summarisation experimentation is continued ![here](summarisation_experimentation.Rmd)

---

LexRank and textRank appear to exist complimentarily to one another. Below is a brief summary of how they work
	
### TextRank 

TextRank essentially finds the most representative sentence of a text based on some similarity measure to other sentence.

By dividing a text into sentences, measures of similarity between every sentence is calculated (by any number of possible similarity measures), producing an adjacency matrix of a graph with nodes being sentences, edge weights being similarity. The PageRank algorithm is then run on this graph, deriving the best connected sentences, and thereby the most representative sentences. A list is produced giving sentences with their corresponding PageRank. The top $n$ sentences can be chosen, then output in chronological order, to produce a summary.

In the generation of keywords, the same process described is typically run on unigrams, with the similarity measure being co-occurance.

### LexRank 

LexRank is essentially the same as textRank, however uses ![cosine similarity](https://en.wikipedia.org/wiki/Cosine_similarity) of tf-idf vectors as it's measure of similarity. LexRank is better at working across multiple texts, due to the inclusion of a heuristic known as "Cross-Sentence Information Subsumption (CSIS)"