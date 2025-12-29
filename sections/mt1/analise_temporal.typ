#import "../intro/intro.typ": *

Vamos agora para a análise da complexidade temporal. Vamos abstrair um custo de 1#emph[u.a.] (unidade arbitrária) por transição efetuada.

Dada uma entrada computável, $psi(x)$ tem dois possíveis cenários, o de parada ao alcançar $F_x$ e fuga para $E_"out"$.

Tratando por $overline(x)$ qualquer símbolo distinto de $x$, podemos usar as definições previas para constatar que:
$ "Parar em" F_x <=> gamma(x)_w > gamma(overline(x))_w $
e,
$ "Saída para" E_"out" <=> gamma(x)_w <= gamma(overline(x))_w $

Também sabemos que o módulo trata-se de um loop, cujo $i$ número de iterações é determinado por $i = min(k, j)$, onde $k = gamma(x)_w$ e $j = gamma(overline(x))_w$.

Vamos então, determinar o formato da pior palavra possível e calcular a complexidade quando:
- $gamma(x)_w > gamma(overline(x))_w$ (Caso $F_x$)
- $gamma(x)_w <= gamma(overline(x))_w$ (Caso $E_"out"$)



#pagebreak()
