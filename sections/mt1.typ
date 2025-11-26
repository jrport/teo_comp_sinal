#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "introduction.typ": *
#import fletcher.shapes: house, diamond, circle

= Máquina de uma única fita
== Módulos e submódulos

Nossa máquina de uma única fita, a qual iremos tratar por *MT1*, terá dois módulos principais: $alpha$ e $beta$.

Cada estado final da máquina representará a decisão quanto a qual o único sinal que deve ter prioridade.

O módulo $alpha$ será responsável por verificar se a #link(<1>)[condição 1] do enunciado vale para alguma letra $a, b "ou" c$ através da #link(<C>)[propriedade C].

--- TODO ELABORAR NO MODULO $beta$

Caso nenhum estado final seja alcançado dentro de A, o automômato recorrerá ao módulo B, onde avaliará a #link(<2>)[condição 2] do problema.

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

=== Dentro do Módulo $alpha$
O módulo $alpha$ irá analisar se #link(<C>)[a propriedade C] vale para alguma letra em ${a,b,c}$. Essa operação será feita linearmente, um símbolo por vez.

A análisa de um desses glifos pode implicar ou na parada total do automômato ao alcançar um estado final, ou, na avaliação da condição para outro glifo do alfabeto.

Caso nenhuma letra do alfabeto cumpra com uma propriedade alvo do módulo, a computação é encaminhada para o Módulo $beta$ do automômato.

Dessa forma, abstraímos um submódulo $psi$ tal que:
$ psi(x): "Computa se x cumpre a propriedade C, caso positivo, o automômato pára." $

Iremos avaliar, nesta ordem $psi(a)$, $psi(b)$, $psi(c)$. Essa sequência garante a condição de desempate definida em #link(<1.2>)[I]. Uma vez que caso alguma avaliação de $psi$ pare, as demais não serão computadas. Assim, caso valha $psi(a)$ e $psi(b)$ ou $psi(c)$, iremos ainda parar no estado final representativo de $a$. A verdade análoga vale para $b$.


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
        node(e, align(center)[Módulo $beta$], shape: house)
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

=== Submódulo: Função $psi$
Definiremos os elementos do automômato que computa $psi$ da seguinte forma:

$ bb("MT") = {bb(Q), Sigma, Gamma, delta, q_0, bb(F)} " e " Sigma = {a, b, c} $
$ Gamma = Sigma union {forall x,y in Sigma bar x_y} " e " q_0 = E_0 " e " bb(F) = {F_x} $
$ delta: "conjunto das transições contidas na imagem abaixo." $

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
            let (a, b, c, d, e, f) = (
              (-0.5, 0),
              (0.5, 0),
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
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
            edge(b, "-|>", c)[<,<|D]
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

A partir do automômato disposto, podemos discretizar as transições na forma do algoritmo abaixo:

$w &= "palavra de entrada"$ \
$Sigma &= {a, b, c}$ \
$x in Sigma$ \

+ Lê cada letra de $w$ até encontrar uma ocorrência de x;
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre, consideramos que #link(<C>)[a propriedade C] não vale para x e então executamos $psi$ para outro x;
    + Caso encontre, sobreescreveremos o x na fita com a letra x_x;
  ]

+ Retornamos ao início da fita;
+ Buscamos uma letra y tal que $y != x$;
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre, consideramos que #link(<C>)[a propriedade C] vale para x e paramos num estado final.
    + Caso encontre, sobreescreveremos o y na fita com a letra y_x;
  ]

+ Retornamos ao início da fita e voltamos ao passo 1.

Vamos então provar que o algoritmo descrito verifica #link(<C>)[a propriedade C].

#pagebreak()

Dado que a palavra é finita, entendemos que o _loop_ para em 1.a ou 3.a.

Tendo em mente que,
$ & n in bb(N) | x, gamma_n in {a, b, c} | w "é uma palavra." | w = gamma_0 * ... * gamma_n $


Temos em 1.a e 3.a, dois casos análogos

Os passos 1, 1.2, e 2 e 4 constroem o conjunto $X$:
$ X &= {forall gamma_i in w | gamma_i = x } $
Enquanto 3, 3.2 e 4 definem $overline(X)$:
$ overline(X) &= {forall gamma_i in w | gamma_i != x } $
Basta que verifiquemos:
$ |X| > |overline(X)| $

// Ele terá por objetivo verificar se #link(<C>)[a propriedade C] vale para uma letra do alfabeto.
//
// $ x, y, z in {a, b, c} "sendo" x != y and y != z and x != z \
// "Tal que" #propriedade_i $

#pagebreak()


== Máquina na íntegra
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Análise de complexidade
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Exemplos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
