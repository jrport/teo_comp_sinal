=== Módulo $beta$
O módulo $beta$ deve avaliar a condição de desempate, a qual trataremos de $Omega$ e a ordem de prioridade A > B > C.

Afirmamos que $x$ cumpre $Omega$ quando:
$ x, y, z = {a, b, c}, x != y and y != z bar max(gamma_(x)(w), gamma_(y)(w), gamma_(z)(w)) = gamma_(x)(w) $

Ou seja,
$ gamma_(x)(w) > gamma_(y)(w) and gamma_(x)(w) > gamma_(z)(w) $

Entranto, na condição de haver um empate, onde dois símbolos possuam a mesma cardinalidade, o desempate será definido pela ordem de prioridade.

Para determinar e resolver casos de empate com maior facilidade, vamos fazer uma pequena modificação em $psi$, para que ao invês de termos como possíveis estados de saída $E_>$ e $E_<=$, tenhamos agora $E_>=$, $E_<$ para satisfazer a estrutura que propomos aqui.
A essa nova versão de $psi$ daremos o nome $psi'$.

Para que então possamos estrutura o módulo $beta$ como um torneio de entre as três letras de ${a, b, c}$, onde cada confronto compara as cardinalidades de dois símbolos e decide o próximo embate. O formato definido segue:

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: circle, hexagon, pill

#figure(
  caption: $"Ordem dos duelos do Torneio" beta$,
  kind: "fluxograma",
  supplement: [Fluxograma],
)[
  #diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    {
      let inicio = (0, 0)
      let duelo1 = (0, 1)
      let limp1 = (-1, 2)
      let limp2 = (1, 2)
      let duelo2_esq = (-1.5, 3)
      let duelo2_dir = (1.5, 3)
      let vencedor_a = (-1.5, 4)
      let vencedor_c = (0, 4)
      let vencedor_b = (1.5, 4)

      edge(inicio, duelo1, "->")[Início]
      node(
        duelo1,
        align(center)[
          #text(size: 11pt)[$psi'(a, b)$]
        ],
        shape: hexagon,
      )

      edge(duelo1, limp1, "-|>", label: text(size: 10pt)[$=<$], label-side: left, label-pos: 0.3)
      edge(limp1, duelo2_esq, "-|>", label-side: right, label-pos: 0.3)
      edge(duelo1, limp2, "-|>", label: text(size: 10pt)[$>$], label-side: right, label-pos: 0.3)
      edge(limp2, duelo2_dir, "-|>")
      
      node(
        limp1,
        text(size: 9pt)[Estado de limpeza],
        shape: pill,
      )
      node(
        limp2,
        text(size: 9pt)[Estado de limpeza],
        shape: pill,
      )

      node(
        duelo2_esq,
        align(center)[
          #text(size: 11pt)[$psi'(a, c)$]
        ],
        shape: hexagon,
      )

      node(
        duelo2_dir,
        align(center)[
          #text(size: 11pt)[$psi'(b, c)$]
        ],
        shape: hexagon,
      )

      edge(duelo2_esq, vencedor_a, "-|>", label: text(size: 10pt)[$>=$], label-side: left, label-pos: 0.4)
      edge(duelo2_esq, vencedor_c, "-|>", label: text(size: 10pt)[$<$], label-side: right, label-pos: 0.4)

      edge(duelo2_dir, vencedor_c, "-|>", label: text(size: 10pt)[$<$], label-side: left, label-pos: 0.4)
      edge(duelo2_dir, vencedor_b, "-|>", label: text(size: 10pt)[$>=$], label-side: right, label-pos: 0.4)

      node(
        vencedor_a,
        align(center)[#text(size: 12pt)[A vence]],
        shape: circle,
        fill: rgb("#c8e6c9"),
        extrude: (0, -2),
      )

      node(
        vencedor_c,
        align(center)[#text(size: 12pt)[C vence]],
        extrude: (0, -2),
        shape: circle,
        fill: rgb("#ffccbc"),
      )

      node(
        vencedor_b,
        align(center)[#text(size: 12pt)[B vence]],
        extrude: (0, -2),
        shape: circle,
        fill: rgb("#ffe0b2"),
      )
    },
  )
]
