#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#show link: it => {
  set text(fill: rgb("#6a41ff"))
  underline(it)
}

#set heading(numbering: "1.")
#set page(
  margin: 1in,
  footer: none,
)
#set text(
  font: "New Computer Modern",
  size: 12pt,
)

#align(center)[
  #v(16.5em)

  #title[Controle de Tráfego Urbano Inteligente]

  #v(1em)

  #text(14pt)[
    Trabalho Final do Curso de Teoria da Computação
  ]

  #v(2em)

  #grid(
    columns: (1fr, 1fr),
    align(center)[
      João Roberto - 222217111 \
      Caio Mello - XXXX \
    ],
    align(center)[
      Vinicius - YYYYYYYYY \
      Ciclano - ZZZZZZZZ \
    ]
  )

  #v(3em)

  #align(bottom)[
    #text(12pt)[
      #text(weight: "bold")[Período Letivo] \
      2025.2
    ]
  ]
]

#pagebreak()
#outline(title: "Índice")

#include "sections/introduction.typ"

#include "sections/mt1.typ"

= Máquina de múltiplas fitas
== Módulos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Máquina na íntegra
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Análise de complexidade
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Exemplos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis

