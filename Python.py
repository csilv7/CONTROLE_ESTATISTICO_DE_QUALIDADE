# --------------------------
# [*] Configurações Iniciais
# --------------------------

# Tratamentos de Dados
import numpy as np
import pandas as pd

# Funções Estatísticas
from scipy import stats

# Visualizações Gráficas
import matplotlib.pyplot as plt
import seaborn as sns

# -----------------------
# [1] Ferramentas Básicas
# -----------------------

# --------------------
# [1.1] Estratificação
# --------------------

# ---------------------------------
# [1.1.1] Exemplo de Estratificação
# ---------------------------------

# Geração de Dados: Exemplo de Dados Estratificados
np.random.seed(11111)
group1_size = 30
group1_x = np.random.normal(loc=10, scale=2.5, size=group1_size)
group1_y = np.random.normal(loc=20, scale=3.5, size=group1_size)

group2_size = 40
group2_x = np.random.normal(loc=20, scale=3.5, size=group2_size)
group2_y = np.random.normal(loc=30, scale=4.5, size=group2_size)

group3_size = 30
group3_x = np.random.normal(loc=30, scale=4.5, size=group3_size)
group3_y = np.random.normal(loc=15, scale=2.5, size=group3_size)

df = pd.DataFrame({
    "x": np.concatenate([group1_x, group2_x, group3_x]),
    "y": np.concatenate([group1_y, group2_y, group3_y]),
    "Grupo": ["Grupo A"] * group1_size + ["Grupo B"] * group2_size + ["Grupo C"] * group3_size
})

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Scatterplot
sns.scatterplot(x="x", y="y", data=df, hue="Grupo", palette="viridis", s=100, ax=ax)

# Configurações de eixos e títulos
ax.set_xlabel("X", fontsize=12)
ax.set_ylabel("y", fontsize=12)

# Configurações de legenda
ax.legend(loc="upper right", frameon=False)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição do gráfico
plt.show()

# ---------------------------------
# [1.1.2] Exemplo de Estratificação
# ---------------------------------

# Exemplo de Estratificação: Defeitos por Turno
np.random.seed(11111)
n = 150
turno = np.random.choice(["Manhã", "Tarde", "Noite"], size=n)
defeitos = np.random.binomial(n=10, p=1/3, size=n)

# Formato Data Frame
df = pd.DataFrame({"Turno": turno, "Defeitos": defeitos})

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Scatterplot
sns.boxplot(x="Turno", y="Defeitos", data=df, hue="Turno", palette="Set2", ax=ax)

# Configurações de eixos e títulos
ax.set_xlabel(ax.get_xlabel(), fontsize=12)
ax.set_ylabel(ax.get_ylabel(), fontsize=12)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição do gráfico
plt.show()

# --------------------------
# [1.2] Folha de Verificação
# --------------------------

# ----------------------------------------------
# [1.2.1] Exemplo de Plot - Folha de Verificação
# ----------------------------------------------

# Dados da Folha de Verificação
defect_types = ["Amassado", "Arranhão", "Bolha", "Mancha"]
defect_counts = [3, 7, 6, 9]

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Gráfico de Barras
sns.barplot(x=defect_types, y=defect_counts, ax=ax)

# Configurações de eixos e títulos
ax.set_xlabel("Defeito", fontsize=12)
ax.set_ylabel("Quantidade", fontsize=12)
ax.set_ylim(0, 10)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição do gráfico
plt.show()

# -------------------
# [2] Gráficos Usuais
# -------------------

# ----------------
# [2.1] Histograma
# ----------------

# Exemplo Prático: Histograma
np.random.seed(11111)
values = np.random.normal(loc=np.mean([85, 120]), scale=5.5, size=100)

# Configurações de Figura
fig, axes = plt.subplots(1, 2, figsize=(12, 4), dpi=600)

# Histogrma
sns.histplot(data=values, bins=7, binrange=(85, 120), binwidth=5, edgecolor="white", ax=axes[0])
sns.histplot(data=values, bins=7, binrange=(85, 120), binwidth=5, edgecolor="white", ax=axes[1])

