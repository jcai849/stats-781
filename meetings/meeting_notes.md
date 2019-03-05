# Meeting 1, 2019-03-06

## Preparation

### TODO

- [x] [Read Text Mining with R](#reading)
- [x] [Assess Twitter api](../notes/text_mining_twitter.md)
- [x] Play with iNZight/lite, Cassidy's Project
- [x] [Consider UI](../notes/ui.md)
- [x] Consider Survey Responses
- [x] Draft UI Depictions

### Misc. Considerations

**Question**: How should this dissertation relate to Cassidy's [project outline](../reading/CassidyStuff/CassidyStuff/Our text analytics project.docx)?

Thoughts on data structures:

- dataframe seems ok for tidy text style data
- nested dataframe may be best for survey response data
- look at other styles (incl. non-tidy), maybe trees, as per parse trees etc
- Document-term matrix for tf-idf (PCA would be interesting here due to massive dimension)

Neat Packages/Features:

- Interesting package: [sentimentr](https://github.com/trinker/sentimentr), esp. it's highlighting ability and interaction with negation, amplification, etc.

- Time series visualisations are extremely powerful, want an excuse to use dygraphs (very slick)

- Animations are fantastic, how can we include them? [here](https://www.r-bloggers.com/investigating-words-distribution-with-r-zipfs-law-2/) is an  example demonstrating zipf's law

- [DDC Classification](http://creatingdata.us/models/SRP-classifiers) is very cool

- gutenbergr for automatic gutenberg files included - can implement as an inbuilt search

> Expanding on the final point; I want to include a good deal of customisation and automation in the initial text gathering. I don't want the common 3 example texts, I want, if an English class is studying Macbeth, for them to type in "Macbeth", and, unknown to them, gutenbergr automatically pulls it from the gutenburg archives, and loads it into our program. If a social studies class is learning about urbanisation, to search for "urban" in the twitter input box, and thousands of urbanisation tweets are auto-loaded for easy sentiment analysis.

Free-From written Survey Responses can be treated very similarly to twitter data, given the massive quantity of them, existing at some point in time, and belonging to individual creators.

### Reading

[Text Mining with R](https://www.tidytextmining.com): [notes](../notes/text_mining_with_r.md)

## Minutes

>  UI is something that will have to be organically developed as we go.

Meeting was mainly demonstration from Jason to Chris about the preparation done, as well as Chris demonstrating to Jason the current iNZight UX. Research so far is good, but too broad to demonstrate in the confines of a weekly meeting - Chris suggested a [solution](#actions)

## Actions

- [ ] Set notes in neat summary form (organise file structure to match)
- [ ] Push to a private github repository, give access to Chris
- [ ] Create twitter developer account, get api access token