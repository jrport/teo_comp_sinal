#set page(height: auto, width: auto, margin: 5em)

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: circle, hexagon, pill
=== Módulo $beta$ na íntegra
#align(center)[
  #set text(size: 9pt)
  #block[
    #figure(
      caption: $"Módulo" beta$,
      kind: "Módulo",
      supplement: [Módulo],
    )[
      #diagram(
        node-stroke: .1em,
        spacing: (25pt, 17pt),
        {
          // ========== DUELO 1: ψ(a,b) ==========
          let (a1, b1, c1, d1, e1, f1, g1, h1, i1, j1) = (
            (0.0, -0.5),
            (0, 0.5),
            (0, 4.0),
            (-4, 6.5),
            (-2, 4.0),
            (-4, 4.0),
            (0, 6.5),
            (2, 6.5),
            (-2, 6.5),
            (4, 6.5),
          )

          let format = circle

          // Nodes do Duelo 1
          node(h1, align(center)[$E_8$], shape: format)
          node(b1, align(center)[$E_1$], shape: format)
          node(c1, align(center)[$E_2$], shape: format)
          node(e1, align(center)[$E_4$], shape: format)
          node(g1, align(center)[$E_6$], shape: format)
          node(f1, align(center)[$E_5$], shape: format)
          node(i1, align(center)[$E_7$], shape: format)
          node(j1, align(center)[$E_<^((1))$], shape: format)
          node(d1, align(center)[$E_>=^((1))$], shape: format)
          node(a1, [])

          // Edges do Duelo 1
          edge(h1, "-|>", h1, bend: -130deg, loop-angle: 270deg)[$\*,\* bar "D"$]
          edge(g1, "-|>", h1)[$b,b bar D$]
          edge(h1, "-|>", j1)[$epsilon,epsilon bar "D"$]
          edge(a1, b1, "-|>", label: "Início")
          edge(b1, "-|>", b1, bend: -130deg, loop-angle: 180deg)[$\*,\* bar "E"$]
          edge(g1, "-|>", i1, label-side: left)[$<,< bar "D"$]
          edge(g1, "-|>", g1, bend: -130deg, loop-angle: 90deg)[$*, *, E$]
          edge(c1, "-|>", c1, bend: -130deg, loop-angle: 180deg)[
            $*_\#,*_\# bar "D"\
            b,b bar "D"$
          ]
          edge(b1, "-|>", c1)[<,<|D]
          edge(c1, "-|>", g1)[$epsilon, epsilon bar I$]
          edge(i1, "-|>", d1)[$epsilon, epsilon bar I$]
          edge(c1, e1, "-|>", label-side: left)[$a, a_\# bar "E"$]
          edge(e1, "-|>", e1, bend: -130deg, loop-angle: 90deg)[$\*,\* bar "E"$]
          edge(i1, "-|>", i1, bend: -130deg, loop-angle: 90deg)[$\*,\* bar "D"$]
          edge(e1, f1, "-|>", label-side: left)[$<, < bar "D"$]
          edge(f1, "-|>", f1, bend: -130deg, loop-angle: 0deg)[
            #grid(
              columns: auto,
              align: (right),
              row-gutter: 7pt,
              rows: 2,
              [$a,a bar "D"$],
              [$\*_\#,\*_\# bar "D"$],
            )
          ]
          edge(f1, b1, "-|>", label-side: left)[$b,b_\# bar "E"$]
          edge(f1, d1, "-|>")[$epsilon,epsilon bar "I"$]

          // ========== LIMPEZA 1 (esquerda) ==========
          let limp1_esq = (-5, 8.5)
          node(
            limp1_esq,
            align(center)[
              #text(size: 8pt, weight: "bold")[Limpeza]
            ],
            shape: format,
            fill: rgb("#fff9c4"),
          )

          edge(d1, limp1_esq, "-|>", label-side: left)
          edge(limp1_esq, "-|>", limp1_esq, bend: -130deg, loop-angle: 90deg, label-size: 6pt)[
            $a_\#,a bar "D"\
            b_\#,b bar "D"$
          ]

          // ========== LIMPEZA 2 (direita) ==========
          let limp1_dir = (5, 8.5)
          node(
            limp1_dir,
            align(center)[
              #text(size: 8pt, weight: "bold")[Limpeza]
            ],
            shape: format,
            fill: rgb("#fff9c4"),
          )

          edge(j1, limp1_dir, "-|>", label-side: right)
          edge(limp1_dir, "-|>", limp1_dir, bend: -130deg, loop-angle: 90deg, label-size: 6pt)[
            $a_\#,a bar "D"\
            b_\#,b bar "D"$
          ]

          // ========== DUELO 2: ψ(a,c) - quando a>=b ==========
          let offset_esq = -8.0
          let y_offset = 9.0

          let (a2, b2, c2, d2, e2, f2, g2, h2, i2, j2) = (
            (offset_esq + 0.0, y_offset + -0.5),
            (offset_esq + 0, y_offset + 0.5),
            (offset_esq + 0, y_offset + 4.0),
            (offset_esq + -4, y_offset + 6.5),
            (offset_esq + -2, y_offset + 4.0),
            (offset_esq + -4, y_offset + 4.0),
            (offset_esq + 0, y_offset + 6.5),
            (offset_esq + 2, y_offset + 6.5),
            (offset_esq + -2, y_offset + 6.5),
            (0, 15.5),
          )

          // Conexão da Limpeza 1 para Duelo 2
          edge(limp1_esq, a2, "-|>", label: text(size: 7pt)[$epsilon, epsilon bar I$], label-side: left)

          // Nodes do Duelo 2
          node(h2, align(center)[#text(size: 8pt)[$E_8$]], shape: format, height: 8mm, width: 8mm)
          node(b2, align(center)[#text(size: 8pt)[$E_1$]], shape: format, height: 8mm, width: 8mm)
          node(c2, align(center)[#text(size: 8pt)[$E_2$]], shape: format, height: 8mm, width: 8mm)
          node(e2, align(center)[#text(size: 8pt)[$E_4$]], shape: format, height: 8mm, width: 8mm)
          node(g2, align(center)[#text(size: 8pt)[$E_6$]], shape: format, height: 8mm, width: 8mm)
          node(f2, align(center)[#text(size: 8pt)[$E_5$]], shape: format, height: 8mm, width: 8mm)
          node(i2, align(center)[#text(size: 8pt)[$E_7$]], shape: format, height: 8mm, width: 8mm)
          node(
            j2,
            align(center)[#text(size: 10pt, weight: "bold")[C]],
            shape: format,
            fill: rgb("#ffccbc"),
            height: 12mm,
            width: 12mm,
          )
          node(
            d2,
            align(center)[#text(size: 10pt, weight: "bold")[A]],
            shape: format,
            fill: rgb("#c8e6c9"),
            height: 12mm,
            width: 12mm,
          )
          node(a2, [])

          // Edges do Duelo 2
          edge(h2, "-|>", h2, bend: -130deg, loop-angle: 270deg, label-size: 7pt)[$\*,\* bar "D"$]
          edge(g2, "-|>", h2, label-size: 7pt)[$c,c bar D$]
          edge(h2, "-|>", j2, label-size: 7pt)[$epsilon,epsilon bar "D"$]
          edge(a2, b2, "-|>")
          edge(b2, "-|>", b2, bend: -130deg, loop-angle: -30deg, label-size: 7pt)[$\*,\* bar "E"$]
          edge(g2, "-|>", i2, label-side: left, label-size: 7pt)[$<,< bar "D"$]
          edge(g2, "-|>", g2, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$*, *, E$]
          edge(c2, "-|>", c2, bend: -130deg, loop-angle: 180deg, label-size: 7pt)[
            $*_\#,*_\# bar "D"\
            c,c bar "D"$
          ]
          edge(b2, "-|>", c2, label-size: 7pt)[<,<|D]
          edge(c2, "-|>", g2, label-size: 7pt)[$epsilon, epsilon bar I$]
          edge(i2, "-|>", d2, label-size: 7pt)[$epsilon, epsilon bar I$]
          edge(c2, e2, "-|>", label-side: left, label-size: 7pt)[$a, a_\# bar "E"$]
          edge(e2, "-|>", e2, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$\*,\* bar "E"$]
          edge(i2, "-|>", i2, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$\*,\* bar "D"$]
          edge(e2, f2, "-|>", label-side: left, label-size: 7pt)[$<, < bar "D"$]
          edge(f2, "-|>", f2, bend: -130deg, loop-angle: 0deg, label-size: 6pt)[
            #grid(
              columns: auto,
              align: (right),
              row-gutter: 5pt,
              rows: 2,
              [$a,a bar "D"$],
              [$\*_\#,\*_\# bar "D"$],
            )
          ]
          edge(f2, b2, "-|>", label-side: left, label-size: 7pt)[$c,c_\# bar "E"$]
          edge(f2, d2, "-|>", label-size: 7pt)[$epsilon,epsilon bar "I"$]

          // ========== DUELO 3: ψ(b,c) - quando b>a ==========
          let offset_dir = 8.0

          let (a3, b3, c3, d3, e3, f3, g3, h3, i3, j3) = (
            (offset_dir + 0.0, y_offset + -0.5),
            (offset_dir + 0, y_offset + 0.5),
            (offset_dir + 0, y_offset + 4.0),
            (offset_dir + 4, y_offset + 6.5),
            (offset_dir + 2, y_offset + 4.0),
            (offset_dir + 4, y_offset + 4.0),
            (offset_dir + 0, y_offset + 6.5),
            (offset_dir + -3, y_offset + 6.5),
            (offset_dir + 2, y_offset + 6.5),
            (offset_dir + -8, y_offset + 6.5),
          )

          // Conexão da Limpeza 2 para Duelo 3
          edge(limp1_dir, a3, "-|>", label: text(size: 7pt)[$epsilon, epsilon bar I$], label-side: right)

          // Nodes do Duelo 3
          node(h3, align(center)[#text(size: 8pt)[$E_8$]], shape: format, height: 8mm, width: 8mm)
          node(b3, align(center)[#text(size: 8pt)[$E_1$]], shape: format, height: 8mm, width: 8mm)
          node(c3, align(center)[#text(size: 8pt)[$E_2$]], shape: format, height: 8mm, width: 8mm)
          node(e3, align(center)[#text(size: 8pt)[$E_4$]], shape: format, height: 8mm, width: 8mm)
          node(g3, align(center)[#text(size: 8pt)[$E_6$]], shape: format, height: 8mm, width: 8mm)
          node(f3, align(center)[#text(size: 8pt)[$E_5$]], shape: format, height: 8mm, width: 8mm)
          node(i3, align(center)[#text(size: 8pt)[$E_7$]], shape: format, height: 8mm, width: 8mm)
          node(
            j3,
            align(center)[#text(size: 10pt, weight: "bold")[C]],
            shape: format,
            fill: rgb("#ffccbc"),
            height: 12mm,
            width: 12mm,
          )
          node(
            d3,
            align(center)[#text(size: 10pt, weight: "bold")[B]],
            shape: format,
            fill: rgb("#ffe0b2"),
            height: 12mm,
            width: 12mm,
          )
          node(a3, [])

          // Edges do Duelo 3
          edge(h3, "-|>", h3, bend: -130deg, loop-angle: 270deg, label-size: 7pt)[$\*,\* bar "D"$]
          edge(g3, "-|>", h3, label-size: 7pt)[$c,c bar D$]
          edge(h3, "-|>", j3, label-size: 7pt)[$epsilon,epsilon bar "D"$]
          edge(a3, b3, "-|>")
          edge(b3, "-|>", b3, bend: -130deg, loop-angle: 210deg, label-size: 7pt)[$\*,\* bar "E"$]
          edge(g3, "-|>", i3, label-side: left, label-size: 7pt)[$<,< bar "D"$]
          edge(g3, "-|>", g3, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$*, *, E$]
          edge(c3, "-|>", c3, bend: -130deg, loop-angle: 0deg, label-size: 7pt)[
            $*_\#,*_\# bar "D"\
            c,c bar "D"$
          ]
          edge(b3, "-|>", c3, label-size: 7pt)[<,<|D]
          edge(c3, "-|>", g3, label-size: 7pt)[$epsilon, epsilon bar I$]
          edge(i3, "-|>", d3, label-size: 7pt)[$epsilon, epsilon bar I$]
          edge(c3, e3, "-|>", label-side: left, label-size: 7pt)[$b, b_\# bar "E"$]
          edge(e3, "-|>", e3, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$\*,\* bar "E"$]
          edge(i3, "-|>", i3, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$\*,\* bar "D"$]
          edge(e3, f3, "-|>", label-side: left, label-size: 7pt)[$<, < bar "D"$]
          edge(f3, "-|>", f3, bend: -130deg, loop-angle: 180deg, label-size: 6pt)[
            #grid(
              columns: auto,
              align: (right),
              row-gutter: 5pt,
              rows: 2,
              [$b,b bar "D"$],
              [$\*_\#,\*_\# bar "D"$],
            )
          ]
          edge(f3, b3, "-|>", label-side: left, label-size: 7pt)[$c,c_\# bar "E"$]
          edge(f3, d3, "-|>", label-size: 7pt)[$epsilon,epsilon bar "I"$]
        },
      )
    ]
  ]
]


#pagebreak()
