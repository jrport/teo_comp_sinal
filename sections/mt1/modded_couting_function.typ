#let npsi = $psi'$
=== Função #npsi
Vamos fazer os ajustes necessário em $psi$ para obter dois novos estados de escape $E_>=$ e $E_<$, respectivamente, representando "maior ou igual a" e "menor que".

Para tal, definimos #npsi como segue:

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: circle, hexagon, pill
#align(center)[
  #set text(size: 9pt)
  #block[
    #figure(
      caption: $"Função" psi$,
      kind: "Submódulo",
      supplement: [Submódulo],
    )[
      #diagram(
        node-stroke: .1em,
        {
          let (a, b, c, d, e, f, g, h, i, j) = (
            (-0.5, 0),
            (0.5, 0),
            (4.0, 0),
            (6.5, 4),
            (4.0, 2),
            (4.0, 4),
            (6.5, 0),
            (9.0, 0),
            (6.5, 2),
            (9.0, 2),
          )
          let format = circle
          let row_y = 1

          node(h, align(center)[$E_8$], shape: format, stroke: red)
          edge(h, "-|>", h, bend: -130deg, loop-angle: 180deg, stroke: red)[$\*,\* bar "D"$]
          edge(g, "-|>", h, stroke: red)[$y,y bar D$]
          edge(h, "-|>", j, stroke: red)[$epsilon,epsilon bar "D"$]

          node(a, [])
          edge(a, b, "=>", label: "Início")
          node(b, align(center)[$E_1$], shape: format)
          edge(b, "-|>", bend: -130deg, loop-angle: 270deg)[
            $\*,\* bar "E"$
          ]
          node(c, align(center)[$E_2$], shape: format)
          node(g, align(center)[$E_6$], shape: format, stroke: red)
          node(j, align(center)[$E_<$], shape: format)
          edge(g, "-|>", i, label-side: left, stroke: red)[$<,< bar "D"$]

          edge(g, "-|>", g, bend: -130deg, loop-angle: 270deg, stroke: red)[$*, *, E$]
          edge(c, "-|>", c, bend: -130deg, loop-angle: 260deg)[
            $*_\#,*_\# bar "D"\
            y,y bar "D"$
          ]
          edge(b, "-|>", c)[<,<|D]
          edge(c, "-|>", g)[$epsilon, epsilon bar I$]
          node(d, align(center)[$E_>=$], shape: format)
          node(i, align(center)[$E_7$], shape: format, stroke: red)
          edge(i, "-|>", d, stroke: red)[$epsilon, epsilon bar I$]
          edge(c, e, "-|>", label-side: left)[$x, x_\# bar "E"$]
          edge(e, "-|>", e, bend: -130deg, loop-angle: 170deg)[
            $\*,\* bar "E"$
          ]
          edge(i, "-|>", i, bend: -130deg, loop-angle: 180deg, stroke: red)[
            $\*,\* bar "D"$
          ]
          node(e, align(center)[$E_4$], shape: format)
          edge(e, f, "-|>", label-side: left)[
            $<, < bar "D"$
          ]
          node(f, align(center)[$E_5$], shape: format)
          edge(f, "-|>", f, bend: -130deg, loop-angle: 0deg)[
            #grid(
              columns: auto,
              align: (right),
              row-gutter: 7pt,
              rows: 2,
              [$x,x bar "D"$],
              [$\*_\#,\*_\# bar "D"$],
            )
          ]
          edge(f, b, "-|>", label-side: left)[$y,y_\# bar "E"$]
          edge(f, d, "-|>")[$epsilon,epsilon bar "I"$]
        },
      )
    ]
  ]
]

Preservamos todas as transições de $psi$, apenas substituimos $E_>$ por $E_>=$ e $E_<=$ por $E_<$, e acrescentamos um loop de busca por um $x$.

De forma que, após determinarmos que não existem mais símbolos $x$ na fita após $E_2$, buscamos por pelo menos um símbolo $y$ para garantir que $gamma_(x)(w) < gamma_(y)(w)$.

Sabemos, com base na prova da certeza de $psi$ que em $E_2$, $|X| = |overline(X)|$.

Vamos usar dessa hipótese e tratar as novas transições e estados -- que estão destacados em vermelho -- como uma MT isolada e demonstrar como ela apropriadamente determina se $|X| < |Y|$ ou $|X| >= |Y|$.

==== Prova da certeza de #npsi

Vamos verificar se a submáquina formada por ${E_6, E_7, E_8, E_>=, E_<}$ determina se $|X| < |Y|$ ou $|X|>= |Y|$ corretamente:

Temos que nos estados,
- $E_6$: busca por símbolos $y$ não processados
- $E_7$: encontrou pelo menos um $y$ restante
- $E_8$: verifica ausência de $y$ restantes
- $E_>=$: estado final para $|X| >= |Y|$
- $E_<$: estado final para $|X| < |Y|$

#pagebreak()

Tome nota desses dois estados relevantes:
1. Em $E_2$, temos:
$ E_2 -->^(epsilon, epsilon | I) E_6 $
2. Em $E_6$, a máquina move-se à direita até:
$ E_6 -->^(y, y | D) E_7 quad "ou" quad E_6 -->^(<, < | D) E_8 $

Então, dado uma palavra $w$ na fita e os conjuntos de ocorrência $X$ e $overline(X)$, que foram previamente definidos, vamos supor os 3 possíveis casos quanta a comparação da cardinalidade:

*Caso 1:* $|X| = |Y|$

Teremos todos os $x$ e $y$ pareados já pareados, vide o funcionamento da $psi$. A máquina não encontra $y$ restantes em $E_6$, eventualmente alcançando $E_>=$ (diretamente ou via $E_8$).

*Caso 2:* $|X| < |Y|$

Existirão símbolos $y$ não processados, vide o funcionamento de $psi$. A execução segue:
$ E_6 -->^(y, y | D) E_8 -->^(*, * | D) E_8 -->^(epsilon, epsilon | I) E_< $

*Caso 3:* $|X| > |Y|$

Este caso é *impossível* ao alcançar $E_2$. A transição $E_2 -->^(epsilon, epsilon | I) E_6$ só ocorre quando não há mais símbolos $x$ na fita. Pela construção de $psi$, cada $x$ é marcado como $x_\#$ somente quando há símbolo correspondente disponível. Se $|X| > |Y|$, a máquina já teria alcançado o estado $E_>=$ por $E_5$.

Temos então certeza de que o módulo definido pelos estados ${E_6, E_7, E_8, E_>=, E_<}$ e suas respectivas transições computa corretamente a regra:
$
  cases(
    "aceita em" E_>= "se" |X| >= |Y|,
    "aceita em" E_< "se" |X| < |Y|
  )
$
