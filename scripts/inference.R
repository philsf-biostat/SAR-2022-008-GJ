# setup -------------------------------------------------------------------

# tables ------------------------------------------------------------------

tab_inf <- svy %>%
  tbl_svysummary(
    include = iv,
    by = dv,
  ) %>%
  add_overall() %>%
  add_p(
    test = everything() ~ "svy.adj.chisq.test",
  )

tab_inf_22_f <- svy_f %>%
  tbl_svysummary(
    include = iv2,
    by = dv2,
  ) %>%
  bold_labels() %>%
  add_p(
    test = everything() ~ "svy.adj.chisq.test",
  )

tab_inf_22_m <- svy_m %>%
  tbl_svysummary(
    include = iv2,
    by = dv2,
  ) %>%
  bold_labels() %>%
  add_p(
    test = everything() ~ "svy.adj.chisq.test",
  )

tab_inf_22_o <- svy %>%
  tbl_svysummary(
    include = iv2,
    by = dv2,
  ) %>%
  bold_labels() %>%
  add_p(
    test = everything() ~ "svy.adj.chisq.test",
  )

tab_inf_22 <- tbl_merge(list(
  tab_inf_22_o,
  tab_inf_22_m,
  tab_inf_22_f
), c("Overall", "Males", "Females"))
