#let npsi = $psi'$
==== Análise temporal de #npsi
#npsi conserva o mesmo conjunto de transições $psi$, apenas acrescentando um último loop de busca e rebobinação para achar um $x$, dessa forma, podemos recorrer aos resultados obtidos na análise temporal anterior, e apenas incrementar o custo associado a essa nova etapa para entender o novo pior caso.

Antes, primeiro vamos rapidamente demarcar *qual é o novo pior caso* para isso vamos considerar os três possíveis cenários que culminem em escape:

1. $E_5 -->^(epsilon, epsilon bar I) E_>=$
Aqui temos o resultado de $|X| >= |overline(X)|$ como já demonstrado na análise de $psi$. Aqui não há nenhum acrescimo de custo a complexidade já calculada.

2. $E_7 -->^(epsilon, epsilon bar I) E_>=$
O caso em que $|X| > |overline(X)|$, percorá o trajeto inteiro de:
$ E_6 -->^(*, * bar E) E_6 -->^(<, < bar D) E_7 -->^(*,* bar D) E_7 -->^(epsilon, epsilon bar I) E_>= $

Iniciando com o cabeçote no fim da palavra, as transições produzirão um custo, em ordem, de: $n, 1, n, 0$. Acumulando um adicional de $2n + 1$.
Interessante notar que aqui é indiferente a distribuição das letras na palavra, já que todos os símbolos relevantes já teriam sido pareados.

3. $E_8 -->^(epsilon, epsilon bar I) E_<$
O caso onde $|X| < |overline(X)|$, percorá o trajeto inteiro de:
$ E_6 -->^(*, * bar E) E_6 -->^(y, y bar D) E_8 -->^(*, * bar D) E_8 -->^(epsilon, epsilon bar I) E_< $
De forma análoga ao outro módulo, a ordem da composição da palavra traz se um aumento de custo desde que haja uma formação homogênea do estilo $w = x^j + y^k + z^l$, com o $x$, $y$ e $z$ mais próximos possíveis. Como faremos duelos envolvendo todos os símbolos, a permutação específica das sequências não altera o custo total. A pior palavra seria: $w=x^m∗y^k∗z^j$ onde $m < k + j$.

Obtemos o custo por iteração (denotada por $i$) de:
$ C_3 = n + (m + 1) + (m + 1) = n + 2m + 2 $

Como $n = m + k + j$ e sabemos que $m < k + j$, o pior caso é maximizar $m$ respeitando essa restrição, vide análise da derivada da equação do custo temporal de $psi$.

$ n = m + (m + 1) = 2m + 1 $

Substituindo em $C_3$:
$ C_3 = (2m + 1) + 2m + 2 = 4m + 3 $

#h(1em)

Ou em termos de $n$:
$ m = (n-1)/2 $
$ C_3 = 4 dot (n-1)/2 + 3 = 2n - 2 + 3 = 2n + 1 $

Obtendo um acrescimo total de $2n + 1$.

Dessa forma, o custo associado #npsi, considerando o caso 1 ou 3, é de $ "custo de" #npsi = "custo adicional" + "custo de "psi = (2n + 1) + (n^2 - n) = n^2 + n + 1 $ que também pertence a $Theta(n^2)$.

*Portanto, os casos 1 e 3 tem o mesmo custo, apesar de implicarem em diferentes distribuições para os símbolos.*

Resta então considerarmos a estrutura maior do torneio para eleger a pior palavra. Como o vencedor participará de 2 duelos, ele deve ser o sufixo mais distante do início da palavra, maximizando o custo associado a computação total, as demais sequências são intercambiáveis.

Então para um $X$ vencedor, a palavra de entrada que maximiza o custo temporal é: $w = z^j + y^k + x^m$, onde $j = k = m - 1$. Implicando num custo total de $ C_"total" = 2 dot (n^2 + n + 1) = 2n^2 + 2n + 2 $ que também é $Theta(n^2)$.

==== Custo total da $"MT"_1$

Portanto, o custo total da máquina de Turing $"MT"_1$, recebe como entrada:
$ w = z^j + y^k + x^m or w = y^j + z^k + x^m $
Sendo,
$ k = j = m - 1 and x, y, z in {a, b, c} and x != y and y != z $
E determina a avenida $X$ como prioritária com o custo computacional total de:
$ T(n) = T_"alfa" + T_"beta" = (3n^2) + (2n^2 + 2n + 2) = 5n^2 + 2n + 2 $
Logo,
$ "MT"_1 in Theta(n^2) $

