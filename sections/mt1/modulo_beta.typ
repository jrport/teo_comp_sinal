=== Módulo $beta$
O módulo $beta$ deve avaliar a condição de desempate, a qual trataremos de $Omega$ e a ordem de prioridade A > B > C.

Afirmamos que $x$ cumpre $Omega$ quando:
$ x, y, z = {a, b, c}, x != y and y != z bar max(gamma_(x)(w), gamma_(y)(w), gamma_(z)(w)) = gamma_(x)(w) $

Ou seja,
$ gamma_(x)(w) > gamma_(y)(w) and gamma_(x)(w) > gamma_(z)(w) $

Entranto, na condição de haver um empate, onde dois símbolos possuam a mesma cardinalidade, o desempate será definido pela ordem de prioridade.

Nosso módulo então fará o seguinte fluxo:

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: trapezium
#figure(
  caption: $"Raio-x do módulo" alpha$,
  kind: "fluxograma",
  supplement: [Fluxograma],
)[
  #diagram(
    node-stroke: 1pt,
    {
      let (s, c_x_b, c_x_a, a_x_c) = ((0, 0), (0, 1), (1, 1), (2, 2))
      // let (fa, b_x_a, )

      edge(s, c_x_b, "-|>")[Início]
      node(
        c_x_b,
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 7pt,
          text(size: 10pt)[Testa se],
          text(size: 10pt)[$gamma_(c)(w) > gamma_(b)(w)$],
        )],
        shape: trapezium,
      )

      edge(c_x_b, c_x_a, label: text(size: 10pt)[Sim])
      node(
        c_x_a,
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 7pt,
          text(size: 10pt)[Testa se],
          text(size: 10pt)[$gamma_(c)(w) > gamma_(a)(w)$],
        )],
        shape: trapezium,
      )

      // senão vamos pra a
      edge(c_x_a, a_x_c, label: text(size: 10pt)[Sim])
      node(
        a_x_c,
        align(center)[#grid(
          columns: auto,
          rows: 2,
          row-gutter: 7pt,
          text(size: 10pt)[Testa se],
          text(size: 10pt)[$gamma_(a)(w) > gamma_(c)(w)$],
        )],
        shape: trapezium,
      )
    },
  )
]
