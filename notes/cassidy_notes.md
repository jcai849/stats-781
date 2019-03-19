# Cassidy Notes

## Initial Sense

I like that the application has clear guidance, with an introduction and a clear process without the need for a manual. All critique is purely for the sake of improvement, from a demanding perspective.

## Sections

### Data Upload

The provided dataset is scant - it would be far more interesting to have the ability to type in the name of a text and have it imported all in-app.

In the data cleaning stage of line removal, it was difficult to see what line number to remove to.

The reflection section seems over-cautious; High-School English students are going to roll their eyes at it

### Data Wrangling

It would be nice to see a list of stop words, outside of the few examples given in the paragraph. Some additional lists of pre-provided words could be worthwhile, such as a list of names.

### Frequency Plots

Plots are controllable with sliders, but still static - the ability to react with mouseover etc. would be great

Having to manually size the wordcloud is a bit clumsy

### Sentiment Analysis

Sentiment Contribution plot is interesting, tells a bit about what common emotive words are in a text. Doesn't feel like I gain a huge amount of information about a text from it though, it is more of a commentary on syntax.

Sentiment over time is, I think, hugely useful for the interpretation of a text. I would dedicate most resources into breaking something like that down.

The wordcloud is just another way of showing the same information as sentiment contribution, and I don't think it really adds much information.

### Visualising relationships

I intuitively thought it was relationships between discrete texts, not necessarily internally.

The network graph of co-occurances also isn't really useful, I don't think I gained any further insight into the text than first name -> surname pairings. Same with common bigrams. 

The correlation table and associated graph was excellent, I found a lot of clear topics in the text through exploring with that tool

### Multiple Files

Should be called multiple texts. The data upload feature didn't provide a clear means of inputting multiple texts. I think this is an area which requires the greatest amount of work. I think with comparisons between texts, some of the best insight is gained, as context starts to develop, especially with tools such as topic modelling. and tf-idf

## Conclusion

The application provides an excellent starting point for the text analytics project. There are a lot of features I would implement differently, jettisoning a number of what currently exists, and including many that aren't currently implemented. I think this project followed the tidytext paradigm very closely, and I would like to use that as a basis, but break free of it a bit, which is easy enough in practice when converting between objects. A consistent view of what the data looks like would also be ideal; I can't remember what column holds what variables, or what the dataframe looks like.