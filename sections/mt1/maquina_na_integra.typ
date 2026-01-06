#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: brace, bracket, circle, diamond, ellipse, house, trapezium
#set page(height: auto, width: auto, margin: 5em)
== Máquina na íntegra

#figure(
  caption: $"Módulos" alpha "e" beta$,
  kind: "Módulo",
  supplement: [Módulo],
)[
  #diagram(
    node-stroke: 1pt,
    spacing: (20pt, 25pt),
    {
      let start = (0, 0)
      edge((0, -1), start, "-|>", label: text(size: 10pt)[Início], label-side: left)
      node(start, [$E_1^a$], shape: circle, name: <e1a>)
      node((0, 1.7), [$E_2^a$], shape: circle, name: <e2a>)
      node((4, 1.7), [$E_4^a$], shape: circle, name: <e4a>)
      node((4, 0), [$E_5^a$], shape: circle, name: <e5a>)
      node((6, 0), [$F_a$], shape: circle, extrude: (0, -2), name: <fa>)

      edge(<e1a>, <e1a>, "-|>", bend: 130deg, loop-angle: 180deg, label: text(size: 8pt)[$*, * bar "E"$])
      edge(<e1a>, <e2a>, "-|>", text(size: 9pt)[<, <, D], label-side: right)
      edge(<e2a>, <e2a>, "-|>", bend: 130deg, loop-angle: 200deg)[
        #align(center)[
          $*_\#,*_\# bar "D"$\
          $b,b bar "D"$\
          $c,c bar "D"$
        ]
      ]
      edge(<e2a>, <clean1>, "-|>", label-side: left)[$epsilon, epsilon bar E$]
      edge(<e2a>, <e4a>, "-|>", label-side: right)[$a, a_\#, E$]
      edge(<e4a>, <e4a>, "-|>", bend: 130deg, loop-angle: -25deg)[$*,* bar E$]
      edge(<e4a>, <e5a>, "-|>")[$<,< bar D$]
      edge(<e5a>, <e5a>, "-|>", bend: 130deg, loop-angle: 100deg)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a bar "D"$],
          [$\*_\#,\*_\# bar "D"$],
        )
      ]
      edge(<e5a>, <e2a>, "-|>", label-sep: -0.8em, label-pos: 40%)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$b,b_\# bar "D"$],
          [$c,c_\# bar "D"$],
        )
      ]
      edge(<e5a>, <fa>, "-|>")[$epsilon, epsilon, I$]

      node(
        (0, 4.6),
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 5pt,
          text(size: 8pt)[Limpeza],
          text(size: 8pt)[1],
        )],
        shape: circle,
        name: <clean1>,
      )
      edge(<clean1>, <clean1>, "-|>", bend: 130deg, loop-angle: 180deg)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 9pt)[$a,a bar "E"$],
          text(size: 9pt)[$b,b bar "E"$],
          text(size: 9pt)[$c,c bar "E"$],
          text(size: 9pt)[$\*_\#,* bar "E"$],
        )
      ]

      node((0, 8.0), [$E_2^b$], shape: circle, name: <e2b>)
      node((4, 8.0), [$E_4^b$], shape: circle, name: <e4b>)
      node((4, 5.1), [$E_5^b$], shape: circle, name: <e5b>)
      node((6, 5.1), [$F_b$], shape: circle, extrude: (0, -2), name: <fb>)

      edge(<clean1>, <e2b>, "-|>", text(size: 9pt)[<, <, D], label-side: right)
      edge(<e2b>, <e2b>, "-|>", bend: 130deg, loop-angle: 200deg)[
        #align(center)[
          $*_\#,*_\# bar "D"$\
          $a,a bar "D"$\
          $c,c bar "D"$
        ]
      ]
      edge(<e2b>, <clean2>, "-|>", label-side: left)[$epsilon, epsilon bar E$]
      edge(<e2b>, <e4b>, "-|>", label-side: right)[$b, b_\#, E$]
      edge(<e4b>, <e4b>, "-|>", bend: 130deg, loop-angle: -25deg)[$*,* bar E$]
      edge(<e4b>, <e5b>, "-|>")[$<,< bar D$]
      edge(<e5b>, <e5b>, "-|>", bend: 130deg, loop-angle: 100deg)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$b,b bar "D"$],
          [$\*_\#,\*_\# bar "D"$],
        )
      ]
      edge(<e5b>, <e2b>, "-|>", label-sep: -0.8em, label-pos: 40%)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a_\# bar "D"$],
          [$c,c_\# bar "D"$],
        )
      ]
      edge(<e5b>, <fb>, "-|>")[$epsilon, epsilon, I$]

      node(
        (0, 11.1),
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 5pt,
          text(size: 8pt)[Limpeza],
          text(size: 8pt)[2],
        )],
        shape: circle,
        name: <clean2>,
      )
      edge(<clean2>, <clean2>, "-|>", bend: 130deg, loop-angle: 180deg)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 9pt)[$a,a bar "E"$],
          text(size: 9pt)[$b,b bar "E"$],
          text(size: 9pt)[$c,c bar "E"$],
          text(size: 9pt)[$\*_\#,* bar "E"$],
        )
      ]

      node((0, 13.8), [$E_2^c$], shape: circle, name: <e2c>)
      node((4, 13.8), [$E_4^c$], shape: circle, name: <e4c>)
      node((4, 11.6), [$E_5^c$], shape: circle, name: <e5c>)
      node((6, 11.6), [$F_c$], shape: circle, extrude: (0, -2), name: <fc>)

      edge(<clean2>, <e2c>, "-|>", text(size: 9pt)[<, <, D], label-side: right)
      edge(<e2c>, <e2c>, "-|>", bend: 130deg, loop-angle: 200deg)[
        #align(center)[
          $*_\#,*_\# bar "D"$\
          $a,a bar "D"$\
          $b,b bar "D"$
        ]
      ]
      edge(<e2c>, <clean3>, "-|>", label-side: left)[$epsilon, epsilon bar E$]
      edge(<e2c>, <e4c>, "-|>", label-side: right)[$c, c_\#, E$]
      edge(<e4c>, <e4c>, "-|>", bend: 130deg, loop-angle: -25deg)[$*,* bar E$]
      edge(<e4c>, <e5c>, "-|>")[$<,< bar D$]
      edge(<e5c>, <e5c>, "-|>", bend: 130deg, loop-angle: 100deg)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$c,c bar "D"$],
          [$\*_\#,\*_\# bar "D"$],
        )
      ]
      edge(<e5c>, <e2c>, "-|>", label-sep: -0.8em, label-pos: 40%)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a_\# bar "D"$],
          [$b,b_\# bar "D"$],
        )
      ]
      edge(<e5c>, <fc>, "-|>")[$epsilon, epsilon, I$]

      node(
        (0, 16.4),
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 5pt,
          text(size: 8pt)[Limpeza],
          text(size: 8pt)[3],
        )],
        shape: circle,
        name: <clean3>,
      )
      edge(<clean3>, <clean3>, "-|>", bend: 130deg, loop-angle: 180deg)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 9pt)[$a,a bar "D"$],
          text(size: 9pt)[$b,b bar "D"$],
          text(size: 9pt)[$c,c bar "D"$],
          text(size: 9pt)[$\*_\#,* bar "D"$],
        )
      ]

      let beta_start = 18.5
      let (a1, b1, c1, d1, e1, f1, g1, h1, i1, j1) = (
        (0.0, beta_start + -0.5),
        (0, beta_start + 0.5),
        (0, beta_start + 4.0),
        (-4, beta_start + 6.5),
        (-2, beta_start + 4.0),
        (-4, beta_start + 4.0),
        (0, beta_start + 6.5),
        (2, beta_start + 6.5),
        (-2, beta_start + 6.5),
        (4, beta_start + 6.5),
      )

      let format = circle

      edge(<clean3>, b1, "-|>", label: text(size: 9pt)[$epsilon, epsilon, I$], label-side: left)

      node(h1, [$E_8^(a times b)$], shape: format)
      node(b1, [$E_1^(a times b)$], shape: format)
      node(c1, [$E_2^(a times b)$], shape: format)
      node(e1, [$E_4^(a times b)$], shape: format)
      node(g1, [$E_6^(a times b)$], shape: format)
      node(f1, [$E_5^(a times b)$], shape: format)
      node(i1, [$E_7^(a times b)$], shape: format)
      node(j1, [$E_<^(a times b)$], shape: format)
      node(d1, [$E_>=^(a times b)$], shape: format)
      node(a1, [])

      edge(h1, "-|>", h1, bend: -130deg, loop-angle: 270deg, label-size: 7pt)[$\*,\* bar "D"$]
      edge(g1, "-|>", h1, label-size: 7pt)[$b,b bar D$]
      edge(h1, "-|>", j1, label-size: 7pt)[$epsilon,epsilon bar "D"$]
      edge(a1, b1, "-|>")
      edge(b1, "-|>", b1, bend: -130deg, loop-angle: 180deg, label-size: 7pt)[$\*,\* bar "E"$]
      edge(g1, "-|>", i1, label-side: left, label-size: 7pt)[$<,< bar "D"$]
      edge(g1, "-|>", g1, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$*, *, E$]
      edge(c1, "-|>", c1, bend: -130deg, loop-angle: 180deg, label-size: 7pt)[
        $*_\#,*_\# bar "D"\
        b,b bar "D"$
      ]
      edge(b1, "-|>", c1, label-size: 7pt)[<,<|D]
      edge(c1, "-|>", g1, label-size: 7pt)[$epsilon, epsilon bar I$]
      edge(i1, "-|>", d1, label-size: 7pt)[$epsilon, epsilon bar I$]
      edge(c1, e1, "-|>", label-side: left, label-size: 7pt)[$a, a_\# bar "E"$]
      edge(e1, "-|>", e1, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$\*,\* bar "E"$]
      edge(i1, "-|>", i1, bend: -130deg, loop-angle: 90deg, label-size: 7pt)[$\*,\* bar "D"$]
      edge(e1, f1, "-|>", label-side: left, label-size: 7pt)[$<, < bar "D"$]
      edge(f1, "-|>", f1, bend: -130deg, loop-angle: 0deg, label-size: 7pt)[
        #grid(
          columns: auto,
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a bar "D"$],
          [$\*_\#,\*_\# bar "D"$],
        )
      ]
      edge(f1, b1, "-|>", label-side: left, label-size: 7pt)[$b,b_\# bar "E"$]
      edge(f1, d1, "-|>", label-size: 7pt)[$epsilon,epsilon bar "I"$]

      let limp1_esq = (-5, beta_start + 8.5)
      node(
        limp1_esq,
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 5pt,
          text(size: 8pt)[Limpeza],
          text(size: 8pt)[5],
        )],
        shape: circle,
      )

      edge(d1, limp1_esq, "-|>", label-side: left)
      edge(limp1_esq, "-|>", limp1_esq, bend: -130deg, loop-angle: 90deg, label-size: 6pt)[
        $*_\#,* bar "D"\
        a,a bar "D" \
        b,b bar "D" \
        c,c bar "D"$
      ]
      let limp1_dir = (5, beta_start + 8.5)
      node(
        limp1_dir,
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 5pt,
          text(size: 8pt)[Limpeza],
          text(size: 8pt)[4],
        )],
        shape: circle,
      )

      edge(j1, limp1_dir, "-|>", label-side: right)
      edge(limp1_dir, "-|>", limp1_dir, bend: -130deg, loop-angle: 90deg, label-size: 6pt)[
        $*_\#,* bar "D"\
        a,a bar "D" \
        b,b bar "D" \
        c,c bar "D"$
      ]

      let offset_esq = -8.0
      let y_offset = beta_start + 9.0

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
        (0, beta_start + 15.5),
      )

      edge(limp1_esq, a2, "-|>", label: text(size: 7pt)[$epsilon, epsilon bar I$], label-side: left)

      node(h2, [$E_8^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(b2, [$E_1^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(c2, [$E_2^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(e2, [$E_4^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(g2, [$E_6^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(f2, [$E_5^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(i2, [$E_7^(a times c)$], shape: format, height: 8mm, width: 8mm)
      node(d2, [$F^(')_a$], shape: circle, extrude: (0, -2))
      node(a2, [])

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

      edge(limp1_dir, a3, "-|>", label: text(size: 7pt)[$epsilon, epsilon bar I$], label-side: right)

      node(h3, [$E_8^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(b3, [$E_1^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(c3, [$E_2^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(e3, [$E_4^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(g3, [$E_6^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(f3, [$E_5^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(i3, [$E_7^(b times c)$], shape: format, height: 8mm, width: 8mm)
      node(j3, [$F^(')_c$], shape: circle, extrude: (0, -2))
      node(d3, [$F^(')_b$], shape: circle, extrude: (0, -2))
      node(a3, [])

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
