#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "intro.typ": *
#import fletcher.shapes: circle, diamond, house


= Máquinas de Turing
Com objetivo de tratar da complexidade do problema de maneira didática, facilitando nossa argumentação, além de simplificar o processo de desenvolvimento da máquina abstrata, vamos segmentar porções de MT's (Máquinas de Turing) em 'módulos'.

Definida uma MT como:
$ "MT" = (E, Sigma, Γ, delta, i, F) $
$E$: Conjunto finito de estados \
$Sigma$: Alfabeto de entrada \
$Γ$: Alfabeto da fita \
$delta$: Funções de transição \
$i$: Estado inicial \
$F$: Conjunto de estados finais

O módulo $MM$ de MT é:
$ MM = (E_xi, Sigma, Γ, delta_xi, e_("in"), E_("out")) $
Onde, \
$E_xi$: Subconjunto de estados em $E$. \
$delta_xi$: Subconjunto de transições em $delta$ que atuem somente sobre os estados definidos em $E_xi$. \
$e_("in")$: Um estado eleito de $E_xi$, deve denotar o ínicio do módulo. Vamos nos referir a ele como estado de entrada. \
$e_("out")$: Um conjunto de estados finais pertencentes a $E_xi$, representam o fim da computação do módulo. Chamaremos eles de estados de saída. \

Importante notar que não necessariamente $e_("out") subset F$. Ou seja, o fim da computação de $MM$ não é necessário e suficiente para parada da MT.

No decorrer desse texto também usaremos o termo "submódulo". Essa estrutura é análoga à um módulo e sua definição é construída em função de um módulo $MM$ ao invês da MT por inteiro. Essa outra abstração também tem finalidades puramente organizacionais.

#pagebreak()

#let mt1 = $"MT"_1$
== Máquina de uma única fita (#mt1)
Nossa máquina de uma fita só, ou #mt1, é definida como:

$ "MT"_1 = (E, Sigma, Γ, delta, i, F) $
Tal que, \
$Sigma = {a, b, c}$ \
$Gamma = {x_\# | forall x in Sigma} union {epsilon, <} union Sigma, " ou seja," {a, b, c, a_\#, b_\#, c_\#, <, epsilon }$ \
$F = {F_a, F_b, F_c}$

$<$ é o símbolo delimitador do início da fita. Tratamos a fita como infinita a direita.

$epsilon$ representa o vazio que preenche os espaços à direita da palavra inserida.

Cada estado final representa a decisão de conceder prioridade a uma avenida no cruzamento, onde:
$ "Sendo" x in Sigma bar F_x: "Decisão de priorizar a avenida" x $

As transições $delta$, estados $E$, $F$ e $i$ serão definidos em representações gráficas mais a frente.

#mt1 tem dois módulos principais: $alpha$ e $beta$ os quais serão estabelecidos e destrinchados a seguir.

=== Módulos e submódulos
O módulo $alpha$ será responsável por verificar se a #link(<1>)[condição 1] do enunciado vale para alguma letra de $Sigma$ através do #target_1.

Caso nenhum estado final seja alcançado dentro de $alpha$, o automômato recorrerá ao módulo $beta$, onde avaliará a regra de desempate definida na #link(<2>)[condição 2] do problema. Verificando qual símbolo tem a maior cardinalidade na entrada.

A macroarquitetura da máquina assume o formato:

#figure(
  caption: "Arquitetura do automômato",
  kind: "fluxograma",
  supplement: [Fluxograma],
)[
  #align(center, [
    #diagram(
      node-stroke: 1pt,
      {
        let (a, b, c) = ((-0.5, 0), (0.5, 0), (3.5, 0))

        node(a, [])
        node(b, align(center)[Módulo $alpha$], shape: house)
        node(c, align(center)[Módulo $beta$], shape: house)

        edge(a, b, "-|>", label: text(size: 8pt)[Início])

        edge(
          b,
          c,
          "-|>",
          label: [#align(center, [#text(size: 10pt)[Se o módulo $alpha$\ não parar]])],
        )


        let row_y = 2
        let xA = 0.5
        let ext = (0, -2)

        let bA = (xA - 1, row_y)
        let bB = (xA, row_y)
        let bC = (xA + 1, row_y)

        node(bA, align(center)[$F_a$], extrude: ext)
        node(bB, align(center)[$F_b$], extrude: ext)
        node(bC, align(center)[$F_c$], extrude: ext)

        edge(b, bA, "-|>")
        edge(b, bB, "-|>")
        edge(b, bC, "-|>")

        let xB = 3.5

        let cA = (xB - 1, row_y)
        let cB = (xB, row_y)
        let cC = (xB + 1, row_y)

        node(cA, align(center)[$F^(')_a$], shape: circle, extrude: ext)
        node(cB, align(center)[$F^(')_b$], shape: circle, extrude: ext)
        node(cC, align(center)[$F^(')_c$], shape: circle, extrude: ext)

        edge(c, cA, "-|>")
        edge(c, cB, "-|>")
        edge(c, cC, "-|>")
      },
    )
  ])
]
