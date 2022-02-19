# Builds a bar graph with porportion of those incarcerated on the y axis and race/gender on the
# x axis. Refer to my presentation on graphing for more detail.

read_csv(here("data/NLSY97_clean.csv")) %>%
  group_by(race, gender) %>%
  summarize(was_incarcerated = mean(was_incarcerated)) %>%
  ggplot(aes(race, was_incarcerated, fill = gender)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(
      x = "Race", 
      y = "Proportion Incacerated",
      fill = "Gender",
      title = "Proportion Incarcerated in 2002 by Race and Gender") +
    theme_minimal() +
    scale_fill_economist()

ggsave(here("figures/incarcerated_by_racegender.png"), width=8, height=4.5)


