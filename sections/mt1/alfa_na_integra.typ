#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: house, diamond, circle, trapezium, bracket, ellipse, brace

#set page(height: auto)
=== Módulo $alpha$ na íntegra

#figure(
  caption: $"Módulo" alpha$,
  kind: "Módulo",
  supplement: [Módulo]
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
      // edges for psi a
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
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a bar "D"$],
          [$\*_\#,\*_\# bar "D"$]
        )
      ]
      edge(<e5a>, <e2a>, "-|>", label-sep: -0.8em, label-pos: 40%)[
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$b,b_\# bar "D"$],
          [$c,c_\# bar "D"$],
        )
      ]
      edge(<e5a>, <fa>, "-|>")[$epsilon, epsilon, I$]
      node((0, 4.6), align(center)[#grid(
        columns: (auto), rows: 2, row-gutter: 5pt,
        text(size: 8pt)[Limpeza], text(size: 8pt)[1]
      )], shape: circle, name: <clean1>)
      edge(<clean1>, <clean1>, "-|>", bend: 130deg, loop-angle: 180deg)[
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 9pt)[$a,a bar "E"$],
          text(size: 9pt)[$b,b bar "E"$],
          text(size: 9pt)[$c,c bar "E"$],
          text(size: 9pt)[$\*_\#,* bar "E"$]
        )
      ]
      node((0, 8.0), [$E_2^b$], shape: circle, name: <e2b>)
      node((4, 8.0), [$E_4^b$], shape: circle, name: <e4b>)
      node((4, 5.1), [$E_5^b$], shape: circle, name: <e5b>)
      node((6, 5.1), [$F_b$], shape: circle, extrude: (0, -2), name: <fb>)
      // edges for psi b
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
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$b,b bar "D"$],
          [$\*_\#,\*_\# bar "D"$]
        )
      ]
      edge(<e5b>, <e2b>, "-|>", label-sep: -0.8em, label-pos: 40%)[
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a_\# bar "D"$],
          [$c,c_\# bar "D"$],
        )
      ]
      edge(<e5b>, <fb>, "-|>")[$epsilon, epsilon, I$]
      node((0, 11.1), align(center)[#grid(
        columns: (auto), rows: 2, row-gutter: 5pt,
        text(size: 8pt)[Limpeza], text(size: 8pt)[2]
      )], shape: circle, name: <clean2>)
      edge(<clean2>, <clean2>, "-|>", bend: 130deg, loop-angle: 180deg)[
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 9pt)[$a,a bar "E"$],
          text(size: 9pt)[$b,b bar "E"$],
          text(size: 9pt)[$c,c bar "E"$],
          text(size: 9pt)[$\*_\#,* bar "E"$]
        )
      ]
      node((0, 13.8), [$E_2^c$], shape: circle, name: <e2c>)
      node((4, 13.8), [$E_4^c$], shape: circle, name: <e4c>)
      node((4, 11.6), [$E_5^c$], shape: circle, name: <e5c>)
      node((6, 11.6), [$F_c$], shape: circle, extrude: (0, -2), name: <fc>)
      // edges for psi c
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
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$c,c bar "D"$],
          [$\*_\#,\*_\# bar "D"$]
        )
      ]
      edge(<e5c>, <e2c>, "-|>", label-sep: -0.8em, label-pos: 40%)[
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 2,
          [$a,a_\# bar "D"$],
          [$b,b_\# bar "D"$],
        )
      ]
      edge(<e5c>, <fc>, "-|>")[$epsilon, epsilon, I$]
      node((0, 16.4), align(center)[#grid(
        columns: (auto), rows: 2, row-gutter: 5pt,
        text(size: 8pt)[Limpeza], text(size: 8pt)[3]
      )], shape: circle, name: <clean3>)
      edge(<clean3>, <clean3>, "-|>", bend: 130deg, loop-angle: 180deg)[
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 9pt)[$a,a bar "D"$],
          text(size: 9pt)[$b,b bar "D"$],
          text(size: 9pt)[$c,c bar "D"$],
          text(size: 9pt)[$\*_\#,* bar "D"$]
        )
      ]
      node((0, 18), [Módulo $beta$], shape: house, name: <beta>)
      edge(<clean3>, <beta>, "-|>", label: text(size: 9pt)[$epsilon, epsilon, I$], label-side: left)
    }
  )
]
