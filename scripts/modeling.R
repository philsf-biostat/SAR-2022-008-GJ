# setup -------------------------------------------------------------------
library(broom)

# raw estimate ------------------------------------------------------------
dv_chi <- svychisq(~dv + dsex, svy, statistic = "Chisq") %>% tidy
dv_chi_p <- dv_chi %>% pull(p.value)

iv_chi <- svychisq(~iv + dsex, svy, statistic = "Chisq") %>% tidy
iv_chi_p <- dv_chi %>% pull(p.value)

# adjusted ----------------------------------------------------------------
