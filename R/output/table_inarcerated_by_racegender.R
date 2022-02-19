# Builds a LaTeX table of proportion of those incarcerated by race and gender.
# See the pivoting vignette for how to use pivot functions.
# vignette("pivot")
# Documentation for the kableExtra package is here:
# https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_pdf.pdf

read_csv(here("data/NLSY97_clean.csv")) %>%
  
  # summarize proportion incarcerated by race and gender
  group_by(race, gender) %>%
  summarize(was_incarcerated = mean(was_incarcerated)) %>%
  
  # pivot the values from race into columns
  pivot_wider(names_from = race, values_from = was_incarcerated) %>%
  
  # rename columns using snakecase
  rename_with(to_title_case) %>%
  
  # create the kable object. Requires booktabs and float LaTeX packages
  kbl(
    caption = "Proportion Incarcerated in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "tab:summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>%
  
  write_lines(here("tables/incarcerated_by_racegender.tex"))
  