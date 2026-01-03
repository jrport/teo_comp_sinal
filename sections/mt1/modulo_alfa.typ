#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "../intro/intro.typ": *

=== Módulo $alpha$
O módulo $alpha$ irá analisar se o #target_1 vale para alguma letra em ${a,b,c}$. Caso verifique validade de tal propriedade para a letra-alvo, é eleito o estado final apropriado representativo da decisão apropriada e a computação cessa.

Visto que o automômato encerra processamento assim que é validado $Delta$ para um elemento, extraímos uma capacidade de "curto-circuito", a qual em conjunto a um processamento ordenado dos elementos de $Sigma$ permite zelar pela regra de desempate definida em #link(<1.2>)[1.2]

Portanto, efetuamos essa avaliação para as letra na ordem "a", "b" e, então, "c", implicitamente zelando pela ordem de desempate.

Caso nenhuma letra do alfabeto cumpra com a propriedade alvo de $alpha$, a computação é encaminhada para o módulo $beta$.

Vamos então quebrar o processamento em 3 instâncias de submódulos $psi$, tratando os estados $E_>$ de cada como a decisão de concessão de prioridade para a letra.

Esses submódulos serão intercalados por um estado de "limpeza" com transições que irão remover os símbolo marcados retornando o conteúdo da fita a entrada inicial.
Dessa forma símbolos escritos por $psi$ não afetarão os submódulos seguintes.

Vale notar que existe uma alternativa que reduziria o custo computacional da MT, por mieo da remoção desses estados de limpeza, incluindo ao alfabeto da fita símbolos de marcação específicos pra cada $psi$, e então incorporando-os nas transições dos submódulos de contagem seguintes.

Apesar de mais eficiente, isso acrescentaria um número considerável de transições, então optamos por manter essa estrutura.

Cada estado de limpeza, segue o formato
#import fletcher.shapes: house, diamond, circle, trapezium, bracket, ellipse, brace
#figure(
  caption: "Estado de limpeza",
  kind: "Máquina de Turing",
  supplement: [Máquina de Turing]
)[
  #diagram(
    node-stroke: 1pt, {
      node((0, 0), align(center)[#grid(columns: (auto), rows: 2, row-gutter: 7pt, text(size: 9pt)[Estado], text(size: 9pt)[de limpeza])], shape: circle)
      edge((0,0), (0,1),  "-|>", label: text(size: 8pt)[$epsilon, epsilon, N$])
      edge((0,0), (0,0), "-|>", bend: 130deg, loop-angle: 180deg, label: [
        #grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 10pt)[$a,a bar "D"$],
          text(size: 10pt)[$b,b bar "D"$],
          text(size: 10pt)[$c,c bar "D"$],
          text(size: 10pt)[$\*_\#,* bar "D"$]
      )
      ])
    }
  )
]

#pagebreak()

Dando ao módulo $alpha$ o formato:

#figure(
  caption: $"Raio-x do módulo" alpha$,
  kind: "fluxograma",
  supplement: [Fluxograma]
)[
  #diagram(
      node-stroke: 1pt, {
        let (a, b, f_b, c, d, f_d, e, f, f_f, g, h) = (
          (-1, 0),
          (0, 0), (2, 0),
          (0, 1),
          (0, 2), (2, 2),
          (0, 3),
          (0, 4), (2, 4),
          (0, 5),
          (0, 7),
        )
      let trap = trapezium.with(fit: 0.4)
      let ell = ellipse.with(scale: 1.2)
      let row_y = 1
      let ext = (0, -2)

      let title_limpeza = align(center)[#grid(columns: (auto), rows: 2, row-gutter: 7pt, text(size: 8pt)[Estado], text(size: 8pt)[de limpeza])]

      // nodes
      node(a, [], name: <Start>)
      node(b, align(center)[$psi(a, {b, c})$], shape: trap)
      node(f_b, align(center)[$F_a$], shape: circle, extrude: ext)
      node(c, title_limpeza, shape: circle)
      node(d, align(center)[$psi(b, {a, c})$], shape: trap)
      node(f_d, align(center)[$F_b$], shape: circle, extrude: ext)
      node(e, title_limpeza, shape: circle)
      node(f, align(center)[$psi(b, {a, c})$], shape: trap)
      node(f_f, align(center)[$F_c$], shape: circle, extrude: ext)
      node(g, title_limpeza, shape: circle, name: <End>)
      node(h, align(center)[Módulo $beta$], shape: house)

      // edges
      edge(a, b, "-|>", label: text(size: 8pt)[Início])
      edge(b, c, "-|>", label: text(size: 8pt)[_a_ não cumpre $Delta$], label-side: left)
      edge(c, d, "-|>", label: text(size: 8pt)[$epsilon, epsilon, N$])
      edge(d, e, "-|>", label: text(size: 8pt)[_b_ não cumpre $Delta$], label-side: left)
      edge(e, f, "-|>", label: text(size: 8pt)[$epsilon, epsilon, N$])
      edge(f, g, "-|>", label: text(size: 8pt)[_c_ não cumpre $Delta$], label-side: left)
      edge(g, h, "-|>", label: text(size: 8pt)[$epsilon, epsilon, I$])

      edge(b, f_b, "-|>", label: text(size: 8pt)[_a_ cumpre $Delta$])
      edge(d, f_d, "-|>", label: text(size: 8pt)[_b_ cumpre $Delta$])
      edge(f, f_f, "-|>", label: text(size: 8pt)[_c_ cumpre $Delta$])

      let cleaning_transitions = grid(
          columns: (auto),
          align: (right),
          row-gutter: 7pt,
          rows: 4,
          text(size: 10pt)[$a,a bar "D"$],
          text(size: 10pt)[$b,b bar "D"$],
          text(size: 10pt)[$c,c bar "D"$],
          text(size: 10pt)[$\*_\#,* bar "D"$]
      )

      edge(e, "-|>", e, bend: 130deg, loop-angle: 180deg)[#cleaning_transitions]
      edge(c, "-|>", c, bend: 130deg, loop-angle: 180deg)[#cleaning_transitions]
      edge(g, "-|>", g, bend: 130deg, loop-angle: 180deg)[#cleaning_transitions]

      // label
      node(enclose:(<Start>, (2, 5)), stroke: black, inset: 38pt, snap: false)
      node(enclose:((2.6, -0.8), (3, 5.5)), shape: brace.with(dir: right, label: [Módulo $alpha$]))
    }
  )
]

