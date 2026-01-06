=== Módulo $beta$ na íntegra

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
          edge(g, "-|>", h, stroke: red)[$b,b bar D$]
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
            b,b bar "D"$
          ]
          edge(b, "-|>", c)[<,<|D]
          edge(c, "-|>", g)[$epsilon, epsilon bar I$]
          node(d, align(center)[$E_>=$], shape: format)
          node(i, align(center)[$E_7$], shape: format, stroke: red)
          edge(i, "-|>", d, stroke: red)[$epsilon, epsilon bar I$]
          edge(c, e, "-|>", label-side: left)[$a, a_\# bar "E"$]
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
              [$a,a bar "D"$],
              [$\*_\#,\*_\# bar "D"$],
            )
          ]
          edge(f, b, "-|>", label-side: left)[$b,b_\# bar "E"$]
          edge(f, d, "-|>")[$epsilon,epsilon bar "I"$]
        },
      )
    ]
  ]
]