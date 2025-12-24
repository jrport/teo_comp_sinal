#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "introduction.typ": *
#import fletcher.shapes: house, diamond, circle

= Máquinas de Turing
Com objetivo de tratar da complexidade do problema de maneira didática, facilitando nossa argumentação, além de simplificar o processo de desenvolvimento da máquina abstrata, vamos segmentar porções de MT's (Máquinas de Turing) em 'módulos'.

Dada a definição de uma MT:
$ "MT" = (E, Sigma, Γ, delta, i, F) $
$E$: Conjunto finito de estados \
$Sigma$: Alfabeto de entrada \
$Γ$: Alfabeto da fita \
$delta$: Funções de transição \
$i$: Estado inicial \
$F$: Conjunto de estados finais

Obtermos um módulo $MM$ de MT tal que:
$ MM = (E_xi, Sigma, Γ, delta_xi, e_("in"), E_("out")) $
Onde, \
$E_xi$: Subconjunto de $E$. \
$delta_xi$: Subconjunto de $delta$ que atuem somente sobre os estados definidos em $E_xi$. \
$e_("in")$: Um estado eleito de $E_xi$, denota o ínicio do módulo. Vamos nos referir a ele como estado de entrada. \
$e_("out")$: Um conjunto de estados finais pertencentes a $E_xi$, representam o fim da computação do módulo. Chamaremos eles de estados de saída. \

Importante notar que não necessariamente $e_("out") subset F$. Ou seja, o fim da computação de $MM$ não é necessário e suficiente para parada da MT.

No decorrer desse texto também usaremos o termo "submódulo". Essa estrutura é análoga à um módulo e sua definição é construída em função de um módulo $MM$ ao invês da MT por inteiro. Essa abstração também tem finalidades puramente organizacionais.

#pagebreak()

#let mt1 = $"MT"_1$
== Máquina de uma única fita (#mt1)
Nossa máquina de uma fita só, ou #mt1, é definida como:

$ "MT"_1 = (E, Sigma, Γ, delta, i, F) $
Tal que, \
$Sigma = {a, b, c}$ \
$Γ = {x_y | forall x,y in Sigma} union {epsilon, <}, " ou seja" {a, b, c, a_a, a_b, a_c, b_a, b_b, b_c, c_a, c_b, c_c, <, epsilon }$ \
$F = {F_a, F_b, F_c}$

$<$ é o símbolo delimitador do início da fita. Tratamos a fita como infinita a direita.

$epsilon$ representa o vazio que preenche os espaços à direita da palavra inserida.

Cada estado final representa a decisão de conceder prioridade a uma avenida no cruzamento, onde:
$ x in Sigma bar F_x: "Sinaleira prioriza avenida x" $

As transições $delta$, estados $E$, $F$ e $i$ serão definidos em representações gráficas mais a frente.

#mt1 tem dois módulos principais: $alpha$ e $beta$ os quais serão estabelecidos e destrinchados a seguir.

=== Módulos e submódulos
O módulo $alpha$ será responsável por verificar se a #link(<1>)[condição 1] do enunciado vale para alguma letra de $Sigma$ através do #target_1.

Caso nenhum estado final seja alcançado dentro de $alpha$, o automômato recorrerá ao módulo $beta$, onde avaliará a regra de desempate definida na #link(<2>)[condição 2] do problema. Verificando qual símbolo tem a maior cardinalidade na entrada.

A macroarquitetura da máquina tem o formato:

#figure(
  caption: "Arquitetura do automômato",
  kind: "fluxograma",
  supplement: [Fluxograma]
)[
  #align(center, [
    #diagram(
      node-stroke: 1pt, {
        let (a, b, c) = ((-0.5, 0), (0.5, 0), (3.5, 0))

        node(a, [])
        node(b, align(center)[Módulo $alpha$], shape: house)
        node(c, align(center)[Módulo $beta$], shape: house)

        edge(a, b, "-|>", label: text(size: 8pt)[Início])

        edge(
          b, c, "-|>",
          label: [#align(center, [#text(size: 10pt)[Se o módulo $alpha$\ não parar]])]
        )


        let row_y = 2
        let xA = 0.5
        let ext = (0, -2)

        let bA = (xA - 1, row_y)
        let bB = (xA,     row_y)
        let bC = (xA + 1, row_y)

        node(bA, align(center)[$F_a$], extrude: ext)
        node(bB, align(center)[$F_b$], extrude: ext)
        node(bC, align(center)[$F_c$], extrude: ext)

        edge(b, bA, "-|>")
        edge(b, bB, "-|>")
        edge(b, bC, "-|>")

        let xB = 3.5

        let cA = (xB - 1, row_y)
        let cB = (xB,     row_y)
        let cC = (xB + 1, row_y)

        node(cA, align(center)[$F_a$], extrude: ext)
        node(cB, align(center)[$F_b$], extrude: ext)
        node(cC, align(center)[$F_c$], extrude: ext)

        edge(c, cA, "-|>")
        edge(c, cB, "-|>")
        edge(c, cC, "-|>")
      }
    )
  ])
]

