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
$ MM = (E_sha, Sigma, Γ, delta_sha, e_("entrada"), E_("saída")) $
Onde, \
$E_sha$: Subconjunto de $E$. \
$delta_sha$: Subconjunto de $delta$ que atuem somente sobre os estados definidos em $E_sha$. \
$e_("entrada")$: Um estado eleito de $E_sha$, denota o ínicio do módulo. Vamos nos referir a ele como estado de entrada. \
$e_("saída")$: Um conjunto de estados finais pertencentes a $E_sha$, representam o fim da computação do módulo. Chamaremos eles de estados de saída. \

Importante notar que não necessariamente $e_("saída") subset F$. Ou seja, o fim da computação de $MM$ não é necessário e suficiente para parada da MT.

No decorrer desse texto também usaremos o termo "submódulo". Essa estrutura é análoga à um módulo e sua definição é construída em função de um módulo $MM$ ao invês da MT por inteiro. Essa estrutura também tem finalidades puramente organizacionais.

#pagebreak()

#let mt1 = $"MT"_1$
== Máquina de uma única fita (#mt1)
Nossa máquina de uma fita só, ou #mt1, é definida como:

$ "MT"_1 = (E, Sigma, Γ, delta, i, F) $
Tal que, \
$Sigma = {a, b, c}$ \
$Γ = {forall x,y in Sigma | x_y} union {epsilon, <} "ou" {a, b, c, a_a, a_b, a_c, b_a, b_b, b_c, c_a, c_b, c_c, <, epsilon }$ \
$F = {F_a, F_b, F_c}$

$<$ é o símbolo delimitador do início da fita. Tratamos a fita como infinita a direita. $epsilon$ representa o vazio que preenche os espaços a direita da palavra inserida.

Cada estado final representa a decisão de conceder prioridade à uma avenida no cruzamento, onde:
$ x in Sigma bar F_x: "Sinaleira prioriza avenida x" $

As transições $delta$, estados $E$, $F$ e $i$ serão definidos em representações gráficas mais a frente.

#mt1 tem dois módulos principais: $alpha$ e $beta$ definidos a seguir.

=== Módulos e submódulos
O módulo $alpha$ será responsável por verificar se a #link(<1>)[condição 1] do enunciado vale para alguma letra de $Sigma$ através do #target_1.

Caso nenhum estado final seja alcançado dentro de $alpha$, o automômato recorrerá ao módulo $beta$, onde avaliará a regra de desempate definida na #link(<2>)[condição 2] do problema. Verificando qual símbolo tem a maior cardinalidade na entrada.

A macroarquitetura da máquina tem o formato:

#figure(
  caption: "Arquitetura do automômato",
  kind: "diagrama",
  supplement: [Diagrama]
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
O módulo $alpha$ irá analisar se o #target_1 vale para alguma letra em ${a,b,c}$. Caso verifique validade de tal propriedade para a letra-alvo, é eleito o estado final apropriado representativo da decisão apropriada e computação cessa.

Visto que o automômato encerra processamento assim que é validado $Delta$ para um elemento, extraímos uma capacidade de "curto-circuito", a qual em conjunto a um processamento ordenado dos elementos de $Sigma$ permite zelar pela regra de desempate definida por #link(<1.2>)[1.2]

Portanto, efetuamos essa avaliação para as letra na ordem "a", "b" e, então, "c".

Por exemplo, caso valha #target_1 para $a$ e para $b$ ou $c$, como primeiro verificamos $a$ e interrompemos o processamento em caso positivo, implicitamente zelamos pela ordem de desempate.

Caso nenhuma letra do alfabeto cumpra com uma propriedade alvo do módulo, a computação é encaminhada para o módulo $beta$.

Quebramos cada etapa de avaliação de um símbolo em uma unidade, ou submódulo, $psi$, tal que:
$ psi(x): "Computa se x cumpre a propriedade "Delta", caso positivo, o automômato pára em" F_x $

Então, o interior de $alpha$ terá o formato:

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

Como já definimos, $psi$ deve computar:

$ Delta: #propriedade_i "onde" x, y, z in {a, b, c} " e " x != y != z $

Para tal, devemos comparar a _cardinalidade_ de $x$ com a de $y$ e $z$.

Com esse objetivo, vamos efetivamente *mapear* cada ocorrência de $x$ com uma de $y$ e de $z$.

A natureza dessa correspondência caracteriza diretamente a relação entre as cardinalidades envolvidas.

Considere $X_w$ como o conjunto de aparições de $x$ em $w$, e $Y_w$ e $Z_w$ como conjuntos análogos para outras letras.

Teremos que a computação de $Delta$ é, essencialmente, a verificação da relação entre os conjuntos $X_w$ e $Y_w$ $union$ $Z_w$ -- o qual chamaremos de $"YZ"_w$

Basta que caracterizemos esse relação para computar a propriedade desejada.
$ f: X_w -> "YZ"_w $

Da análise dela, teremos 3 possíveis interpretações:
+ Se bijetora, temos $gamma_(x)(w) = gamma_(y)(w) + gamma_(z)(w)$
+ Se injetiva, mas não sobrejetiva, temos $gamma_(x)(w) < gamma_(y)(w) + gamma_(z)(w)$
+ Se sobrejetiva, mas não injetiva, temos $gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w)$