# LIE & LSE
axes[1].axvline(x=90, color="red", linestyle="dashdot", label="LIE")
axes[1].axvline(x=110, color="red", linestyle="dashed", label="LSE")

# Configurações de legenda
axes[1].legend(prop={"size":8}, loc="upper right", frameon=False)

# Configurações de eixos e títulos
axes[0].set_title("Histograma das Medidas", fontsize=12, weight="bold")
axes[1].set_title("Histograma das Medidas c/ Limites de Especificação", fontsize=12, weight="bold")

for ax in axes:
    # Configurações de eixos e títulos
    ax.set_xlabel("Valor Medido", fontsize=12)
    ax.set_ylabel("Frequência", fontsize=12)

    # Outras configurações
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

# Ajuste do Layout e Exibição da Figura
fig.tight_layout()
plt.show()

# -----------------------
# [2.2] Gráfico de Pareto
# -----------------------

# Exemplo do Gráfico de Pareto
df = pd.DataFrame({
    "Causa": ["Erro A", "Erro B", "Erro C", "Erro D", "Erro E"],
    "Frequência": [40, 25, 15, 12, 8],
})

df["Percentual Acumulado"] = df["Frequência"].cumsum() / df["Frequência"].sum() * 100

# Configurações de Figura
fig, ax1 = plt.subplots(figsize=(6, 4), dpi=600)

# Criando um 2º eixo y
ax2 = ax1.twinx()

# Gráfico de Barras - Frequência
sns.barplot(data=df, x="Causa", y="Frequência", ax=ax1)

# Gráfico de Linhas - Percentual Acumulado
sns.lineplot(data=df, x="Causa", y="Percentual Acumulado", marker="o", linestyle="-", color="red", ax=ax2)

# Configurações de eixos e títulos
ax1.set_xlabel("Causa", fontsize=12)
ax1.set_ylabel("Frequência", fontsize=12)
ax1.set_ylim(0, 40)

ax2.set_ylabel("Percentual Acumulado", fontsize=12)
ax2.set_ylim(0, 100)
ax2.set_yticklabels([f"{fr}%" for fr in np.arange(0, 101, 20)])

# Outras configurações
ax1.spines["top"].set_visible(False)
ax2.spines["top"].set_visible(False)
ax1.spines["bottom"].set_visible(False)
ax2.spines["bottom"].set_visible(False)

# Exibição da Figura
plt.show()

# ---------------------------
# [2.3] Diagrama de Dispersão
# ---------------------------

# --------------------------------------------------------
# [2.3.1] Exemplo de Correlação Linear Positiva e Negativa
# --------------------------------------------------------

# Exemplos: Para Diagramas de Dispersão
np.random.seed(11111)

x1 = np.random.normal(loc=50, scale=10, size=100)
y1 = 3/2 * x1 + np.random.normal(loc=0, scale=10, size=100)

x2 = np.random.normal(loc=50, scale=10, size=100)
y2 = -3/2 * x2 + np.random.normal(loc=0, scale=10, size=100)

# Configurações de Figura
fig, axes = plt.subplots(1, 2, figsize=(12, 4), dpi=600)

# Diagramas de Dispersão
sns.scatterplot(x=x1, y=y1, ax=axes[0])
sns.scatterplot(x=x2, y=y2, ax=axes[1])

# Configurações de eixos e títulos
axes[0].set_title("Correlação Linear Positiva", fontsize=12, weight="bold")
axes[1].set_title("Correlação Linear Negativa", fontsize=12, weight="bold")

for ax in axes:
    # Configurações de eixos e títulos
    ax.set_xlabel("Variável X", fontsize=12)
    ax.set_ylabel("Variável Y", fontsize=12)

    # Outras configurações
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

# Ajuste do Layout e Exibição da Figura
fig.tight_layout()
plt.show()

# ------------------------------------------------
# [2.3.2] Exemplo de Ausência de Correlação Linear
# ------------------------------------------------