#pagebreak()

=== Módulo $alpha$
O módulo $alpha$ irá analisar se o #target_1 vale para alguma letra em ${a,b,c}$. Caso verifique validade de tal propriedade para a letra-alvo, é eleito o estado final apropriado representativo da decisão apropriada e a computação cessa.

Visto que o automômato encerra processamento assim que é validado $Delta$ para um elemento, extraímos uma capacidade de "curto-circuito", a qual em conjunto a um processamento ordenado dos elementos de $Sigma$ permite zelar pela regra de desempate definida em #link(<1.2>)[1.2]

Portanto, efetuamos essa avaliação para as letra na ordem "a", "b" e, então, "c", implicitamente zelando pela ordem de desempate.

Caso nenhuma letra do alfabeto cumpra com a propriedade alvo de $alpha$, a computação é encaminhada para o módulo $beta$.

Quebramos cada avaliação de uma letra em um submódulo $psi$, tal que:
$ psi(x): "Verifica se x cumpre a propriedade "Delta", caso positivo, o automômato pára em" F_x. $

Dando ao interior de $alpha$ o formato:

#figure(
  caption: $"Formato do Módulo" alpha$,
  kind: "fluxograma",
  supplement: [Fluxograma]
)[
  #align(center, [
    #diagram(
      node-stroke: 1pt, {
        let (a, b, c, d, e) = (
          (-0.5, 0),
          (0.5, 0),
          (2.5, 0),
          (4.5, 0),
          (6.5, 0),
        )
        let format = diamond.with(fit: 0.3)
        let row_y = 1
        node(a, [])
        node(b, align(center)[$psi(a)$], shape: format)
        node(c, align(center)[$psi(b)$], shape: format)
        node(d, align(center)[$psi(c)$], shape: format)
        node(e, align(center)[Módulo $beta$], shape: house)
        edge(a, b, "-|>", label: text(size: 8pt)[Início])
        edge(b, c, "-|>", label: text(size: 8pt)[_a_ não cumpre $Delta$])
        edge(c, d, "-|>", label: text(size: 8pt)[_b_ não cumpre $Delta$])
        edge(d, e, "-|>", label: text(size: 8pt)[_c_ não cumpre $Delta$])

        let ext = (0, -2)
        node((0.5, row_y), align(center)[$F_a$], shape: circle, extrude: ext)
        node((2.5, row_y), align(center)[$F_b$], shape: circle, extrude: ext)
        node((4.5, row_y), align(center)[$F_c$], shape: circle, extrude: ext)
        edge(b, (0.5, row_y), "-|>", label: text(size: 8pt)[$psi(a) "parou"$], label-side: right)
        edge(c, (2.5, row_y), "-|>", label: text(size: 8pt)[$psi(b) "parou"$])
        edge(d, (4.5, row_y), "-|>", label: text(size: 8pt)[$psi(c) "parou"$])
      }
    )
  ])
]

#pagebreak()
=== Submódulo $psi$

Como já definimos, $psi$ deve verificar se vale para algum $x$:

$ #propriedade_i "onde" x, y, z in {a, b, c} " e " x != y != z $

Para tal, devemos comparar a *cardinalidade* de $x$ com a de $y$ e $z$.

Com esse objetivo, nosso automato irá, efetivamente, *mapear* cada ocorrência de $x$ com uma de $y$ e de $z$.

A natureza dessa correspondência caracteriza diretamente a relação entre as cardinalidades envolvidas.

Considere $X_w$ como o conjunto de aparições de $x$ em $w$, e $Y_w$ e $Z_w$ como conjuntos análogos para demais letras. Formalizando:

$ "w é palavra", thick |w| = n", e" w = (a_1, ..., a_n) "onde" a_i in Sigma = {a, b, c} $
$ X_w = { i | a_i = x}, thick Y_w = { i | a_i = y}, thick Z_w = { i | a_i = z} $

Teremos que a computação de $Delta$ é, essencialmente, a contagem dos conjuntos $X_w$ e $Y_w$ $union$ $Z_w$ -- chamaremos essa união de $"YZ"_w$

Com esse fim, $psi(x)$ buscará formar pares únicos de $x$ com $y$'s e $z$'s, de maneira que não sejam repetidos os elementos envolvidos em cada par já formado. De maneira formal:
$ psi(x): X_w -> "YZ"_w $
$ forall i,j in X_w, #h(0.5em) psi(i) = psi(j) => i = j $

