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
group1_x = np.random.normal(loc=10, scale=3, size=group1_size)
group1_y = np.random.normal(loc=20, scale=4, size=group1_size)

group2_size = 40
group2_x = np.random.normal(loc=20, scale=4, size=group2_size)
group2_y = np.random.normal(loc=30, scale=5, size=group2_size)

group3_size = 30
group3_x = np.random.normal(loc=30, scale=5, size=group3_size)
group3_y = np.random.normal(loc=15, scale=3, size=group3_size)

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