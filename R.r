# --------------------------
# [*] Configurações Iniciais
# --------------------------

# Pacotes necessários
library(dplyr)
library(ggplot2)
library(gridExtra)

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

# ---------------------------------
# [1.1.2] Exemplo de Estratificação
# ---------------------------------

# Geração de dados
set.seed(11111)
n <- 150
Turno <- sample(c("Manhã", "Tarde", "Noite"), size = n, replace = TRUE)
Defeitos <- rbinom(n, size = 10, prob = 1/3)

# Data frame
df <- data.frame(Turno = Turno, Defeitos = Defeitos)

# Gráfico boxplot
ggplot(df, aes(x = Turno, y = Defeitos, fill = Turno)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set2") +
  labs(x = "Turno", y = "Defeitos") +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",          # Para imitar o `hue="Turno"` do seaborn
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    panel.border = element_blank()
  )

# --------------------------
# [1.2] Folha de Verificação
# --------------------------

# ----------------------------------------------
# [1.2.1] Exemplo de Plot - Folha de Verificação
# ----------------------------------------------

# Dados da Folha de Verificação
tipos <- c("Amassado", "Arranhão", "Bolha", "Mancha")
quantidades <- c(3, 7, 6, 9)

# Gráfico de Barras
ggplot(data = NULL, aes(x = tipos, y = quantidades)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(x = "Defeito", y = "Quantidade") +
  theme_classic(base_size = 12)

# -------------------
# [2] Gráficos Usuais
# -------------------

# ----------------
# [2.1] Histograma
# ----------------

# Exemplo Prático: Histograma
set.seed(11111)
valores <- rnorm(100, mean = mean(c(85, 120)), sd = 5.5)

# Base para histograma
df <- data.frame(valor = valores)

# Histograma 1
hist1 <- ggplot(df, aes(x = valor)) +
geom_histogram(binwidth = 5, boundary = 85, color = "white", fill = "#3B9AB2") +
labs(title = "Histograma das Medidas", x = "Valor Medido", y = "Frequência") +
theme_minimal(base_size = 12) +
theme(
  panel.grid.minor = element_blank(),
  panel.grid.major = element_line(color = "gray90"),
  axis.line = element_line(color = "black"),
  axis.ticks = element_line(color = "black"),
  panel.border = element_blank()
)

# Histograma 2 com LIE e LSE
hist2 <- ggplot(df, aes(x = valor)) +
  geom_histogram(binwidth = 5, boundary = 85, color = "white", fill = "#3B9AB2") +
  geom_vline(xintercept = 90, color = "red", linetype = "dotdash", size = 0.8) +
  geom_vline(xintercept = 110, color = "red", linetype = "dashed", size = 0.8) +
  annotate("text", x = 90, y = Inf, label = "LIE", vjust = 2, hjust = -0.1, size = 3, color = "red") +
  annotate("text", x = 110, y = Inf, label = "LSE", vjust = 2, hjust = -0.1, size = 3, color = "red") +
  labs(title = "Histograma das Medidas c/ Limites de Especificação", x = "Valor Medido", y = "Frequência") +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    panel.border = element_blank()
  )

# Exibição lado a lado
grid.arrange(hist1, hist2, ncol = 2)

# -----------------------
# [2.2] Gráfico de Pareto
# -----------------------

df <- data.frame(
  Causa = c("Erro A", "Erro B", "Erro C", "Erro D", "Erro E"),
  Frequencia = c(40, 25, 15, 12, 8)
)

# Cálculo do Percentual Acumulado
df$PercentualAcumulado <- cumsum(df$Frequencia) / sum(df$Frequencia) * 100

# ------------------------------
# Gráfico de Pareto
# ------------------------------
# Base do gráfico com barras
p <- ggplot(df, aes(x = Causa)) +
  geom_bar(aes(y = Frequencia), stat = "identity", fill = "steelblue") +
  geom_line(aes(y = PercentualAcumulado * max(Frequencia) / 100), 
            group = 1, color = "red", size = 1) +
  geom_point(aes(y = PercentualAcumulado * max(Frequencia) / 100), 
             color = "red", size = 3) +
  
  # Eixos primário e secundário
  scale_y_continuous(
    name = "Frequência",
    limits = c(0, 40),
    sec.axis = sec_axis(
      trans = ~ . / max(df$Frequencia) * 100,
      name = "Percentual Acumulado",
      labels = function(x) paste0(x, "%")
    )
  ) +
  
  labs(x = "Causa") +
  theme_classic(base_size = 12) +
  theme(
    axis.line.y.right = element_line(color = "red"),
    axis.ticks.y.right = element_line(color = "red"),
    axis.text.y.right = element_text(color = "red"),
    axis.title.y.right = element_text(color = "red"),
    panel.grid.minor = element_blank()
  )

