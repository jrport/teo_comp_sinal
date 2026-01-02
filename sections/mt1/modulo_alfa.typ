#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "../intro/intro.typ": *
#import fletcher.shapes: house, diamond, circle

=== Módulo $alpha$
O módulo $alpha$ irá analisar se o #target_1 vale para alguma letra em ${a,b,c}$. Caso verifique validade de tal propriedade para a letra-alvo, é eleito o estado final apropriado representativo da decisão apropriada e a computação cessa.

Visto que o automômato encerra processamento assim que é validado $Delta$ para um elemento, extraímos uma capacidade de "curto-circuito", a qual em conjunto a um processamento ordenado dos elementos de $Sigma$ permite zelar pela regra de desempate definida em #link(<1.2>)[1.2]

Portanto, efetuamos essa avaliação para as letra na ordem "a", "b" e, então, "c", implicitamente zelando pela ordem de desempate.

Caso nenhuma letra do alfabeto cumpra com a propriedade alvo de $alpha$, a computação é encaminhada para o módulo $beta$.

Quebramos cada avaliação de uma letra em um submódulo $psi$, tal que:
$ psi(x): "Verifica se x cumpre a propriedade "Delta", caso positivo, o automômato pára em" F_x. $

Dando ao interior de $alpha$ o formato:

#figure(
  caption: $"Formato do Módulo" alpha$,
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
        let format = diamond.with(fit: 0.3)
        let row_y = 1
        node(a, [])
        node(b, align(center)[$psi(a)$], shape: format)
        node(c, align(center)[$psi(b)$], shape: format)
        node(d, align(center)[$psi(c)$], shape: format)
        node(e, align(center)[Módulo $beta$], shape: house)
        edge(a, b, "-|>", label: text(size: 8pt)[Início])
        edge(b, c, "-|>", label: text(size: 8pt)[_a_ não cumpre $Delta$])
        edge(c, d, "-|>", label: text(size: 8pt)[_b_ não cumpre $Delta$])
        edge(d, e, "-|>", label: text(size: 8pt)[_c_ não cumpre $Delta$])

        let ext = (0, -2)
        node((0.5, row_y), align(center)[$F_a$], shape: circle, extrude: ext)
        node((2.5, row_y), align(center)[$F_b$], shape: circle, extrude: ext)
        node((4.5, row_y), align(center)[$F_c$], shape: circle, extrude: ext)
        edge(b, (0.5, row_y), "-|>", label: text(size: 8pt)[$psi(a) "parou"$], label-side: right)
        edge(c, (2.5, row_y), "-|>", label: text(size: 8pt)[$psi(b) "parou"$])
        edge(d, (4.5, row_y), "-|>", label: text(size: 8pt)[$psi(c) "parou"$])
      }
    )
  ])
]

#pagebreak()
=== Submódulo $psi$

Como já definimos, $psi$ deve verificar se vale para algum $x$:

$ #propriedade_i "onde" x, y, z in {a, b, c} " e " x != y != z $

Para tal, temos que comparar a *cardinalidade* de $x$ com a de $y$ e $z$.

Assim, vamos utilizar da nossa função de contagem $psi(x, L)$, sendo $L = {y, z}$.

Onde $E_>$ será agora $F_x$ simbolizando a parada total da MT1 na decisão de priorizar a avenida $x$.

Enquanto $E_<=$ será:
- $E_"in"$ do submódulo $psi$ seguinte, caso $x!=c$,;
- o estado de entrada do módulo $beta$, caso $x=c$,;

Dado a definição de $x$ e $L$, vamos agora para o cálculo da complexidade temporal associado a $alpha$.