# Exemplos: Para Diagramas de Dispersão
np.random.seed(11111)

x1 = np.random.normal(loc=50, scale=5, size=100)
y1 = np.random.normal(loc=50, scale=15, size=100)

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Diagramas de Dispersão
sns.scatterplot(x=x1, y=y1, ax=ax)

# Configurações de eixos e títulos
ax.set_title("Ausência de Correlação Linear", fontsize=12, weight="bold")
ax.set_xlabel("Variável X", fontsize=12)
ax.set_ylabel("Variável Y", fontsize=12)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

# ---------------------------------------------------------------------------------------
# [2.3.3] Cálculo & Teste de Hipótese do/para Coeficiente de Correlação Linear de Pearson
# ---------------------------------------------------------------------------------------

# Função equivalente ao shapiro.test do R
def shapiro_test(x):
    W, p_value = stats.shapiro(x)
    print(
        f"""
        Estatística de Teste (W) = {W:.4f}
        Nível Descritivo (p-value) = {p_value:.4f}
        """
    )

# Classe para calcular o coeficiente de correlação de Pearson e realizar testes de hipótese
class PearsonCorrelation:
    """
    Classe para calcular o coeficiente de correlação de Pearson e realizar testes de hipótese.
    """

    def __init__(self, x, y, alpha=0.05):
        self.x = x
        self.y = y
        self.alpha = alpha

        self.r = None
        self.interval_confidence = None

        self.t_statistic = None
        self.df = None
        self.p_value = None

    def calculate_correlation(self):
        """
        Calcula o coeficiente de correlação de Pearson.
        """
        r = np.corrcoef(self.x, self.y)[0, 1]
        z = np.arctanh(r)
        se = 1 / np.sqrt(len(self.y) - 3)
        lower_bound = np.tanh(z - stats.norm.ppf(1 - self.alpha / 2) * se)
        upper_bound = np.tanh(z + stats.norm.ppf(1 - self.alpha / 2) * se)

        self.r = r
        self.interval_confidence = (lower_bound, upper_bound)

        return r, (lower_bound, upper_bound)

    def hypothesis_test(self):
        """
        Realiza o teste de hipótese para o coeficiente de correlação.
        """
        n = len(self.y)
        self.t_statistic = self.r * np.sqrt(n - 2) / np.sqrt(1 - self.r**2)
        self.df = n - 2
        self.p_value = stats.t.sf(np.abs(self.t_statistic), self.df) * 2

        return self.t_statistic, self.df, self.p_value

    def result_print(self):
        """
        Imprime os resultados do cálculo e do teste de hipótese.
        """
        print(
            f"""
            - Coeficiente de Correlação Linear de Pearson:
            r = {self.r:.4f}
            Intervalo de Confiança ({self.alpha*100:.0f}%):
            ({self.interval_confidence[0]:.4f}, {self.interval_confidence[1]:.4f})

            - Teste de Hipótese:
            t = {self.t_statistic:.4f}, df = {self.df}, p-value = {self.p_value:.4f}
            """
        )

# -------------------------------------------------
# [2.3.3.1] Geração do Dados & Visualização Gráfica
# -------------------------------------------------

# Geração de Dados
np.random.seed(123)

x1 = np.random.normal(loc=10, scale=1, size=30)
y1 = x1 + np.random.normal(loc=0, scale=1, size=30)

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Diagramas de Dispersão
sns.scatterplot(x=x1, y=y1, color="lightblue", ax=ax)

# Configurações de eixos e títulos
ax.set_title("Relação entre X e Y", fontsize=12, weight="bold")
ax.set_xlabel("Variável X", fontsize=12)
ax.set_ylabel("Variável Y", fontsize=12)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

# ----------------------------------------------
# [2.3.3.2] Cálculo do Coeficiente de Correlação
# ----------------------------------------------

# Nível de Significância
ns = 0.05

# Exemplo de uso da classe PearsonCorrelation
Pearson = PearsonCorrelation(x1, y1, alpha=ns)

