# setup -------------------------------------------------------------------
library(philsfmisc)
library(data.table)
library(tidyverse)

# data loading ------------------------------------------------------------
set.seed(42)
data.raw <- fread("dataset/FEVS_2020_PRDF.csv") %>%
  janitor::clean_names()

# data cleaning -----------------------------------------------------------

data.raw <- data.raw %>%
  select(random_id, agency, q1, q21, q29, q58, dsex, postwt) %>%
  mutate() %>%
  filter(agency == "NN")

# save dataset ------------------------------------------------------------

write_csv(data.raw, "dataset/FEVS_2020_PRDF_NASA.csv")
