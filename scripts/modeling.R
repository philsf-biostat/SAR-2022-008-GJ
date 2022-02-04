# setup -------------------------------------------------------------------
library(broom)
library(epitools)

# pretty format of OR + CI
or_format <- function(or, digits = 2) {
  paste0(
    "OR: ",
    format.float(or[1], digits),
    ", ",
    "95% CI: ",
    format.interval(or[2:3], digits)
  )
}

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

dv_m <- svychisq(~iv2 + dv2, svy_m, statistic = "Chisq") %>% tidy
dv_m_p <- dv_m %>% pull(p.value)

dv_f <- svychisq(~iv2 + dv2, svy_f, statistic = "Chisq") %>% tidy
dv_f_p <- dv_f %>% pull(p.value)

cmh <- svytable(~iv2 + dv2 + dsex, svy) %>% mantelhaen.test() %>% tidy
cmh_p <- cmh %>% pull(p.value)

# OR ----------------------------------------------------------------------

or_o <- svytable(~ iv2 + dv2, svy) %>% oddsratio() %>% suppressWarnings()
or_o <- or_o$measure[2, ]
or_m <- svytable(~ iv2 + dv2, svy_m) %>% oddsratio() %>% suppressWarnings()
or_m <- or_m$measure[2, ]
or_f <- svytable(~ iv2 + dv2, svy_f) %>% oddsratio() %>% suppressWarnings()
or_f <- or_f$measure[2, ]
cmh_or <- cmh[c("estimate", "conf.low", "conf.high")]