# Coeficiente de Correlação de Pearson
r, ci = Pearson.calculate_correlation()

# Impressão dos resultados
print(f"Coeficiente de Correlação de Pearson: r = {r:.4f}")
print(f"Intervalo de Confiança ({(1 - ns) * 100:.0f}%): {ci[0]:.4f}, {ci[1]:.4f}")

# ----------------------------------------------------------
# [2.3.3.3] Teste de Hipótese para Coeficiente de Correlação
# ----------------------------------------------------------

# ---------------------------------------
# [2.3.3.3.1] Verificação de Pressupostos
# ---------------------------------------

# Verificação dos Pressupostos (Normalidade)
shapiro_test(x1)
shapiro_test(y1)

# -------------------------------------
# [2.3.3.3.2] Aplicar Teste de Hipótese
# -------------------------------------

result = Pearson.hypothesis_test()

# Teste de Hipótese
print(f"Estatística de Teste (t) = {result[0]:.4f}")
print(f"Graus de Liberdade (df) = {result[1]}")
print(f"Nível Descritivo (p-value) = {result[2]:.4f}")

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

# Dados de Exemplo
list_of_data = [
    [1.3235, 1.4128, 1.6744, 1.4573],
    [1.4314, 1.3592, 1.6075, 1.4666],
    [1.4284, 1.4871, 1.4932, 1.4324],
    [1.5028, 1.6352, 1.3841, 1.2831],
    [1.5604, 1.2735, 1.5265, 1.4362],
    [1.5955, 1.5451, 1.3574, 1.3281],
    [1.6274, 1.5064, 1.8366, 1.4177],
    [1.4190, 1.4303, 1.6637, 1.6067],
    [1.3884, 1.7277, 1.5355, 1.5176],
    [1.4039, 1.6697, 1.5089, 1.6477],
    [1.4158, 1.7667, 1.4278, 1.5927],
    [1.5821, 1.3355, 1.5777, 1.3908],
    [1.2856, 1.4106, 1.4447, 1.6388],
    [1.4951, 1.4036, 1.5893, 1.6458],
    [1.3589, 1.2863, 1.5996, 1.2497],
    [1.5747, 1.5301, 1.5171, 1.1839],
    [1.3680, 1.7269, 1.3957, 1.5019],
    [1.4163, 1.3864, 1.3057, 1.6210],
    [1.5796, 1.4185, 1.6541, 1.5116],
    [1.7106, 1.4412, 1.2361, 1.3824],
    [1.4371, 1.5051, 1.3485, 1.5670],
    [1.4738, 1.5936, 1.6583, 1.4973],
    [1.5917, 1.4333, 1.5551, 1.5295],
    [1.6399, 1.5243, 1.5705, 1.5563],
    [1.5797, 1.3663, 1.6240, 1.3732]
]

# Transformando em Array Multidimensional
arr = np.array(list_of_data)

# -----------------------------------------------------------
# 1. Calcule os limites de controle para o gráfico $\bar{X}$.
# -----------------------------------------------------------

# Média por Linha e Média das Médias
row_mean = np.mean(arr, axis=1)
mean_X_bar = np.mean(row_mean)

# Amplitude por Linha e Média da Amplitude
row_range = np.ptp(arr, axis=1)
mean_range = np.mean(row_range)

# Valor de Referência
A2 = 0.729

# Limites de Controle
LIC_X_bar = mean_X_bar - A2 * mean_range
LSC_X_bar = mean_X_bar + A2 * mean_range

# Impressão dos Resultados
print(f"LIC = {LIC_X_bar:.4f}")
print(f"LC = {mean_X_bar:.4f}")
print(f"LSC = {LSC_X_bar:.4f}")

# ------------------------------------------------------------
# 2. Calcule os limites de controle para o gráfico $\bar{AT}$.
# ------------------------------------------------------------

# Valores de Referência
D3 = 0
D4 = 2.282

# Limites de Controle
LIC_AT = D3 * mean_range
LSC_AT = D4 * mean_range

