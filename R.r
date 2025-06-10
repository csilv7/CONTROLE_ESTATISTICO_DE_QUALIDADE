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

# ------------------------
# [3] Gráficos de Controle
# ------------------------

# -----------------------------------------------------------------------------------------------------------------------------------------------------------
# [*] Exemplo (6.1) página 239 [@montgomery2013controle] - Medições da Largura de Fluxo (mícrons) para o Processo de Cozimento Duro: 
# "O processo de cozimento duro é utilizado em conjunto com a fotolitografia na fabricação de semicondutores. Desejamos estabelecer o controle estatístico 
# da largura de fluxo do resistor neste processo utilizando gráficos de $\bar{X}$ e $\bar{AT}$. Vinte e cinco amostras, cada uma com wafers de tamanho cinco, 
# foram coletadas quando acreditamos que o processo está sob controle. O intervalo de tempo entre as amostras ou subgrupos é de uma hora. Os dados de medição 
# da largura de fluxo (em x mícrons) dessas amostras são mostrados na Tabela 6.1.
# -----------------------------------------------------------------------------------------------------------------------------------------------------------

# Dados do Problema
dados <- c(
  1.3235, 1.4128, 1.6744, 1.4573,
  1.4314, 1.3592, 1.6075, 1.4666,
  1.4284, 1.4871, 1.4932, 1.4324,
  1.5028, 1.6352, 1.3841, 1.2831,
  1.5604, 1.2735, 1.5265, 1.4362,
  1.5955, 1.5451, 1.3574, 1.3281,
  1.6274, 1.5064, 1.8366, 1.4177,
  1.4190, 1.4303, 1.6637, 1.6067,
  1.3884, 1.7277, 1.5355, 1.5176,
  1.4039, 1.6697, 1.5089, 1.6477,
  1.4158, 1.7667, 1.4278, 1.5927,
  1.5821, 1.3355, 1.5777, 1.3908,
  1.2856, 1.4106, 1.4447, 1.6388,
  1.4951, 1.4036, 1.5893, 1.6458,
  1.3589, 1.2863, 1.5996, 1.2497,
  1.5747, 1.5301, 1.5171, 1.1839,
  1.3680, 1.7269, 1.3957, 1.5019,
  1.4163, 1.3864, 1.3057, 1.6210,
  1.5796, 1.4185, 1.6541, 1.5116,
  1.7106, 1.4412, 1.2361, 1.3824,
  1.4371, 1.5051, 1.3485, 1.5670,
  1.4738, 1.5936, 1.6583, 1.4973,
  1.5917, 1.4333, 1.5551, 1.5295,
  1.6399, 1.5243, 1.5705, 1.5563,
  1.5797, 1.3663, 1.6240, 1.3732
)

# Formatação de Vetor para Matriz & de Matriz para Data Frame
tbl <- matrix(dados, ncol = 4, byrow = TRUE)
tbl.df <- data.frame(tbl)

# Visualizar
tbl.df

# -----------------------------------------------------------
# 1. Calcule os limites de controle para o gráfico $\bar{X}$.
# -----------------------------------------------------------

# Média por Linha e Média das Médias
row_mean <- apply(tbl.df, 1, mean)
mean_X_bar <- mean(row_mean)

# Função de Amplitude Total
f.range <- function(vec) max(vec) - min(vec)

# Amplitude por Linha e Média da Amplitude
row_range <- apply(tbl.df, 1, f.range)
mean_range <- mean(row_range)

# Valor de Referência
A2 <- 0.729

# Limites de Controle
LIC_X_bar = mean_X_bar - A2 * mean_range
LSC_X_bar = mean_X_bar + A2 * mean_range

# Impressão dos Resultados
cat("LIC =", round(LIC_X_bar, 4), "\n")
cat("LC =", round(mean_X_bar, 4), "\n")
cat("LSC =", round(LSC_X_bar, 4))

# ------------------------------------------------------------
# 2. Calcule os limites de controle para o gráfico $\bar{AT}$.
# ------------------------------------------------------------

# Valores de Referência
D3 <- 0
D4 <- 2.282

# Limites de Controle
LIC_AT = D3 * mean_range
LSC_AT = D4 * mean_range

# Impressão dos Resultados
cat("LIC =", round(LIC_AT, 4), "\n")
cat("LC =", round(mean_range, 4), "\n")
cat("LSC =", round(LSC_AT, 4))

# -----------------------------
# 3. Construa os dois gráficos.
# -----------------------------

