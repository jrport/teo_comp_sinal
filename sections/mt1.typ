#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "introduction.typ": *
#import fletcher.shapes: house, diamond, circle

= Máquinas de Turing
Para fins de tratar a complexidade do problema de maneira didática, facilitando a argumentação e desenvolvimento, vamos abstrair porções de MT's (Máquinas de Turing) em módulos.

Pela definição de MT vinda do Newton (2006) temos
$ "MT" = (E, Sigma, Γ, delta, i, F) $
$E$: Conjunto finito de estados \
$Sigma$: Alfabeto de entrada \
$Γ$: Alfabeto da fita \
$delta$: Funções de transição \
$i$: Estado inicial \
$F$: Conjunto de estados finais

A partir dela, definimos o módulo $MM$ de MT como:
$ MM = (E_sha, Sigma, Γ, delta_sha, e_("entrada"), E_("saída")) $
Onde, \
$E_sha$: Subconjunto dos estados em $E$. \
$delta_sha$: Subconjunto de transições de $delta$ que atuem sobre os estados definidos em $E_sha$. \
$e_("entrada")$: Um estado inicial em $E_sha$, denota o ínicio do módulo. Vamos nos referir a ele como estado de entrada. \
$e_("saída")$: Um conjunto de estados finais pertencentes a $E_sha$, representam o fim da computação do módulo. Chamaremos eles de estados de saída. \

Importante notar que não necessariamente $e_("saída") subset F$. Ou seja, o fim da computação de $MM$ não é necessário e suficiente para parada da MT.

No decorrer desse texto usaremos a noção de um "submódulo". Tal estrutura será útil a nível didático e deve ter seu conceito compreendido como análogo ao de um módulo, só que ao invês de ser definido em função de toda a MT, ele tem seus elementos delimitados por um $MM$.

#pagebreak()

#let mt1 = $"MT"_1$
== Máquina de uma única fita (#mt1)
Nossa máquina de uma fita só, ou #mt1, é definida como:

$ "MT"_1 = (E, Sigma, Γ, delta, i, F) $
Tal que, \
$Sigma = {a, b, c}$ \
$Γ = {a, b, c, a_a, a_b, a_c, b_a, b_b, b_c, c_a, c_b, c_c, <, epsilon }$ \
$F = {F_a, F_b, F_c}$

Cada estado final representa a decisão de conceder prioridade à uma avenida no cruzamento, onde:
$ x in Sigma bar F_x: "Sistema prioriza avenida x" $

As transições $delta$, estados $E$, $F$ e $i$ serão definidos em representações gráficas mais a frente.

#mt1 tem dois módulos principais: $alpha$ e $beta$.

=== Módulos e submódulos
O módulo $alpha$ será responsável por verificar se a #link(<1>)[condição 1] do enunciado vale para alguma letra de $Sigma$ através do #target_1.

Caso nenhum estado final seja alcançado dentro de $alpha$, o automômato recorrerá ao módulo B, onde avaliará a #link(<2>)[condição 2] do problema. Verificando qual letra tem a maior cardinalidade na entrada.

A macroarquitetura da máquina tem o formato:

#figure(
  caption: "Arquitetura do automômato",
  kind: "diagrama",
  supplement: [Diagrama]
)[
  #align(center, [
    #diagram(
      node-stroke: 1pt, {
        let (a, b, c) = ((-0.5, 0), (0.5, 0), (3.5, 0))

        node(a, [])
        node(b, align(center)[Módulo $alpha$], shape: house)
        node(c, align(center)[Módulo $beta$], shape: house)

        edge(a, b, "-|>", label: text(size: 8pt)[Início])

        edge(
          b, c, "-|>",
          label: [#align(center, [#text(size: 10pt)[Se o módulo $alpha$\ não parar]])]
        )


        let row_y = 2
        let xA = 0.5
        let ext = (0, -2)

        let bA = (xA - 1, row_y)
        let bB = (xA,     row_y)
        let bC = (xA + 1, row_y)

        node(bA, align(center)[$F_a$], extrude: ext)
        node(bB, align(center)[$F_b$], extrude: ext)
        node(bC, align(center)[$F_c$], extrude: ext)

        edge(b, bA, "-|>")
        edge(b, bB, "-|>")
        edge(b, bC, "-|>")

        let xB = 3.5

        let cA = (xB - 1, row_y)
        let cB = (xB,     row_y)
        let cC = (xB + 1, row_y)

        node(cA, align(center)[$F_a$], extrude: ext)
        node(cB, align(center)[$F_b$], extrude: ext)
        node(cC, align(center)[$F_c$], extrude: ext)

        edge(c, cA, "-|>")
        edge(c, cB, "-|>")
        edge(c, cC, "-|>")
      }
    )
  ])
]

#pagebreak()

=== Módulo $alpha$
O módulo $alpha$ irá analisar se o #target_1 vale para alguma letra em ${a,b,c}$. Caso verifique validade de tal propriedade para a letra-alvo, é eleito o estado final apropriado representativo de uma decisão quanto a avenida prioritária para a sinaleira e a computação cessa.

Visto que o automômato encerra processamento assim que é validado $Delta$ para um elemento alvo, extraímos uma capacidade de "curto-circuito", a qual em conjunto a um processamento sequencial ordenado dos elementos de $Sigma$ permite zelar pela regra de desempate definida por #link(<1.2>)[1.2]