# Impressão dos Resultados
print(f"LIC = {LIC_AT:.4f}")
print(f"LC = {mean_range:.4f}")
print(f"LSC = {LSC_AT:.4f}")

# -----------------------------
# 3. Construa os dois gráficos.
# -----------------------------

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Gráfico de Controle
sns.lineplot(x=np.arange(1, len(arr) + 1), y=row_mean, marker="o", color="black", ax=ax)
ax.axhline(mean_X_bar, color="blue", label=f"Média = {mean_X_bar:.2f}", linewidth=1.5)
ax.axhline(LIC_X_bar, color="red", linestyle="--", label=f"LIC = {LIC_X_bar:.2f}", linewidth=1.5)
ax.axhline(LSC_X_bar, color="red", linestyle="--", label=f"LSC = {LSC_X_bar:.2f}", linewidth=1.5)

# Configurações de eixos e títulos
ax.set_title(r"Gráfico de Controle $\bar{X}$", fontsize=12, weight="bold")
ax.set_xlabel("Amostras", fontsize=12)
ax.set_ylabel("Medições", fontsize=12)

# Configuração de Legenda
ax.legend(loc="center left", prop={"size": 10}, bbox_to_anchor=(1, 0.5), frameon=False)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

# -----------------------------

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Gráfico de Controle
sns.lineplot(x=np.arange(1, len(arr) + 1), y=row_range, marker="o", color="black", ax=ax)
ax.axhline(mean_range, color="blue", label=r"$\bar{AT}$"+f" = {mean_range:.2f}", linewidth=1.5)
ax.axhline(LIC_AT, color="red", linestyle="--", label=f"LIC = {LIC_AT:.2f}", linewidth=1.5)
ax.axhline(LSC_AT, color="red", linestyle="--", label=f"LSC = {LSC_AT:.2f}", linewidth=1.5)

# Configurações de eixos e títulos
ax.set_title(r"Gráfico de Controle $AT$", fontsize=12, weight="bold")
ax.set_xlabel("Amostras", fontsize=12)
ax.set_ylabel("Medições", fontsize=12)

# Configuração de Legenda
ax.legend(loc="center left", prop={"size": 10}, bbox_to_anchor=(1, 0.5), frameon=False)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

# --------------------------------------------
# 4. Calcule o desvio padrão de cada subgrupo.
# --------------------------------------------

# Desvio Padrão por Linha
row_std = np.std(arr, axis=1)

# Visualizar
row_std

# ---------------------------------------------------------------------------------
# 5. Calcule a média dos desvios $\bar{S}$ e os limites de controle do gráfico $S$.
# ---------------------------------------------------------------------------------

# Média do Desvio Padrão
mean_S = np.mean(row_std)

# Valores de Referência
B3 = 0
B4 = 2.266

# Limites de Controle
LIC_S = B3 * mean_S
LSC_S = B4 * mean_S

# Impressão dos Resultados
print(f"LIC = {LIC_S:.4f}")
print(f"LC = {mean_S:.4f}")
print(f"LSC = {LSC_S:.4f}")

# ---------------------------------------
# 6. Construa o gráfico do Desvio Padrão.
# ---------------------------------------

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Gráfico de Controle
sns.lineplot(x=np.arange(1, len(arr) + 1), y=row_std, marker="o", color="black", ax=ax)
ax.axhline(mean_S, color="blue", label=r"Desvio Padrão Médio ($\bar{S}$)"+f" = {mean_range:.2f}", linewidth=1.5)
ax.axhline(LIC_S, color="red", linestyle="--", label=f"LIC = {LIC_S:.2f}", linewidth=1.5)
ax.axhline(LSC_S, color="red", linestyle="--", label=f"LSC = {LSC_S:.2f}", linewidth=1.5)

# Configurações de eixos e títulos
ax.set_title(r"Gráfico de Controle $S$", fontsize=12, weight="bold")
ax.set_xlabel("Amostras", fontsize=12)
ax.set_ylabel("Medições", fontsize=12)