Assim, de acordo ao definido pela teoria dos Conjuntos, caso verifiquemos:
+ bijeção, intuimos que $gamma_(x)(w) = gamma_(y)(w) + gamma_(z)(w)$;
+ injeção, mas não sobrejeção, $gamma_(x)(w) < gamma_(y)(w) + gamma_(z)(w)$;
+ sobrejeção, mas não injeção, $gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w)$

Portanto, basta que nossa $"MT"$ compute essa função de pareamento para que seja verificada a validade de $Delta$.

#pagebreak()

Fixo que $x, y in Sigma$ onde $x != y$, o submódulo $psi(x)$ terá o formato:

#import fletcher.shapes: circle
#align(center)[
  #set text(size: 9pt)
  #block[
    #figure(
      caption: $"Função" psi$,
      kind: "Submódulo",
      supplement: [Submódulo]
    )[
        #diagram(
          node-stroke: .1em,
          {
            let (a, b, c, d, e, f, g) = (
              (-0.5, 0),
              (0.5, 0),
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
              (6.5, 0)
            )
            let format = circle
            let row_y = 1
            node(a, [])
            edge(a, b, "=>", label: "Início")
            node(b, align(center)[$E_1$], shape: format)
            edge(b, "-|>", bend: -130deg, loop-angle: 270deg)[
              $\*,\* bar "E"$
            ]
            node(c, align(center)[$E_2$], shape: format)
            node(g, align(center)[$E_"out"$], shape: format)
            edge(c, "-|>", c, bend: -130deg, loop-angle: 260deg)[
              $*_\x,*_\x bar "D"\
              y,y bar "D"$
            ]
            edge(b, "-|>", c)[<,<|D]
            edge(c, "-|>", g)[$epsilon, epsilon bar D$]
            node(d, align(center)[$F_x$], shape: format, extrude: (0, -2))
            edge(c, e, "-|>", label-side: left)[
              $x, x_x bar "E"$
            ]
            edge(e, "-|>", e, bend: -130deg, loop-angle: 170deg)[
              $\*,\* bar "E"$
            ]
            node(e, align(center)[$E_4$], shape: format)
            edge(e, f, "-|>", label-side: left)[
              $<, < bar "D"$
            ]
            node(f, align(center)[$E_5$], shape: format)
            edge(f, "-|>", f, bend: -130deg, loop-angle: 170deg)[
              #grid(
                columns: (auto),
                align: (right),
                row-gutter: 7pt,
                rows: 2,
                [$x,x bar "D"$],
                [$\*_x,\*_x bar "D"$]
              )
            ]
            edge(f, b, "-|>", label-side: left)[$y,y_x bar "E"$]
            edge(f, d, "-|>")[$lambda,lambda bar "I"$]
          }
        )
    ]
  ]
]

Onde $F_x$ simboliza a parada total da MT1 na decisão de priorizar a avenida $x$.

Enquanto $E_"out"$ será:
- $E_"in"$ do submódulo $psi$ seguinte, caso $x!=c$,;
- o estado de entrada do módulo $beta$, caso $x=c$,;

Ou seja, $psi(x)$ deve
$ "Parar em" F_x <=> #propriedade_i $
$ "Sair por" E_"out" <=> gamma_(x)(w) <= gamma_(y)(w) + gamma_(z)(w) $

#pagebreak()

Vamos então destrinchar cada estado da máquina e suas transições associadas para verificar a computação dessas propriedades e também calcular a complexidade assintôtica apresentada.

#block[
  #set enum(numbering: (i) => "Passo " + str(i) + " -")
+ Rebobina ao início da fita.

#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
              let (a, b, c) = (
                (-0.5, 0),
                (0.5, 0),
                (4.0, 0),
              )
              edge(a, b, "=>", label: "Aqui")
              node(b, align(center)[$E_1$], shape: circle)
              edge(b, "-|>", bend: -130deg, loop-angle: 270deg, dash: "dotted")[
                $\*,\* bar "E"$
              ]
              edge(b, "-|>", c, dash: "dotted")[<,<|D]
              node(c, align(center)[$E_2$], shape: circle)
    }
  )
]

#enum.item(2)[Avança pela fita passando por todos _y_ e $x_x$ -- que são os $x$'s já pareados -- até encontrar um $x$ ou o fim da fita.]
#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
            let (c, d, e, f, g) = (
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
              (6.5, 0)
            )
            let i = (3, 0)
            let format = circle
            let row_y = 1
            edge(i, c, "=>", label: "Aqui")
            node(c, align(center)[$E_2$], shape: format)
            edge(c, "-|>", c, bend: -130deg, loop-angle: 260deg, dash: "dotted")[
              $*_\x,*_\x bar "D"\
              y,y bar "D"$
            ]
            edge(c, e, "-|>", label-side: left, dash: "dotted")[
              $x, x_x bar "E"$
            ]
            node(e, align(center)[$E_4$], shape: format)
            node(g, align(center)[$E_"out"$], shape: format)
            edge(c, "-|>", g, dash: "dotted")[$epsilon, epsilon bar D$]
    }
  )
]
#block[
  #set enum(numbering: "a)")
  + Caso ache um $x$, o sobreescreveremos por $x_x$ e seguimos para o passo 3.
  + Caso não ache um $x$, escapamos para $E_("out")$.
]

