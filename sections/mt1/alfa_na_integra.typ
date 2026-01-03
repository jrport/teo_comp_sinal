=== Módulo $alpha$ na íntegra
#figure(
  caption: $"Módulo" alpha$,
  kind: "Máquina de Turing",
  supplement: [Máquina de Turing]
)[
  #import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
  #set text(size: 11pt)
  #diagram(
    node-stroke: 1pt, {
      // nodes
      let start = (0, 0)
      edge((0, -1), start, "-|>", label: text(size: 10pt)[Início], label-side: left)

      // ============ psi(a, {b,c}) ============
      node(start, [$E_1^a$], shape: circle, name: <e1a>)
      node((0, 1.7), [$E_2^a$], shape: circle, name: <e2a>)
      node((0, 3.3), [$E_3^a$], shape: circle, name: <e3a>)
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
      edge(<e2a>, <e3a>, "-|>", label-side: left)[$epsilon, epsilon bar E$]
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
    }
  )
]