# Configuração de Legenda
ax.legend(loc="center left", prop={"size": 10}, bbox_to_anchor=(1, 0.5), frameon=False)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

# ----------------------------------------------------
# 7. Alguma amostra está fora dos limites de controle?
# ----------------------------------------------------

print("Não. Nenhuma amostra se encontra fora de controle!")

# ------------------------------------------------------------------------------------
# 8. Há alguma tendência ou padrão preocupante mesmo com os pontos dentro dos limites?
# ------------------------------------------------------------------------------------

print("Aparentemente não! As amostras estão dispersas de forma aleatória, sem padrões visíveis.")

# ------------------------------------------------------------
# 9. O processo pode ser considerado sob controle estatístico?
# ------------------------------------------------------------

print("Sim. As amostras estão dispersas de forma aleatória, sem padrões visíveis e todas dentro dos Limites de Controle.")

# ----------------------------------------------------------------------
# 10. Compare o gráficos $\bar{X}$ e $AT$ com o gráfico $\bar{X}$ e $S$.
# ----------------------------------------------------------------------

# Valor de Referência
A2 = 0.729

# Limites de Controle
LIC_X_bar = mean_X_bar - A2 * mean_range
LSC_X_bar = mean_X_bar + A2 * mean_range

# Impressão dos Resultados
print(f"LIC = {LIC_X_bar:.4f}")
print(f"LC = {mean_X_bar:.4f}")
print(f"LSC = {LSC_X_bar:.4f}")

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Gráfico de Controle
sns.lineplot(x=np.arange(1, len(arr) + 1), y=row_mean, marker="o", color="black", ax=ax)
ax.axhline(mean_X_bar, color="blue", label=f"Média = {mean_X_bar:.2f}", linewidth=1.5)
ax.axhline(LIC_X_bar, color="red", linestyle="--", label=f"LIC = {LIC_X_bar:.2f}", linewidth=1.5)
ax.axhline(LSC_X_bar, color="red", linestyle="--", label=f"LSC = {LSC_X_bar:.2f}", linewidth=1.5)

# Configurações de eixos e títulos
ax.set_title(r"Gráfico de Controle $\bar{X}$ & $AT$", fontsize=12, weight="bold")
ax.set_xlabel("Amostras", fontsize=12)
ax.set_ylabel("Medições", fontsize=12)

# Configuração de Legenda
ax.legend(loc="center left", prop={"size": 10}, bbox_to_anchor=(1, 0.5), frameon=False)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

# -----------------------------

# Valor de Referência
A3 = 1.628

# Limites de Controle
LIC_X_bar = mean_X_bar - A3 * mean_S
LSC_X_bar = mean_X_bar + A3 * mean_S

# Impressão dos Resultados
print(f"LIC = {LIC_X_bar:.4f}")
print(f"LC = {mean_X_bar:.4f}")
print(f"LSC = {LSC_X_bar:.4f}")

# Configurações de Figura
fig, ax = plt.subplots(figsize=(6, 4), dpi=600)

# Gráfico de Controle
sns.lineplot(x=np.arange(1, len(arr) + 1), y=row_mean, marker="o", color="black", ax=ax)
ax.axhline(mean_X_bar, color="blue", label=f"Média = {mean_X_bar:.2f}", linewidth=1.5)
ax.axhline(LIC_X_bar, color="red", linestyle="--", label=f"LIC = {LIC_X_bar:.2f}", linewidth=1.5)
ax.axhline(LSC_X_bar, color="red", linestyle="--", label=f"LSC = {LSC_X_bar:.2f}", linewidth=1.5)

# Configurações de eixos e títulos
ax.set_title(r"Gráfico de Controle $\bar{X}$ & $S$", fontsize=12, weight="bold")
ax.set_xlabel("Amostras", fontsize=12)
ax.set_ylabel("Medições", fontsize=12)

# Configuração de Legenda
ax.legend(loc="center left", prop={"size": 10}, bbox_to_anchor=(1, 0.5), frameon=False)

# Outras configurações
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)

# Exibição da Figura
plt.show()

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