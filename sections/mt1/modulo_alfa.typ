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

Para tal, devemos comparar a *cardinalidade* de $x$ com a de $y$ e $z$.

Com esse objetivo, nosso automato irá, efetivamente, *mapear* cada ocorrência de $x$ com uma de $y$ e de $z$.

A natureza dessa correspondência caracteriza diretamente a relação entre as cardinalidades envolvidas.

Considere $X_w$ como o conjunto de aparições de $x$ em $w$, e $Y_w$ e $Z_w$ como conjuntos análogos para demais letras. Formalizando:

$ "w é palavra", thick |w| = n", e" w = (a_1, ..., a_n) "onde" a_i in Sigma = {a, b, c} $
$ X_w = { i | a_i = x}, thick Y_w = { i | a_i = y}, thick Z_w = { i | a_i = z} $

Teremos que a computação de $Delta$ é, essencialmente, a contagem dos conjuntos $X_w$ e $Y_w$ $union$ $Z_w$ -- chamaremos essa união de $"YZ"_w$

Com esse fim, $psi(x)$ buscará formar pares únicos de $x$ com $y$'s e $z$'s, de maneira que não sejam repetidos os elementos envolvidos em cada par já formado. De maneira formal:
$ psi(x): X_w -> "YZ"_w $
$ forall i,j in X_w, #h(0.5em) psi(i) = psi(j) => i = j $

Assim, de acordo ao definido pela teoria dos Conjuntos, caso verifiquemos:
+ bijeção, intuimos que $gamma_(x)(w) = gamma_(y)(w) + gamma_(z)(w)$;
+ injeção, mas não sobrejeção, $gamma_(x)(w) < gamma_(y)(w) + gamma_(z)(w)$;
+ sobrejeção, mas não injeção, $gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w)$

Portanto, basta que nossa $"MT"$ compute essa função de pareamento para que seja verificada a validade de $Delta$.

#pagebreak()

Fixo que $x, y in Sigma$ onde $x != y$, o submódulo $psi(x)$ terá o formato:

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
            let (a, b, c, d, e, f, g) = (
              (-0.5, 0),
              (0.5, 0),
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
              (6.5, 0)
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
            node(g, align(center)[$E_"out"$], shape: format)
            edge(c, "-|>", c, bend: -130deg, loop-angle: 260deg)[
              $*_\x,*_\x bar "D"\
              y,y bar "D"$
            ]
            edge(b, "-|>", c)[<,<|D]
            edge(c, "-|>", g)[$epsilon, epsilon bar D$]
            node(d, align(center)[$F_x$], shape: format, extrude: (0, -2))
            edge(c, e, "-|>", label-side: left)[
              #grid(
                columns: (auto),
                align: (right),
                row-gutter: 7pt,
                rows: 2,
                [$x, x_x bar "E"$],
                [$x_y, x_x bar "E"$]
              )
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

Onde $F_x$ simboliza a parada total da MT1 na decisão de priorizar a avenida $x$.

Enquanto $E_"out"$ será:
- $E_"in"$ do submódulo $psi$ seguinte, caso $x!=c$,;
- o estado de entrada do módulo $beta$, caso $x=c$,;

Ou seja, $psi(x)$ deve
$ "Parar em" F_x <=> #propriedade_i $
$ "Sair por" E_"out" <=> gamma_(x)(w) <= gamma_(y)(w) + gamma_(z)(w) $

#pagebreak()

Vamos então destrinchar cada estado da máquina e suas transições associadas para verificar a computação dessas propriedades e também calcular a complexidade assintôtica apresentada.

#block[
  #set enum(numbering: (i) => "Passo " + str(i) + " -")
+ Rebobina ao início da fita.

#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
              let (a, b, c) = (
                (-0.5, 0),
                (0.5, 0),
                (4.0, 0),
              )
              edge(a, b, "=>", label: "Aqui")
              node(b, align(center)[$E_1$], shape: circle)
              edge(b, "-|>", bend: -130deg, loop-angle: 270deg, dash: "dotted")[
                $\*,\* bar "E"$
              ]
              edge(b, "-|>", c, dash: "dotted")[<,<|D]
              node(c, align(center)[$E_2$], shape: circle)
    }
  )
]