print(p)

# ---------------------------
# [2.3] Diagrama de Dispersão
# ---------------------------

# --------------------------------------------------------
# [2.3.1] Exemplo de Correlação Linear Positiva e Negativa
# --------------------------------------------------------

# Semente para reprodutibilidade
set.seed(11111)

# Geração dos dados
x1 <- rnorm(100, mean = 50, sd = 10)
y1 <- (3/2) * x1 + rnorm(100, mean = 0, sd = 10)

x2 <- rnorm(100, mean = 50, sd = 10)
y2 <- (-3/2) * x2 + rnorm(100, mean = 0, sd = 10)

# Data frames para os gráficos
df1 <- data.frame(X = x1, Y = y1)
df2 <- data.frame(X = x2, Y = y2)

# Diagrama de Dispersão: Correlação Positiva
scatter1 <- ggplot(df1, aes(x = X, y = Y)) +
  geom_point(color = "#1f77b4") +
  labs(title = "Correlação Linear Positiva", x = "Variável X", y = "Variável Y") +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    panel.border = element_blank()
  )

# Diagrama de Dispersão: Correlação Negativa
scatter2 <- ggplot(df2, aes(x = X, y = Y)) +
  geom_point(color = "#d62728") +
  labs(title = "Correlação Linear Negativa", x = "Variável X", y = "Variável Y") +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    panel.border = element_blank()
  )

# Exibição lado a lado
grid.arrange(scatter1, scatter2, ncol = 2)


# ------------------------------------------------
# [2.3.2] Exemplo de Ausência de Correlação Linear
# ------------------------------------------------

# Semente para reprodutibilidade
set.seed(11111)

# Geração dos dados
x1 <- rnorm(100, mean = 50, sd = 5)
y1 <- rnorm(100, mean = 50, sd = 15)

# Data frame
df <- data.frame(X = x1, Y = y1)

# Diagrama de Dispersão
ggplot(df, aes(x = X, y = Y)) +
  geom_point(color = "#1f77b4") +
  labs(
    title = "Ausência de Correlação Linear",
    x = "Variável X",
    y = "Variável Y"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90"),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    panel.border = element_blank()
  )

# ---------------------------------------------------------------------------------------
# [2.3.3] Cálculo & Teste de Hipótese do/para Coeficiente de Correlação Linear de Pearson
# ---------------------------------------------------------------------------------------

# -------------------------------------------------
# [2.3.3.1] Geração do Dados & Visualização Gráfica
# -------------------------------------------------

# Fixando semente para geração
set.seed(123)

# Gerando Dados
x <- rnorm(30, mean = 10)
y <- x + rnorm(30)

# Ajustando Formato
df <- data.frame(X = x, Y = y)

# Gerando Plot
ggplot(df, aes(x = X, y = Y)) +
  geom_point(color = "lightblue", size = 3) +
  labs(title = "Relação entre X e Y",
       x = "Variável X", y = "Variável Y") +
  theme_classic(base_size = 12)

# ----------------------------------------------
# [2.3.3.2] Cálculo do Coeficiente de Correlação
# ----------------------------------------------

# Nível de Significância
ns <- 0.05

# Coeficiente de Correlação de Pearson
result <- cor.test(x, y)

# Impressão dos resultados
cat("Coeficiente de Correlação de Pearson: r =", round(result$estimate, 4), "\n")
cat("Intervalo de Confiança (", (1 - ns)*100,"%):", round(result$conf.int[1], 4), round(result$conf.int[2], 4))

# ----------------------------------------------------------
# [2.3.3.3] Teste de Hipótese para Coeficiente de Correlação
# ----------------------------------------------------------

# ---------------------------------------
# [2.3.3.3.1] Verificação de Pressupostos
# ---------------------------------------

# Verificação dos Pressupostos (Normalidade)
shapiro.test(x)
shapiro.test(y)

# -------------------------------------
# [2.3.3.3.2] Aplicar Teste de Hipótese
# -------------------------------------

# Impressão dos resultados
cat("Estatística de Teste: t =", round(result$statistic, 4), "\n")
cat("Graus de Liberdade: gl =", result$parameter, "\n")
cat("Valor-p:", round(result$p.value, 4), "\n")