ggplot(data = NULL, aes(x = 1:length(row_mean), y = row_mean)) +
  geom_point(color = "black", size = 2) +
  geom_line(color = "black") +
  geom_hline(aes(yintercept = mean_X_bar, color = "Média Geral"), linewidth = 1) +
  geom_hline(aes(yintercept = LIC_X_bar, color = "LIC"), linetype = 2, linewidth = 1) +
  geom_hline(aes(yintercept = LSC_X_bar, color = "LSC"), linetype = 2, linewidth = 1) +
  scale_color_manual(
    name = NULL,
    values = c("LIC" = "red", "LSC" = "red", "Média Geral" = "blue"),
    labels = c(
      bquote(LIC == .(LIC_X_bar)), 
      bquote(LSC == .(LSC_X_bar)), 
      bquote(hat(mu) == .(mean_X_bar))
    )
  ) +
  labs(
    x = "Amostra",
    y = "Medidas",
    title = bquote("Gráfico de" ~ bar(X))
  ) +
  theme_classic(base_size = 12) +
  theme(legend.position = "top")

# -----------------------------

ggplot(data = NULL, aes(x = 1:length(row_range), y = row_range)) +
  geom_point(color = "black", size = 2) +
  geom_line(color = "black") +
  geom_hline(aes(yintercept = mean_range, color = "Amplitude Média"), linewidth = 1) +
  geom_hline(aes(yintercept = LIC_AT, color = "LIC"), linetype = 2, linewidth = 1) +
  geom_hline(aes(yintercept = LSC_AT, color = "LSC"), linetype = 2, linewidth = 1) +
  scale_color_manual(
    name = NULL,
    values = c("LIC" = "red", "LSC" = "red", "Amplitude Média" = "blue"),
    labels = c(
      bquote(bar(AT) == .(mean_range)),
      bquote(LIC == .(LIC_AT)), 
      bquote(LSC == .(LSC_AT))
    )
  ) +
  labs(
    x = "Amostra",
    y = "Medidas",
    title = bquote("Gráfico de" ~ AT)
  ) +
  theme_classic(base_size = 12) +
  theme(legend.position = "top")

# --------------------------------------------
# 4. Calcule o desvio padrão de cada subgrupo.
# --------------------------------------------

# Desvio Padrão por Linha
row_std = apply(tbl.df, 1, sd)

# Visualizar
row_std

# ---------------------------------------------------------------------------------
# 5. Calcule a média dos desvios $\bar{S}$ e os limites de controle do gráfico $S$.
# ---------------------------------------------------------------------------------

# Média do Desvio Padrão
mean_S <- mean(row_std)

# Valores de Referência
B3 <- 0
B4 <- 2.266

# Limites de Controle
LIC_S = B3 * mean_S
LSC_S = B4 * mean_S

# Impressão dos Resultados
cat("LIC =", round(LIC_S, 4), "\n")
cat("LC =", round(mean_S, 4), "\n")
cat("LSC =", round(LSC_S, 4))

# ---------------------------------------
# 6. Construa o gráfico do Desvio Padrão.
# ---------------------------------------

ggplot(data = NULL, aes(x = 1:length(row_std), y = row_std)) +
  geom_point(color = "black", size = 2) +
  geom_line(color = "black") +
  geom_hline(aes(yintercept = mean_S, color = "Desvio Padrão Médio"), linewidth = 1) +
  geom_hline(aes(yintercept = LIC_S, color = "LIC"), linetype = 2, linewidth = 1) +
  geom_hline(aes(yintercept = LSC_S, color = "LSC"), linetype = 2, linewidth = 1) +
  scale_color_manual(
    name = NULL,
    values = c("LIC" = "red", "LSC" = "red", "Desvio Padrão Médio" = "blue"),
    labels = c(
      bquote(bar(S) == .(mean_S)),
      bquote(LIC == .(LIC_S)), 
      bquote(LSC == .(LSC_S))
    )
  ) +
  labs(
    x = "Amostra",
    y = "Medidas",
    title = bquote("Gráfico de" ~ S)
  ) +
  theme_classic(base_size = 12) +
  theme(legend.position = "top")

# ----------------------------------------------------
# 7. Alguma amostra está fora dos limites de controle?
# ----------------------------------------------------

cat("Não. Nenhuma amostra se encontra fora de controle!")

# ------------------------------------------------------------------------------------
# 8. Há alguma tendência ou padrão preocupante mesmo com os pontos dentro dos limites?
# ------------------------------------------------------------------------------------