#enum.item(2)[Avança pela fita passando por todos _y_ e $x_x$ -- que são os $x$'s já pareados -- até encontrar um $x$ ou o fim da fita.]
#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
            let (c, d, e, f, g) = (
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
              (6.5, 0)
            )
            let i = (3, 0)
            let format = circle
            let row_y = 1
            edge(i, c, "=>", label: "Aqui")
            node(c, align(center)[$E_2$], shape: format)
            edge(c, "-|>", c, bend: -130deg, loop-angle: 260deg, dash: "dotted")[
              $*_\x,*_\x bar "D"\
              y,y bar "D"$
            ]
            edge(c, e, "-|>", label-side: left, dash: "dotted")[
              $x, x_x bar "E"$
            ]
            node(e, align(center)[$E_4$], shape: format)
            node(g, align(center)[$E_"out"$], shape: format)
            edge(c, "-|>", g, dash: "dotted")[$epsilon, epsilon bar D$]
    }
  )
]
#block[
  #set enum(numbering: "a)")
  + Caso ache um $x$ ou $x_y$, o sobreescreveremos por $x_x$ e seguimos para o passo 3.
  + Caso não ache um $x$, escapamos para $E_("out")$.
]

#enum.item(3)[Rebobina pro início da fita;]
#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
            let (a, b, c, d, e, f, g) = (
              (-0.5, 0),
              (0.5, 0),
              (4.0, 0),
              (0.5, 4),
              (4.0, 2),
              (4.0, 4),
              (6.5, 0)
            )
            edge((3.0, 2), e, "=>", label: "Aqui")
            node(e, align(center)[$E_4$], shape: circle)
            edge(e, "-|>", e, bend: -130deg, loop-angle: 170deg, dash: "dotted")[
              $\*,\* bar "E"$
            ]
            edge(e, f, "-|>", label-side: left, dash: "dotted")[
              $<, < bar "D"$
            ]
            node(f, align(center)[$E_5$], shape: circle)
    }
  )
]


#enum.item(4)[Avança pela fita buscando um $y$ tal que $y in.not {x, x_x}$;]
#align(center)[
  #set text(size: 9pt)
  #diagram(
    node-stroke: .1em,
    {
            let (a, b, c, d, e, f, g) = (
              (-0.5, 0),
              (0.5, 0),
              (2.0, 0),
              (0.5, 2),
              (2.0, 2),
              (2.0, 2),
              (6.5, 0)
            )
            node(b, align(center)[$E_1$], shape: circle)
            node(f, align(center)[$E_5$], shape: circle)
            node(d, align(center)[$F_x$], shape: circle, extrude: (0, -2))
            edge(f, "-|>", f, bend: -130deg, loop-angle: 170deg, dash: "dotted")[
              #grid(
                columns: (auto),
                align: (right),
                row-gutter: 7pt,
                rows: 2,
                [$x,x bar "D"$],
                [$\*_x,\*_x bar "D"$]
              )
            ]
            edge(f, b, "-|>", label-side: right, dash: "dotted")[$y,y_x bar "E"$]
            edge(f, d, "-|>", label-side: left, dash: "dotted")[$lambda,lambda bar "I"$]
    }
  )
]
  #block[
    #set enum(numbering: "a)")
    + Caso não encontre, sabemos que _x_ cumpre com a #link(<C>)[a propriedade C], pára no estado final $F_x$ e cessamos computação.
    + Caso encontre, sobreescreveremos o _y_ na fita com $y_x$ e retornamos ao passo 1.
  ]
]


Um aspecto relevante é que esse módulo é um _loop_ com duas interrupções possíveis: as etapas 2.b) e 4.a) do passo-a-passo.

Agora faremos uma breve verificação formal de que o algoritmo abstraído na máquina constrói as propriedades almejadas.

