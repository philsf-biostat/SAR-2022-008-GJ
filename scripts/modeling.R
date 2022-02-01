# setup -------------------------------------------------------------------
library(broom)

# associations with sex ---------------------------------------------------

dv_chi <- svychisq(~dv + dsex, svy, statistic = "Chisq") %>% tidy
dv_chi_p <- dv_chi %>% pull(p.value)

iv_chi <- svychisq(~iv + dsex, svy, statistic = "Chisq") %>% tidy
iv_chi_p <- iv_chi %>% pull(p.value)

# per sex analysis --------------------------------------------------------

svy_m <- svydesign(ids = ~1,
                   data = analytical %>% filter(dsex == "Male"),
                   weights = ~postwt)
svy_f <- svydesign(ids = ~1,
                   data = analytical %>% filter(dsex == "Female"),
                   weights = ~postwt)

dv_m <- svychisq(~iv + dv, svy_m, statistic = "Chisq") %>% tidy
dv_m_p <- dv_m %>% pull(p.value)

dv_f <- svychisq(~iv + dv, svy_f, statistic = "Chisq") %>% tidy
dv_f_p <- dv_f %>% pull(p.value)
