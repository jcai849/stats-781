library(tidyverse)
library(readxl)
library(gutenbergr)
library(WikipediR)
library(rvest)
library(xml2)


#   __________________ #< b3c615e9253a4b533d634cf3015b4c58 ># __________________
#   Literature                                                              ####
##  .................. #< 2d6d0751d14cc24f5a7bd65db30756a0 ># ..................
##  Initial Import                                                          ####

# gutenberg_search <-
#   gutenberg_works(str_detect(title, "Divine Comedy")) %>%
#   head %>%
#   select(gutenberg_id, title)
# dante <-
#   gutenberg_download(1004)
# saveRDS(dante, "./processed/dante.rds")

##  .................. #< c818be2c05f874fd410b436b6162d2b1 ># ..................
##  Subsequent Import                                                       ####

dante <-
  readRDS("./processed/dante.rds")

#   __________________ #< 5446ab2477469ba9e03c35c5135bba3a ># __________________
#   Survey Response                                                         ####
##  .................. #< f3240d26d9389b2e0509dbc9b9affb99 ># ..................
##  Initial Import                                                          ####

# cancer_soc <-
#   read_excel("./raw/Cancer Soc.xlsx")
# nzqhs <-
#   read_excel("./raw/Schonlau1.xls")

### . . . . . . . . .. #< 05b117d3d0c44bad308f9c8ae54e29b3 ># . . . . . . . . ..
### Processing                                                              ####

# Return here if the files need processing, (they probably will)

# saveRDS(cancer_soc, "./processed/cancer_soc.rds")
# saveRDS(nzqhs, "./processed/nzqhs.rds")

##  .................. #< 29f9c697a6bd4e8e342374a3da9ee60c ># ..................
##  Subsequent Import                                                       ####

cancer_soc <-
  readRDS("./processed/cancer_soc.rds")
nzqhs <-
  readRDS("./processed/nzqhs.rds")

#   __________________ #< 4336ecb808ce91ceffa132eee118c3fd ># __________________
#   Wikipedia                                                               ####
##  .................. #< 330c2111192ea0cbf29620e758f47eae ># ..................
##  Initial Import                                                          ####

# very difficult to generalise, may not be worth it

# test <-
#   page_content("en","wikipedia", page_name = "statistics")$parse$text[[1]] %>%
#   read_html

##  .................. #< ea100e70982cfbcd4803b3a9c23b18f5 ># ..................
##  Subsequent Import                                                       ####

#   __________________ #< 256e9332efcf239b643862d0c020dae4 ># __________________
#   News Article                                                            ####
##  .................. #< 9346030df6a7055cafe86c826220cc66 ># ..................
##  Initial Import                                                          ####


##  .................. #< de0746e9532256fb2acb99f77715c433 ># ..................
##  Subsequent Import                                                       ####


#   __________________ #< f62898c7221d4e24f33f99c95f4fc06a ># __________________
#   Twitter                                                                 ####


