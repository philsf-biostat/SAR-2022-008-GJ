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

# tables ------------------------------------------------------------------

tab_desc <- svy %>%
  tbl_svysummary(
    include = -id,
  ) %>%
  bold_labels() %>%
  modify_table_styling(columns = "label", align = "c")
