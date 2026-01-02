#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "../intro/intro.typ": *

=== Módulo $alpha$
O módulo $alpha$ irá analisar se o #target_1 vale para alguma letra em ${a,b,c}$. Caso verifique validade de tal propriedade para a letra-alvo, é eleito o estado final apropriado representativo da decisão apropriada e a computação cessa.

Visto que o automômato encerra processamento assim que é validado $Delta$ para um elemento, extraímos uma capacidade de "curto-circuito", a qual em conjunto a um processamento ordenado dos elementos de $Sigma$ permite zelar pela regra de desempate definida em #link(<1.2>)[1.2]

Portanto, efetuamos essa avaliação para as letra na ordem "a", "b" e, então, "c", implicitamente zelando pela ordem de desempate.

Caso nenhuma letra do alfabeto cumpra com a propriedade alvo de $alpha$, a computação é encaminhada para o módulo $beta$.

Vamos então quebrar o processamento em 3 instâncias de submódulos $psi$, tratando os estados $E_>$ como a decisão de concessão de prioridade para a letra.

Dando ao interior de $alpha$ o formato:

#import fletcher.shapes: house, diamond, circle, trapezium, bracket
#figure(
  caption: $"Raio-x do módulo" alpha$,
  kind: "fluxograma",
  supplement: [Fluxograma]
)[
  #align(center, [
    #diagram(
      node-stroke: 1pt, {
        let (a, b, c, d, e) = (
          (-0.5, 0),
          (0.5, 0),
          (2.5, 0),
          (4.5, 0),
          (6.5, 0),
        )
        let format = trapezium.with(fit: 0.4)
        let row_y = 1
        node(a, [])
        node(b, align(center)[$psi(a, {b, c})$], shape: format)
        node(c, align(center)[$psi(b, {a, c})$], shape: format)
        node(d, align(center)[$psi(c, {a, b})$], shape: format)
        node(e, align(center)[Módulo $beta$], shape: house)
        edge(a, b, "-|>", label: text(size: 8pt)[Início])
        edge(b, c, "-|>", label: text(size: 8pt)[_a_ não cumpre $Delta$])
        edge(c, d, "-|>", label: text(size: 8pt)[_b_ não cumpre $Delta$])
        edge(d, e, "-|>", label: text(size: 8pt)[_c_ não cumpre $Delta$])

        let ext = (0, -2)
        node((0.5, row_y), align(center)[$F_a$], shape: circle, extrude: ext, name: <F_A>)
        node((2.5, row_y), align(center)[$F_b$], shape: circle, extrude: ext, name: <F_B>)
        node((4.5, row_y), align(center)[$F_c$], shape: circle, extrude: ext, name: <F_C>)
        edge(b, (0.5, row_y), "-|>", label: text(size: 8pt)[$psi(a) "parou"$], label-side: right)
        edge(c, (2.5, row_y), "-|>", label: text(size: 8pt)[$psi(b) "parou"$])
        edge(d, (4.5, row_y), "-|>", label: text(size: 8pt)[$psi(c) "parou"$])
        node(enclose: (<F_A>, <F_C>), shape: bracket.with(dir: bottom, length: 110%, size: 2em, sep: 5pt, label: $alpha$))
      }
    )
  ])
]