Portanto, $psi(x)$ na $"MT"$ deve buscar parear cada $x$ em $w$ com um $y$ ou $z$, de forma que nenhum outro $x$ divida a mesma ocorrência como par. Até que:
- Sejam esgotados os $x$'s, o que nos dá que $gamma_(x)(w) <= gamma_(y)(w) + gamma_(z)(w)$
- Sejam esgotados os $y$'s e $z$'s, o que nos dá que $gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w)$

#pagebreak()

Tendo $x, y in Sigma$ onde $x != y$, $psi(x)$ tem a seguinte estrutura:

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

$F_x$ simboliza a parada total da MT1 na decisão de priorizar a avenida $x$.

Já $E_"out"$ será:
- $E_"in"$ do submódulo $psi$ seguinte, caso $x!=c$, *ou*;
- o estado de entrada do módulo $beta$, caso $x=c$;

Vamos então quebrar o fluxo das transições para verificar formalmente a computação das propriedades desejadas. As etapas serão:

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
              edge(a, b, "=>", label: "Início")
              node(b, align(center)[$E_1$], shape: circle)
              edge(b, "-|>", bend: -130deg, loop-angle: 270deg, dash: "dotted")[
                $\*,\* bar "E"$
              ]
              edge(b, "-|>", c, dash: "dotted")[<,<|D]
              node(c, align(center)[$E_2$], shape: circle)
    }
  )
]

#enum.item(2)[Avança pela fita passando por todos _y_ e $x_x$ até encontrar um $x$ ou o fim da fita.]
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
            let format = circle
            let row_y = 1
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
  + Caso não ache um $x$, entendemos que x não cumpre #link(<C>)[a propriedade C] e escapamos para $E_("out")$.
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


#enum.item(4)[Avança pela fita buscando uma $y$ onde $y in.not {x, x_x}$;]
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
            edge(f, b, "-|>", label-side: left, dash: "dotted")[$y,y_x bar "E"$]
            edge(f, d, "-|>", dash: "dotted")[$lambda,lambda bar "I"$]
    }
  )
]
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre, _x_ cumpre com a #link(<C>)[a propriedade C], pára no estado final $F_x$ e cessamos computação.
    + Caso encontre, sobreescreveremos o _y_ na fita com $y_x$ e retornamos ao passo 1.
  ]
]

Vamos para a análise da complexidade temporal, obtida a partir das transições relevantes a cada passo.

Consideraramos, por convenção, o pior caso.

Dado que o algoritmo descrito repete-se para cada elemento cujo pareamento deve ser identificado, o pior caso é aquele que força o maior número possível de iterações, ou seja, o empate, onde:
$ gamma_x = gamma_y + gamma_z $


#pagebreak()


== Máquina na íntegra
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Análise de complexidade
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Exemplos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
