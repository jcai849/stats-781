source("depends.R")

word_wrap <- function(sent_df,
                      word_df,
                      algorithm="freq",
                      n=5
                      ...){
    if(algorithm == "lexRank-keywords"){
        print("lexRank")
        lexrank(x, ...)
    }
    else if(algorithm == "textrank"){
        print("textrank")
    }
    else{
        stop("Incorrect text summarisation algorithm selected; must either be \"lexRank\" or \"textrank\"")
    }
}


