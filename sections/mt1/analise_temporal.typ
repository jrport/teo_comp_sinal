#import "../intro/intro.typ": *

=== Contagem no módulo $alpha$

$psi(x, {y, z})$ deve verificar se para um certo $x$ vale:

$ #propriedade_i "onde" x, y, z in {a, b, c} " e " x != y != z $

Para tal, vamos comparar a *cardinalidade* de $x$ com a de $y$ e $z$.

Para tal utilizamos nossa função de comparação de cardinalidade $psi(x, L)$, sendo $L = {y, z}$.

Em $alpha$, substituimos o $E_>$ como $F_x$ simbolizando a parada total da MT1 na decisão de priorizar a avenida $x$. Uma vez que esse estado implica na condição $Delta$ desejada.

Enquanto $E_<=$ será:
- $E_"in"$ do submódulo $psi$ seguinte, caso $x!=c$,;
- o estado de entrada do módulo $beta$, caso $x=c$,;

Dado a definição de $x$ e $L$, vamos agora para o cálculo da complexidade temporal associado a $alpha$.

Para isso, vamos destrinchar cada passo, determinando o pior formato possível da palavra para cada um deles. Comparar essas composições de $w$, calcular o custo associado e eleger o pior candidato.

Trateremos por $i$, a iteração atual do passo-a-passo, visto que $psi$ opera como _loop_, iniciando nossa contagem em 1.

#let cases = (
  (
    [Rebobinação da fita],
    $w = x^k*y^j$,
    [
      A partir de i > 0, essa etapa rebobina a partir da posição do cabeçote determinada no passo 4.b).
      Portanto aqui, $w = x^k*y^j$ é *um* pior caso válido (o relevante aqui é que todos os $y$ sejam sufixo de w).
      Visto que força a maior distância do cabeçote ao início.
    ],
  ),
  (
    [Busca por um x não marcado],
    $w = y^k * x^j$,
    [
      Como aqui buscamos um $x$ não pareado, iniciando nossa busca do início de $w$ seguindo também seguindo linearmente.
      O pior caso é de todos $x$ como sufixo de $w$.
    ],
  ),
  (
    [Rebobinação da fita],
    $w = y^k*x^j$,
    [
      Análogo ao primeiro passo, só que dessa vez a posição inicial do cabeçote é determinada pelo passo 2), assim invertemos a ordem.
    ],
  ),
  (
    [Buscamos por um y não marcado],
    $w = x^k*y^j$,
    [
      Análogo ao passo 2), só que dessa vez queremos que o sufixo de $w$ seja $y^j$.
    ],
  ),
)

#set enum(numbering: i => "Passo " + str(i) + " -")
#for (i, (step_description, worst_word, explanation)) in cases.enumerate() [
*#enum.item(i + 1, [#step_description])*
--- Pior palavra: #worst_word

#explanation

]

Temos então dois formatos possíveis de $w$ disputando a posição de pior possível. Vamos considerar cada um e calcular o custo associado.

Considere a seguir que,
$ w "é palavra e," n = |w| = m + k $

==== Análise para $w = y^k * x^m$
- *Passo 1:* Da posição $i$ até o início → $i$
- *Passo 2:* Passar por $k$ símbolos $y$ + $i$ símbolos $x_\#$ → $k + i$
- *Passo 3:* Da posição $k+i$ até o início → $k + i$
- *Passo 4:* Passar pelos primeiros $i$ símbolos até o próximo $y$ livre → $i$

-- *Custo por iteração ($C_i$)*
$ C_i = i + (k + i) + (k + i) + i = 2k + 4i $

==== Análise para $w = x^m y^k$
- *Passo 1:* Da posição $m + i$ até o início → $m + i$
- *Passo 2:* Passar por $i$ símbolos $x_\#$ até o próximo $x$ → $i$
- *Passo 3:* Da posição $i$ até o início → $i$
- *Passo 4:* Passar por $m$ símbolos $x$ (todos já marcados) + $i$ símbolos $y_\#$ → $m + i$

*Custo da iteração $i$:*
$ C_i = (m + i) + i + i + (m + i) = 2m + 4i $

Para $y^k x^m$ com $ell$ iterações:
$ T_1 = sum_(i=1)^(ell-1) (2k + 4i) = 2k ell + 2 ell (ell-1) $

Para $x^m y^k$ com $ell$ iterações:
$ T_2 = sum_(i=1)^(ell-1) (2m + 4i) = 2m ell + 2 ell (ell-1) $

Resta determinar para cada caso a pior distribuição de $m$ e $k$.

Em $T_1$, $ell$ é o número de iterações do _loop_, sendo esse determinado de acordo aos dois cenários de parada.

- Caso 1: $k <= m -> "Pára em " F_x <=> l = k$
- Caso 2: $k > m -> "Escapa para " E_"out" <=> l = m$

Portanto, $l = min(k, m)$.

Substituindo em $T_1$,
$ T_1(k) = 2k⋅min(k, m) + 2min(k, m)⋅(min(k, m)-1) $
$ T_1(k) = 2k⋅min(k, m) ⋅ [k + min(k, m) - 1] $

- Caso 1: $min(k,m) = k$
$ T_1(k) = 2k⋅k + 2k⋅(k-1) = 4k^2 - 2k $
Com a restrição de $k + m = n$ e $k <= m$:
$ k <= m ==> k <= n - k ==> 2k <= n ==> k < n/2 $

Importante notar que estamos considerando $|w| > 0$ aqui (ou seja, uma palavra não vazia), logo $n >= 2$.

Com isso temos o domínio $k in [1, n/2]$.

Vamos otimizar,
$ ("dT"_1)/("dk") = 8k - 2 $

Em nosso domínio obtemos que, seja $k >= 1$,
$ 8k - 2 >= 8(1) - 2 = 6 > 0 $

Como nossa função é estritamente crescente no intervalo relevante, basta pegarmos o extremo da direita para termos o máximo.

Ou seja, no caso 1), a pior distribuição possível é $k = n/2$, e como $n = k + m$, assim obtemos $k = m = n/2$.

O que nos dá um custo máximo de: $T^(A)_1 = 4(n/2)^2 - 2(n/2) = n^2 - n$

- Caso 2: $min(k,m) = m = n - k$
$ T_1(k) = 2k⋅(n - k) + 2(n - k)⋅((n - k)-1) = 2(n-k)(k - 1) $
$ T_1(k) = 2(n - 1)(n-k) = 2n^2 - 2n - 2n k + 2k $

Aqui o domínio é $m in (n/2, n)$, visto que $k > m = n - k$.

Derivando,
$ ("dT"_1)/("dk") = -2n + 2 = 2(1 - n) $

Para $n > 1$, $2(1 - n) < 0$, ou seja, a função é decrescente no domínio inteiro. Logo basta pegarmos o valor a extrema esquerda para k ($n/2$).

O custo desse caso será $T^(B)_1 = 2(n/2)(n-1) = n(n-1) = n^2 - n$. O mesmo do caso A).

Ou seja, o custo computacional é o mesmo independente de qual caso de interrupção, e a pior composição possível para a palavra dado o formato $w = y^k + x^m$ é $k = m = (|w|)/2$.

Acumulando o custo de $n^2 - n$, contido no conjunto $Theta(n^2)$.

Em $T_2$, por simétria, a análise é idêntica.

#pagebreak()

Entranto, queremos o pior caso dado toda a computação de $alpha$, assim é interessante maximizar o custo dentro da restrição de $x < y$. Em vista da análise exposta, sucede que o pior caso para o módulo por inteiro é $x = y - 1$ para $x in {a, b, c}$. Acumulando custo de:


