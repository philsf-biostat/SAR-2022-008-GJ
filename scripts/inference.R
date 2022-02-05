# setup -------------------------------------------------------------------

# overall description of responses ----------------------------------------

tab_inf <- svy %>%
  tbl_svysummary(
    include = iv,
    by = dv,
  ) %>%
  add_overall() %>%
  add_p(
    test = everything() ~ "svy.adj.chisq.test",
  )

# weighted stratified analysis --------------------------------------------

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

# unweighted stratified analysis ------------------------------------------

tab_inf_22_o_un <- analytical %>%
  filter() %>%
  select(iv2, dv2) %>%
  tbl_cross(
    iv2,
    dv2,
  ) %>%
  bold_labels() %>%
  add_p()

tab_inf_22_m_un <- analytical %>%
  filter(dsex == "Male") %>%
  select(iv2, dv2) %>%
  tbl_cross(
    iv2,
    dv2,
  ) %>%
  bold_labels() %>%
  add_p()

tab_inf_22_f_un <- analytical %>%
  filter(dsex == "Female") %>%
  select(iv2, dv2) %>%
  tbl_cross(
    iv2,
    dv2,
  ) %>%
  bold_labels() %>%
  add_p()

tab_inf_22_un <- tbl_merge(list(
  tab_inf_22_o_un,
  tab_inf_22_m_un,
  tab_inf_22_f_un
), c("Overall", "Males", "Females"))
