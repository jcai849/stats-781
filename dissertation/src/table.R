library(tidyverse)
library(readxl)
library(lubridate)


imported <- read_excel("../data/ADHB encrypted - V1.xlsx")

adhb <- imported %>%
    filter(!is.na(NHI)) %>%
    mutate(date = parse_date_time(`Assessment date`,
                                  "b-Y"),
           hba1c = `HbA1c (Calc)`)

filtered_adhb <- adhb %>%
    select(NHI, hba1c, date) %>%
    filter(hba1c > 0 &
           hba1c < 500) %>%
    na.omit() %>%
    distinct()

adhb_baseline <- filtered_adhb %>%
    group_by(NHI, date) %>%
    mutate(hba1c = mean(hba1c)) %>%
    ungroup() %>%
    group_by(NHI) %>%
    arrange(date) %>%
    summarise(date = head(date, 1),
              hba1c = head(hba1c, 1))

N <- length(filtered_adhb$NHI)
n <- length(unique(filtered_adhb$NHI))
mean_bl_HbA1c <- mean(adhb_baseline$hba1c)
sd_b1_HbA1c <- sd(adhb_baseline$hba1c)
median_b1_HbA1c <- median(adhb_baseline$hba1c)
min_b1_HbA1c <- min(adhb_baseline$hba1c)
max_b1_HbA1c <- max(adhb_baseline$hba1c)
n_removed <- nrow(imported) - nrow(filtered_adhb)
low_outliers <- sum(filtered_adhb$hba1c < 30)
high_outliers <- sum(filtered_adhb$hba1c > 170)

Description <- c("Number of Observations",
                 "Number of Individual Cases",
                 "Mean HbA1c at Baseline",
                 "Standard Deviation of HbA1c at Baseline",
                 "Median HbA1c at Baseline",
                 "Minimum HbA1c at Baseline",
                 "Maximum HbA1c at Baseline",
                 "Total Removed Observations",
                 "Low Outliers (HbA1c < 30)",
                 "High Outliers (HbA1c > 170)")

Value <- round(c(N,
                 n,
                 mean_bl_HbA1c,
                 sd_b1_HbA1c,
                 median_b1_HbA1c,
                 min_b1_HbA1c,
                 max_b1_HbA1c,
                 n_removed,
                 low_outliers,
                 high_outliers))

output_table <- data.frame(Description, Value)

write(print(xtable::xtable(output_table, display=c("d", "s", "d")),
            floating=FALSE,latex.environments=NULL,booktabs=TRUE, include.rownames=FALSE),
      "output_table")
