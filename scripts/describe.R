# setup -------------------------------------------------------------------

# library(gmodels) # CrossTable
library(gtsummary)
library(gt)
library(survey)

# setup gtsummary theme
theme_gtsummary_journal("jama")
theme_gtsummary_compact()
theme_gtsummary_mean_sd() # mean/sd

# survey design
svy <- svydesign(
  ids = ~1,
  data = analytical,
  weights = ~postwt)

# exploratory -------------------------------------------------------------

# overall description
# analytical %>%
#   skimr::skim()
# svytotal(~q21 + q1, design = svy)
# svymean(~q21 + q1, design = svy)

# source population size
N <- data.raw %>% summarise(N_hat = sum(postwt)) %>% pull(N_hat) %>% round
# source population size (cleaned)
N_hat <- analytical %>% summarise(N_hat = sum(postwt)) %>% pull(N_hat) %>% round

# prop sex (male)
prop_male <- svymean(~dsex, svy) %>% as.matrix()
prop_male <- prop_male[1]

# prop outcome
prop_dv_agree <- svymean(~q1, svy) %>% as.table()
prop_dv_agree <- sum(prop_dv_agree[4:5])

# prop IV
prop_iv_agree <- svymean(~q21, svy) %>% as.table()
prop_iv_agree <- sum(prop_iv_agree[4:5])

# tables ------------------------------------------------------------------

tab_desc <- svy %>%
  tbl_svysummary(
    include = -id,
  ) %>%
  bold_labels() %>%
  modify_table_styling(columns = "label", align = "c")