Portanto, efetuamos essa avaliação para as letra na ordem "a", "b" e, então, "c".

Caso nenhuma letra do alfabeto cumpra com uma propriedade alvo do módulo, a computação é encaminhada para o módulo $beta$.

Dessa forma, abstraímos um submódulo $psi$ tal que:
$ psi(x): "Computa se x cumpre a propriedade "Delta", caso positivo, o automômato pára em" F_x $

Então avaliaremos, em ordem, $psi(a)$, $psi(b)$, $psi(c)$, de acordo a imagem:

#figure(
  caption: "Formato do Módulo A",
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

=== Submódulo $psi$

Definimos de forma genérica o submódulo $psi$, dado que $x, y in Sigma$ e $x != y$, $psi(x)$ será:

#import fletcher.shapes: circle
#align(center)[
  #set text(size: 9pt)
  #block[
    #figure(
      caption: $"Função" psi$,
      kind: "Submódulo",
      supplement: [Submódulo]
    )[
        #diagram(
          node-stroke: .1em,
          {
            let (a, b, c, d, e, f) = (
              (-0.5, 0),
              (0.5, 0),
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
            )
            let format = circle
            let row_y = 1
            node(a, [])
            edge(a, b, "=>", label: "Início")
            node(b, align(center)[$E_1$], shape: format)
            edge(b, "-|>", bend: -130deg, loop-angle: 270deg)[
              $\*,\* bar "E"$
            ]
            node(c, align(center)[$E_2$], shape: format)
            edge(b, "-|>", c)[<,<|D]
            node(d, align(center)[$F_x$], shape: format, extrude: (0, -2))
            edge(c, e, "-|>", label-side: left)[
              $x, x_x bar "E"$
            ]
            edge(e, "-|>", e, bend: -130deg, loop-angle: 170deg)[
              $\*,\* bar "E"$
            ]
            node(e, align(center)[$E_4$], shape: format)
            edge(e, f, "-|>", label-side: left)[
              $<, < bar "D"$
            ]
            node(f, align(center)[$E_5$], shape: format)
            edge(f, "-|>", f, bend: -130deg, loop-angle: 170deg)[
              #grid(
                columns: (auto),
                align: (right),
                row-gutter: 7pt,
                rows: 2,
                [$x,x bar "D"$],
                [$\*_x,\*_x bar "D"$]
              )
            ]
            edge(f, b, "-|>", label-side: left)[$y,y_x bar "E"$]
            edge(f, d, "-|>")[$lambda,lambda bar "I"$]
          }
        )
    ]
  ]
]
#pagebreak()

Vamos quebrar as transições em algoritmo a partir do qual verificaremos a computação das propriedades desejadas, tal que os passos são:

Vamos quebrar o fluxo das transições num passo-a-passo para facilitar a verificação da computação das propriedades desejadas. As etapas seguem:

#block[
  #set enum(numbering: (i) => "Passo " + str(i) + " -")
+ Lê cada letra de $w$ até encontrar uma ocorrência de $x$;
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre $x$:
      - x não cumpre #link(<C>)[a propriedade C], escapamos para $E_("out")$ e cessamos computação.
    + Encontrou um $x$:
      - Sobreescreveremos o $x$ na fita com $x_x$ e seguimos para o passo 2.
  ]

+ Retornamos ao início da fita;
+ Buscamos uma letra $y$ tal que $y in.not {x, x_x}$;
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre:
      - _x_ cumpre com a #link(<C>)[a propriedade C] e para no estado final $F_x$ e cessamos computação.
    + Caso encontre:
      - Sobreescreveremos o _y_ na fita com $y_x$ e seguimos para o passo 4.
  ]

+ Retornamos ao início da fita e voltamos ao passo 1.
]

Vamos para a prova de que o algoritmo descrito verifica #link(<C>)[C].

De antemão é relevante notar que o _script_ é um _loop_ que se repete até parar em 1-a) ou 3-a).

Tomamos por certeza a eventual parada, em razão da palavra de entrada ser finita e que para que cesse o processamento é necessário e suficiente que sejam esgotados elementos distintos ou iguais a _x_.

Uma vez que sempre retornamos ao início da fita após encontrar uma elemento satisfaça uma dessas condições, e que marcamos elementos após encontra-los, temos por óbvio a garantia de que haverá parada.

Vamos agora para demonstração de como esse processo também computa a validade de #link(<C>)[C] para _x_.

#pagebreak()
Primeiro estabeleçamos que,

$ & n in bb(N) | x, gamma_n in {a, b, c} | w "é uma palavra." | w = gamma_0 * ... * gamma_n $

Por meio do _loop_ vamos gradativamente consumindo as letras de _w_ e produzindo dois conjuntos disjuntos.

Os passos 1, 1.2, e 2 e 4 constroem $X$:
$ X &= {forall gamma_i in w | gamma_i = x } $
Enquanto 3, 3.2 e 4 definem $overline(X)$:
$ overline(X) &= {forall gamma_i in w | gamma_i != x } $
Basta que verifiquemos:
$ |X| > |overline(X)| $

// Ele terá por objetivo verificar se #link(<C>)[a propriedade C] vale para uma letra do alfabeto.
//
// $ x, y, z in {a, b, c} "sendo" x != y and y != z and x != z \
// "Tal que" #propriedade_i $

#pagebreak()


== Máquina na íntegra
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Análise de complexidade
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
== Exemplos
ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis ipsi literis