#enum.item(3)[Rebobina pro início da fita;]
#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
            let (a, b, c, d, e, f, g) = (
              (-0.5, 0),
              (0.5, 0),
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
              (6.5, 0)
            )
            edge((3.0, 2), e, "=>", label: "Aqui")
            node(e, align(center)[$E_4$], shape: circle)
            edge(e, "-|>", e, bend: -130deg, loop-angle: 170deg, dash: "dotted")[
              $\*,\* bar "E"$
            ]
            edge(e, f, "-|>", label-side: left, dash: "dotted")[
              $<, < bar "D"$
            ]
            node(f, align(center)[$E_5$], shape: circle)
    }
  )
]


#enum.item(4)[Avança pela fita buscando um $y$ tal que $y in.not {x, x_x}$;]
#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
            let (a, b, c, d, e, f, g) = (
              (-0.5, 0),
              (0.5, 0),
              (2.0, 0),
              (0.5, 2),
              (2.0, 2),
              (2.0, 2),
              (6.5, 0)
            )
            node(b, align(center)[$E_1$], shape: circle)
            node(f, align(center)[$E_5$], shape: circle)
            node(d, align(center)[$F_x$], shape: circle, extrude: (0, -2))
            edge(f, "-|>", f, bend: -130deg, loop-angle: 170deg, dash: "dotted")[
              #grid(
                columns: (auto),
                align: (right),
                row-gutter: 7pt,
                rows: 2,
                [$x,x bar "D"$],
                [$\*_x,\*_x bar "D"$]
              )
            ]
            edge(f, b, "-|>", label-side: right, dash: "dotted")[$y,y_x bar "E"$]
            edge(f, d, "-|>", label-side: left, dash: "dotted")[$lambda,lambda bar "I"$]
    }
  )
]
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre, sabemos que _x_ cumpre com a #link(<C>)[a propriedade C], pára no estado final $F_x$ e cessamos computação.
    + Caso encontre, sobreescreveremos o _y_ na fita com $y_x$ e retornamos ao passo 1.
  ]
]


TODO PROVA DA CORRETUDE DA CORRESPONDENCIA ENTRE A MAQUINA E O ARGUMETNO DESEJADO

FAZER PROVAS DAS CORRESPONDENCIAS ENTRE OS ESTADOS DE PARADA/SAIDA E AS PROPRIEDADES DESEJADAS.

2.B) SIGNIFICA NÃO CUMPRIMENTO DE DELTA

SERIA ALGO COMO

- TEMOS DOIS CASOS, UM ONDE JÁ MARCAMOS ALGUM X E OUTRO ONDE NÃO MARCAMOS NENHUM

- CASO JA TENHAMOS MARCADO NUMA ITERAÇÂO ANTERIOR DO LOOP, JÁ MARCAMOS UM DIFERENTE DE X, ENTÃO PELO MENOS YZ = X, JÁ QUE NÃO TEMOS MAIS X
- CASO SEJA A PRIMEIRA ITERAÇÃO, NÃO TEM X NA PALAVRA, ENTÃO, POR OBVIO, YZ >= X

4.A) SIGNIFICA CUMPRIMENTO DE DELTA

#pagebreak()

Vamos para a análise da complexidade temporal, obtida a partir das transições relevantes a cada passo.

Por convenção, vamos assumir o pior caso, para tal, temos de primeiro determinar qual o formato da pior entrada possível.

Para uma entrada computável, $psi(x)$ tem dois possíveis cenários, o de parada ao alcançar o estado $F_x$ e fuga para $E_"out"$, escapando para outro $psi$ ou ao módulo $beta$.

#set enum(numbering: (i) => "Caso " + str(i) + " -")
+ Parada em $F_x$
Conforme estabelecemos previamente, $F_x$ significa

No passo 1, a máquina irá avançar até encontrar um $x$, como a busca pelo símbolo é linear, o custo dessa etapa escala conforme a distância do $x$ do início da palavra. Dessa forma, o pior caso é do $x$ estando mais ao fim possível na fita.

+ Escape para $E_"out"$
pipipopo

// Dado que o algoritmo descrito repete-se para cada elemento cujo pareamento deve ser identificado, o pior caso é aquele que força o maior número possível de iterações, ou seja, o empate, onde:
// $ gamma_x = gamma_y + gamma_z $


#pagebreak()


== Máquina na íntegra
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Análise de complexidade
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Exemplos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
