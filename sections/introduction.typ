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
Como parte desse trabalho, temos a missão de modular Máquinas de Turing que solucionem o problema preposto. Para tal, recebermos como entrada uma string representando a distribuição de carros dentre as avenidas A, B e C, seguindo o formato:

$ phi_0 ... phi_(n - 1) phi_n bar forall x in bb(N) and x <= n <-> phi_x in {a, b, c} $

Onde cada carro na avenida A será uma letra 'a', da B, 'b', e C, 'c'.

Será útil também a definição de uma função para cálculo da cardinalidade de uma letra, construída segundo o descrito abaixo:

$ "Seja" w "uma palavra e" x "uma letra" $
$ gamma_(x)(w): Sigma^* -> bb(N) $
$ gamma_(x)(w) = |{i in {1, ..., |w|} and i = x}| $

Onde $gamma$ é a função de cardinalidade.

De forma direta, $gamma_(x)(w)$ nos retorna o número de ocorrências da letra $x$ na palavra $w$.

Durante este documento, iremos com frequência omitir o (w) para tornar a leitura mais leve.

A partir do enunciado da questão, abstraímos duas decisões cujo nossos automômatos terão de tomar:

1. Determinar a avenida com quantidade de carros superior a metade do total de automóveis em todas avenidas. <1> \
  1.1. Ou seja, *determinar a letra $x$ cuja cardinalidade é superior ao tamanho total da string $w$ de entrada*: $ x in {a, b, c} bar gamma_(x)(w) > (gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w))/2 $
  1.2. Caso mais de uma avenida se qualifique, devemos respeitar a A sobre B, B sobre C e, por transitividade, A sobre C. <1.2>
2. Determinar a avenida com a maior quantidade de carros. <2> \
  2.1. Ou seja, *determinar a letra $x$ de maior cardinalidade na palavra $w$*: $ x, y, z in {a, b, c} and y != z and z != x and x != z $
  $ gamma_(x)(w) > gamma_(y)(w) and gamma_(x)(w) > gamma_(z)(w) $
  2.2. Em caso de empate, devemos respeitar a ordem de prioridade definida em 1.2.

Também é importante considerar que a computação descrita em $2$. só deve ocorrer caso haja empate em $1.2$.

#pagebreak()

Para composição das propriedades descritas, consideramos algumas equivalências para viabilizar o processo de modelagem do automômato que são essenciais para compreensão e validação dele.

A primeira é centrada na propriedade 1.1:

$ gamma_(x)(w) > (gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w))/2 $
$ 2 * gamma_(x)(w) > gamma_(a)(w) + gamma_(b)(w) + gamma_(c)(w) $

Dado que $x in {a, b, c}$,
$ gamma_(x)(w) in {gamma_(a)(w), quad gamma_(b)(w), quad gamma_(c)(w)} $

Generalizando,
$ "Sejam" quad x, y, z in {a, b, c} | x != y and y != z $
$ 2 * gamma_(x)(w) > gamma_(x)(w) + gamma_(y)(w) + gamma_(z)(w) $
#let propriedade_i = $ gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w) $
#block[
  #set math.equation(numbering: "(I)")
  $ #propriedade_i $
]<ineq>


O que nos dá
$ x, y, z in {a, b, c} | x != y and y != z $
$ gamma_(x)(w) > (gamma_(x)(w) + gamma_(y)(w) + gamma_(z)(w))/2 <-> gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w) $ <I>


Portanto, basta que nosso automômato compute propriedade I para que também valha 1.1.

#pagebreak()
