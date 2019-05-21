library(textrank)
library(lexRankr)

summ_algo <- function(x,
                      algorithm="lexRank",
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


