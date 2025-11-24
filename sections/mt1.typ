#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "introduction.typ": *
#import fletcher.shapes: house, diamond, circle

= Máquina de uma única fita
== Módulos e submódulos

Para a máquina de uma fita, a qual nos referiremos por MT1, teremos dois módulos principais que chamaremos de A e B.

O módulo A será responsável por verificar a condição #link(<1>)[1] do enunciado para alguma letra $a, b "ou" c$ através da propriedade #link(<ineq>)[I].

Para tal, a máquina buscará parar num estado final que represente qual a decisão tomada.

Caso nenhum estado final seja alcançado dentro de A, o automômato recorrerá ao módulo B, onde avaliará a condição #link(<2>)[2] do problema.

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
        node(b, align(center)[Módulo A], shape: house)
        node(c, align(center)[Módulo B], shape: house)

        edge(a, b, "-|>", label: text(size: 8pt)[Início])

        edge(
          b, c, "-|>",
          label: [#align(center, [#text(size: 10pt)[Se o módulo A\ não parar]])]
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

=== Dentro do Módulo A
O módulo A por sua vez, irá sequencialmente analisar se #link(<I>)[a propriedade I] vale para cada letra em ${a,b,c}$. Essa operação será feita linearmente, uma vez para cada símbolo até que a condição de parada seja cumprida ou os símbolos se esgotem.

Neste último caso entendemos que ninguém cumpriu com as condições necessárias para parada e recorremos ao módulo B.

Dessa forma, abstraímos um submódulo $psi$ tal que:
$ psi(x): "Computa se x cumpre a propriedade I, caso positivo, o automômato pára." $

Verificaremos na ordem $psi(a)$, $psi(b)$, $psi(c)$. Garantindo a condição de desempate definida em #link(<1.2>)[1.2].
Uma vez que caso alguma avaliação de $psi$ pare, as demais não serão computadas. Assim preservamos a ordem de prioridade nos empates.


#figure(
  caption: "Formato do Módulo A",
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
        node(e, align(center)[Módulo B], shape: house)
        edge(a, b, "-|>", label: text(size: 8pt)[Início])
        edge(b, c, "->", label: text(size: 8pt)[$psi(a) "não parou"$])
        edge(c, d, "->", label: text(size: 8pt)[$psi(b) "não parou"$])
        edge(d, e, "->", label: text(size: 8pt)[$psi(c) "não parou"$])

        let ext = (0, -2)
        node((0.5, row_y), align(center)[$F_a$], shape: circle, extrude: ext)
        node((2.5, row_y), align(center)[$F_b$], shape: circle, extrude: ext)
        node((4.5, row_y), align(center)[$F_c$], shape: circle, extrude: ext)
        edge(b, (0.5, row_y), "->", label: text(size: 8pt)[$psi(a) "parou"$], label-side: right)
        edge(c, (2.5, row_y), "->", label: text(size: 8pt)[$psi(b) "parou"$])
        edge(d, (4.5, row_y), "->", label: text(size: 8pt)[$psi(c) "parou"$])
      }
    )
  ])
]

#pagebreak()

=== Função $psi$
Essa parte da máquina deve verificar se vale:
$ exists x, y, z in {a, b, c} "onde" x != y and y != z and x != z $
Tal que,
#propriedade_i

Para isto, definimos dois conjuntos $X$ e $overline(X)$ da seguinte forma:

Sejam,
$ & n in bb(N) | x, gamma_n in {a, b, c} | w "é uma palavra." $
$ w = gamma_0 * ... * gamma_n $

Temos,
$ X &= {forall gamma_i in w | gamma_i = x }, "e" \
overline(X) &= {forall gamma_i in w | gamma_i != x } $

Vamos computar se,
$ |X| > |overline(X)| $

ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Máquina na íntegra
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Análise de complexidade
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Exemplos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
