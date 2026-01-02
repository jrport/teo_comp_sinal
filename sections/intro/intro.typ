#pagebreak()

= Introdução
== Enunciado do problema
#emph([
A Companhia Turing Traffic Systems está desenvolvendo um sistema de controle de tráfego urbano baseado em Máquinas de Turing para gerenciar os semáforos de uma cidade inteligente. O objetivo é determinar qual deve ser o próximo estado do semáforo principal de um cruzamento, considerando informações sobre o fluxo de veículos.

O cruzamento possui três avenidas que se encontram no mesmo ponto, e cada avenida possui sensores que contam o número de veículos aguardando em cada direção.

O sistema deve decidir a próxima cor do semáforo principal de acordo com a seguinte política:

*I* - Se uma avenida tiver mais da metade do total de veículos somados das três avenidas, ela terá prioridade, e o semáforo para essa avenida ficará verde, enquanto os outros ficarão vermelho.

*II* Caso nenhuma avenida tenha mais da metade dos veículos, o sistema escolhe a avenida com maior número de veículos.

*III* Em caso de empate, a avenida A tem prioridade sobre B, e B sobre C (ordem A > B > C).
])

== Contextualização e importância na área de cidades inteligentes.
lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero lero

#pagebreak()

== Abstrações, notações específicas e corolários significativos
Como parte desse trabalho, temos a missão de modular Máquinas de Turing que solucionem o problema preposto. Para tal, teremos como entrada uma string representando a distribuição de carros dentre as avenidas A, B e C, seguindo o formato:

$ "Seja" w "uma palavra e" n in bb(N) $
$ w = phi_0 * ... * phi_(n - 1) * phi_n $
$ phi_k in {a, b, c} "tal que" 0 <= k <= n $

Nesta representação, cada carro na avenida A será uma letra 'a', na avenida B, a letra 'b', e na C, 'c'.

Uma outra definição útil é a do conjunto de ocorrências de um conjunto de símbolos ou de um único símbolo (sendo esse o caso do conjunto unário).

$ "Seja" w "uma palavra," x "uma letra e" X = {x} $
$ X_w "é o conjunto de ocorrências dos símbolos de" X "em" w $
$ X_w = { j | forall j in N  "tal que" 0 <= j <= |w| " e" phi_j in X } $

Será útil também a definição de uma função para cálculo da cardinalidade de uma letra, descrito como segue:

$ "Seja" w "uma palavra e" x "uma letra" $
$ gamma_(x)(w): {a, b, c} -> bb(N) $
$ gamma_(x)(w) = |X_w| $

De forma direta, $gamma_(x)(w)$ nos retorna o número de ocorrências da letra $x$ na palavra $w$.

#pagebreak()
Retornando ao enunciado da questão, vamos destrinchar os comandos escritos e abstrair duas propriedades relevantes.

1. Determinar a avenida com quantidade de carros superior a metade do total de automóveis em todas avenidas. <1> \
  1.1 Ou seja, *determinar a letra $x$ cuja cardinalidade é superior ao tamanho total da string $w$ de entrada*:
  $ x in {a, b, c} bar gamma_(x)(w) > (|w|)/2 $ <A>
  $ "dado que as únicas letras de "w" são "{a, b, c}, "segue que:" $
  $ |w| = gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w) $
  $ "Portanto, " gamma_(x)(w) > (|w|)/2 <=> gamma_(x)(w) > (gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w))/2 $
  1.2 Caso mais de uma avenida se qualifique, devemos respeitar a A sobre B, B sobre C e, por transitividade, A sobre C. <1.2>
2. Determinar a avenida com a maior quantidade de carros. <2> \
  2.1 Ou seja, *determinar a letra $x$ de maior cardinalidade na palavra $w$*:
  $ x, y, z in {a, b, c} and y != z and z != x and x != z \
  gamma_(x)(w) > gamma_(y)(w) and gamma_(x)(w) > gamma_(z)(w) $
  2.2 Em caso de empate, devemos respeitar a ordem de prioridade definida em 1.2.

Também é importante considerar que a computação da #link(<2>)[propriedade 2] só deve ser avaliada caso não haja parada por estado final na computação da #link(<1>)[condição 1].


Vamos considerar também algumas equivalências para facilitar a modelagem e validação do automômato.

A primeira é centrada na #link(<A>)[propriedade A], a qual nos dá que:

$ gamma_(x)(w) > (gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w))/2 $
$ 2 * gamma_(x)(w) > gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w) $

Dado que $x in {a, b, c}$,
$ gamma_(x)(w) in {gamma_(a)(w), quad gamma_(b)(w), quad gamma_(c)(w)} $

Generalizando,
$ "Sejam" quad x, y, z in {a, b, c} | x != y and y != z $
$ 2 * gamma_(x)(w) > gamma_(x)(w) + gamma_(y)(w) + gamma_(z)(w) $
#let propriedade_i = $ gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w) $
#block[
  #set math.equation(numbering: (..nums) => $"("Delta")"$)
  $ #propriedade_i $ <C>
]<ineq>


Ou seja,
$ gamma_(x)(w) > (gamma_(x)(w) + gamma_(y)(w) + gamma_(z)(w))/2 <=> gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w) $ <I>

#let target_1 = link(<C>)[corolário $Delta$]

Portanto, basta que nosso automômato compute o #target_1:
#propriedade_i
para que também seja verificada a #link(<1>)[condição 1] do enunciado e portanto determinada a avenida prioritária.

#pagebreak()