Dado que,
$ 𝑛, 𝑖 in N $
$ 𝑥, k_n in {𝑎, 𝑏, 𝑐} $
$ 𝑤 = k_0 ∗ … ∗ k_n $

Os passos 2.a) e 4.b) marcam os elementos de forma $x_x$ e $y_x$, respectivamente, construindo os conjuntos:
$ X_w = { j | forall j in N  "tal que" 0 <= j <= n " e" k_j = x } $
$ overline(X)_w = { j | forall j in N  "tal que" 0 <= j <= n " e" k_j != x } $

Como é feita uma substituição de elemento por vez, os conjuntos são proceduralmente compostos em paralelo. Dessa forma, independente da iteração do loop, em 2.a), $|X_w|$ = $|overline(X)_w| + 1$. Até que em 4.b), é encontrado mais um $y$ e $|X_w| = |overline(X)_w|$.

Somente em uma das interrupções, 2.b) ou 4.a), ocorre um disruptura dessas igualdades.

Em 2.b), não encontramos mais $x$ e escapamos para $E_"out"$, como interrompemos o processamento do módulo, não verificamos se existem mais $y$, mas temos certeza da cardinalidade de $x$. Obtendo $|overline(X)_w| = |X_w|$ e, portanto, $gamma(x)_w = gamma(y)_w + gamma(z)_w$, entretanto, como não não buscamos mais $y$, podemos afirmar de maneira mais forte que $gamma(x)_w <= gamma(y)_w + gamma(z)_w$.

Já na parada em 4.a), temos do passo 2.a) que $|X_w|$ = $|overline(X)_w| + 1$ e interrompemos o processamento em $F_x$. Neste caso, $gamma(x)_w >= gamma(y)_w + gamma(z)_w + 1$, o que equivale a $gamma(x)_w > gamma(y)_w + gamma(z)_w$. Neste caso, computamos com sucesso que vale a propriedade $Delta$ no momento da parada em $F_x$.

#pagebreak()

Vamos agora para a análise da complexidade temporal. Vamos abstrair um custo de 1#emph[u.a.] (unidade arbitrária) por transição efetuada.

Por convenção, vamos calcular somente o custo associado ao pior caso. Vamos considerar os dois possíveis casos de parada e estabelecer a pior estrutura possível para uma palavra na dada etapa.

Como definimos previamente,
$ "Parar em" F_x <=> #propriedade_i $
e,
$ "Saída para" E_"out" <=> gamma(x)_w <= gamma(y)_w + gamma(z)_w $

Dada uma entrada computável, $psi(x)$ tem dois possíveis cenários, o de parada ao alcançar $F_x$ e fuga para $E_"out"$.

- Parada em $F_x$

Importante notar que o único ponto de interrupção do _loop_ é em 4.b), assim teremos $j$ repetições, onde $j = gamma_(y)_w + gamma_(z)_w$.

-- Passo 1: O custo de rebobinar ao início da fita é igual a distância da posição atual dela até ao delimitador à esquerda. Dessa forma, uma palavra de formato $w = 

-- Passo 2: Temos por hipótese que $gamma(x)_w > gamma(y)_w + gamma(z)_w$, dessa forma caímos em 2.a). Como percorremos símbolo a símbolo até encontrarmos o próximo $x$,
o pior formato para $w$ é aquele com todos os $x$'s como sufixo, $w = (y*z)^k * x^j$, forçando em qualquer iteração do _loop_ pelo menos um custo $k$.

Um outro ponto a se considerar, é que como o único ponto de interrupção do _loop_ é em 4.b), teremos $gamma_(y)_w + gamma_(z)_w$ repetições. E conforme marcamos os $x$ em $x_x$, na iteração $i$, a palavra assume o formato

$ w = (y_x*z_x)^i * (y*z)^(k-i) * x_x^i * x^(j-i) $

Dessa forma, definimos de maneira exata o custo em uma iteração qualquer como $quad$ $k + i + 1$.

- Saída para $E_"out"$

#pagebreak()
