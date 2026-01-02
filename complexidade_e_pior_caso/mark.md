# Análise Completa de Complexidade do Autômato

## 1. Descobrindo o Formato da Pior Palavra Possível

Vamos analisar diferentes formatos de entrada com $k$ símbolos $y$ e $m$ símbolos $x$, onde $k + m = n$.

### Análise para o formato $y^k x^m$

**Posição inicial de cada iteração $i$:** A cabeça está na posição $i$ (no $y$ que acabou de marcar)

**Custos por iteração $i$ (onde $i = 0, 1, ..., \text{num\_iterações} - 1$):**

- **Passo 1 (Rebobinar):** Da posição $i$ até o início → $i$
- **Passo 2 (Avançar buscando $x$):** Passar por $k$ símbolos $y$ + $i$ símbolos $x_x$ → $k + i$
- **Passo 3 (Rebobinar):** Da posição $k+i$ até o início → $k + i$
- **Passo 4 (Avançar buscando $y$):** Passar pelos primeiros $i$ símbolos até o próximo $y$ livre → $i$

**Custo da iteração $i$:**
$$C_i = i + (k + i) + (k + i) + i = 2k + 4i$$

### Análise para o formato $x^m y^k$

**Custos por iteração $i$:**

- **Passo 1:** Da posição $m + i$ até o início → $m + i$
- **Passo 2:** Passar por $i$ símbolos $x_x$ até o próximo $x$ → $i$
- **Passo 3:** Da posição $i$ até o início → $i$
- **Passo 4:** Passar por $m$ símbolos $x$ (todos já marcados) + $i$ símbolos $y_x$ → $m + i$

**Custo da iteração $i$:**
$$C_i = (m + i) + i + i + (m + i) = 2m + 4i$$

### Análise para o formato alternado $(yx)^{\min(k,m)}...$

**Custos por iteração $i$:**

- **Passo 1:** Da posição $2i+1$ até o início → $2i + 1$
- **Passo 2:** Até a posição $2i+2$ → $2i + 2$
- **Passo 3:** Da posição $2i+2$ até o início → $2i + 2$
- **Passo 4:** Até a posição $2i+1$ → $2i + 1$

**Custo da iteração $i$:**
$$C_i = (2i+1) + (2i+2) + (2i+2) + (2i+1) = 8i + 6$$

### Comparação dos Formatos

**Para $y^k x^m$ com $\ell$ iterações:**
$$T_1 = \sum_{i=0}^{\ell-1} (2k + 4i) = 2k\ell + 2\ell(\ell-1)$$

**Para $x^m y^k$ com $\ell$ iterações:**
$$T_2 = \sum_{i=0}^{\ell-1} (2m + 4i) = 2m\ell + 2\ell(\ell-1)$$

**Para $(yx)^p...$ com $\ell$ iterações:**
$$T_3 = \sum_{i=0}^{\ell-1} (8i + 6) = 4\ell(\ell-1) + 6\ell$$

### Conclusão sobre o Pior Formato

Comparando quando $k = m = \frac{n}{2}$ e $\ell = \frac{n}{2}$:

- $T_1 = T_2 = 2 \cdot \frac{n}{2} \cdot \frac{n}{2} + 2 \cdot \frac{n}{2} \cdot (\frac{n}{2}-1) = \frac{n^2}{2} + \frac{n^2}{2} - n = n^2 - n$
- $T_3 = 4 \cdot \frac{n}{2} \cdot (\frac{n}{2}-1) + 6 \cdot \frac{n}{2} = \frac{n^2}{2} - 2n + 3n = \frac{n^2}{2} + n$

**O pior formato é $y^{n/2} x^{n/2}$ ou $x^{n/2} y^{n/2}$** quando $k = m = \frac{n}{2}$.

---

## 2. Destrinchando o Custo para Ambos os Casos de Parada

Vamos usar o formato $y^k x^m$ como base.

### Caso A: Parada em $F_x$ (Propriedade C satisfeita)

**Quando ocorre:** No Passo 4, não encontramos mais nenhum $y$ livre (todos já foram marcados ou não existem).

**Condição:** $k \leq m$ (temos menos ou igual $y$'s do que $x$'s)

**Número de iterações:** $\ell = k$ (marcamos todos os $k$ símbolos $y$)

**Custo total:**
$$T_{F_x} = \sum_{i=0}^{k-1} (2k + 4i) = 2k^2 + 4 \cdot \frac{k(k-1)}{2} = 2k^2 + 2k(k-1)$$

$$T_{F_x} = 2k^2 + 2k^2 - 2k = 4k^2 - 2k$$

**Maximizando com $k + m = n$ e $k \leq m$:**

Como a função $T_{F_x}(k) = 4k^2 - 2k$ é crescente para $k > \frac{1}{4}$, e precisamos $k \leq \frac{n}{2}$:

$$\boxed{T_{F_x}^{worst} = 4\left(\frac{n}{2}\right)^2 - 2\left(\frac{n}{2}\right) = n^2 - n = \Theta(n^2)}$$

**Pior caso:** $y^{n/2} x^{n/2}$ (paridade exata)

---

### Caso B: Parada em $E_{out}$ (Propriedade C não satisfeita)

**Quando ocorre:** No Passo 2, não encontramos mais nenhum $x$ livre (todos já foram marcados).

**Condição:** $m < k$ (temos menos $x$'s do que $y$'s)

**Número de iterações:** $\ell = m$ (marcamos todos os $m$ símbolos $x$)

**Custo total:**
$$T_{E_{out}} = \sum_{i=0}^{m-1} (2k + 4i) = 2km + 4 \cdot \frac{m(m-1)}{2} = 2km + 2m(m-1)$$

$$T_{E_{out}} = 2km + 2m^2 - 2m = 2m(k + m - 1) = 2m(n - 1)$$

**Maximizando com $k + m = n$ e $m < k$:**

Como $m = n - k$ e precisamos $m < k$ (ou seja, $m < \frac{n}{2}$):

$$T_{E_{out}} = 2m(n-1)$$

Essa função é linear em $m$, crescente. O máximo ocorre quando $m$ se aproxima de $\frac{n}{2}$:

$$\boxed{T_{E_{out}}^{worst} = 2 \cdot \frac{n}{2} \cdot (n-1) = n(n-1) = \Theta(n^2)}$$

**Pior caso:** $y^{n/2} x^{n/2}$ ou valores próximos como $y^{n/2+1} x^{n/2-1}$

---

## 3. Resumo Final

| **Parada** | **Condição** | **Iterações** | **Custo** | **Pior Formato** |
|------------|--------------|---------------|-----------|------------------|
| $F_x$ | $k \leq m$ | $k$ | $4k^2 - 2k$ | $y^{n/2} x^{n/2}$ |
| $E_{out}$ | $m < k$ | $m$ | $2m(n-1)$ | $y^{n/2+\epsilon} x^{n/2-\epsilon}$ |

**Complexidade assintótica para ambos os casos:**

$$\boxed{T(n) = \Theta(n^2)}$$

**O pior formato absoluto é quando $k \approx m \approx \frac{n}{2}$**, independente da ordem ($y^{n/2}x^{n/2}$ ou $x^{n/2}y^{n/2}$).
