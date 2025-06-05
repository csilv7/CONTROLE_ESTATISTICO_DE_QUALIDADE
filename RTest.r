# --------------------------
# [*] Configurações Iniciais
# --------------------------

library(ggplot2)
library(dplyr)

# -----------------------
# [1] Ferramentas Básicas
# -----------------------

# --------------------
# [1.1] Estratificação
# --------------------

# ---------------------------------
# [1.1.1] Exemplo de Estratificação
# ---------------------------------

# Definir semente
set.seed(11111)

# Grupo A
group1_size <- 30
group1_x <- rnorm(group1_size, mean = 10, sd = 2.5)
group1_y <- rnorm(group1_size, mean = 20, sd = 3.5)

# Grupo B
group2_size <- 40
group2_x <- rnorm(group2_size, mean = 20, sd = 3.5)
group2_y <- rnorm(group2_size, mean = 30, sd = 4.5)

# Grupo C
group3_size <- 30
group3_x <- rnorm(group3_size, mean = 30, sd = 4.5)
group3_y <- rnorm(group3_size, mean = 15, sd = 2.5)

# DataFrame unificado
df <- data.frame(
  x = c(group1_x, group2_x, group3_x),
  y = c(group1_y, group2_y, group3_y),
  Grupo = factor(c(
    rep("Grupo A", group1_size),
    rep("Grupo B", group2_size),
    rep("Grupo C", group3_size)
  ))
)

# Gráfico com ggplot2
ggplot(df, aes(x = x, y = y, color = Grupo)) +
  geom_point(size = 3) +
  scale_color_viridis_d() +
  labs(x = "X", y = "y", color = "Grupo") +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "top",
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    panel.border = element_blank()
  )