cat("Aparentemente não! As amostras estão dispersas de forma aleatória, sem padrões visíveis.")

# ------------------------------------------------------------
# 9. O processo pode ser considerado sob controle estatístico?
# ------------------------------------------------------------

cat("Sim. As amostras estão dispersas de forma aleatória, sem padrões visíveis e todas dentro dos Limites de Controle.")

# ----------------------------------------------------------------------
# 10. Compare o gráficos $\bar{X}$ e $AT$ com o gráfico $\bar{X}$ e $S$.
# ----------------------------------------------------------------------

# Valor de Referência
A2 <- 0.729

# Limites de Controle
LIC_X_bar <- mean_X_bar - A2 * mean_range
LSC_X_bar <- mean_X_bar + A2 * mean_range

# Impressão dos Resultados
cat("LIC =", round(LIC_X_bar, 4), "\n")
cat("LC =", round(mean_X_bar, 4), "\n")
cat("LSC =", round(LSC_X_bar, 4))

ggplot(data = NULL, aes(x = 1:length(row_mean), y = row_mean)) +
  geom_point(color = "black", size = 2) +
  geom_line(color = "black") +
  geom_hline(aes(yintercept = mean_X_bar, color = "Média Geral"), linewidth = 1) +
  geom_hline(aes(yintercept = LIC_X_bar, color = "LIC"), linetype = 2, linewidth = 1) +
  geom_hline(aes(yintercept = LSC_X_bar, color = "LSC"), linetype = 2, linewidth = 1) +
  scale_color_manual(
    name = NULL,
    values = c("LIC" = "red", "LSC" = "red", "Média Geral" = "blue"),
    labels = c(
      bquote(LIC == .(LIC_X_bar)), 
      bquote(LSC == .(LSC_X_bar)), 
      bquote(hat(mu) == .(mean_X_bar))
    )
  ) +
  labs(
    x = "Amostra",
    y = "Medidas",
    title = bquote("Gráfico de" ~ bar(X) ~ "com Variação em" ~ AT)
  ) +
  theme_classic(base_size = 12) +
  theme(legend.position = "top")

# -----------------------------

# Valor de Referência
A3 <- 1.628

# Limites de Controle
LIC_X_bar <- mean_X_bar - A3 * mean_S
LSC_X_bar <- mean_X_bar + A3 * mean_S

# Impressão dos Resultados
cat("LIC =", round(LIC_X_bar, 4), "\n")
cat("LC =", round(mean_X_bar, 4), "\n")
cat("LSC =", round(LSC_X_bar, 4))

ggplot(data = NULL, aes(x = 1:length(row_mean), y = row_mean)) +
  geom_point(color = "black", size = 2) +
  geom_line(color = "black") +
  geom_hline(aes(yintercept = mean_X_bar, color = "Média Geral"), linewidth = 1) +
  geom_hline(aes(yintercept = LIC_X_bar, color = "LIC"), linetype = 2, linewidth = 1) +
  geom_hline(aes(yintercept = LSC_X_bar, color = "LSC"), linetype = 2, linewidth = 1) +
  scale_color_manual(
    name = NULL,
    values = c("LIC" = "red", "LSC" = "red", "Média Geral" = "blue"),
    labels = c(
      bquote(LIC == .(LIC_X_bar)), 
      bquote(LSC == .(LSC_X_bar)), 
      bquote(hat(mu) == .(mean_X_bar))
    )
  ) +
  labs(
    x = "Amostra",
    y = "Medidas",
    title = bquote("Gráfico de" ~ bar(X) ~ "com Variação em" ~ S)
  ) +
  theme_classic(base_size = 12) +
  theme(legend.position = "top")

# ----------------------------------------------------------------------
#    a. Qual parece mais sensível às variações nos dados?
# ----------------------------------------------------------------------

print("O gráfico de controle com base no desvio padrão (S) apresentou limites ligeiramente maiores que o gráfico de controle com base na amplitude (AT).")

# ----------------------------------------------------------------------
#    b. Qual seria mais indicado para subgrupos maiores que 10?
# ----------------------------------------------------------------------

print("O mais indicado para amostras maiores que 10 é o gráfico de controle com base no desvio padrão (S).")

# ----------------------------------------------------------------------
#    c. Em que situações o gráfico de variância seria mais apropriado?
# ----------------------------------------------------------------------

print("Sob o mesmo raciocínio do item anterior, o gráfico de controle com base no desvio padrão é mais indicado para amostras maiores que 10.")