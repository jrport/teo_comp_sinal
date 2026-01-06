#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#show link: it => {
  set text(fill: rgb("#6a41ff"))
  underline(it)
}

#set heading(numbering: "1.")
#set page(
  margin: 1in,
  numbering: "1",
)
#set par(
  justify: true,
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

  #align(center)[
    João Roberto \
    Caio Mello \
    Jonas Oliveira \
    Leandro Barbosa \
    Vinicius Caires \
  ],

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

#include "sections/intro/main.typ"
#include "sections/mt1/main.typ"
#include "sections/mt2/main.typ"