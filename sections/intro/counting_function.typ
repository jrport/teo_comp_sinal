#import "../intro/intro.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

=== Submódulo $psi$ (ou "função de contagem")
A peça central de $"MT1"$ é o súbmódulo $psi$, o qual também chamaremos de função de contagem, responsável por comparar a cardinalidade de diferentes conjuntos de símbolos em uma dada palavra.

Definindo formalmente,
$ L subset Gamma $
$ X_w, L_w "são os conjuntos de ocorrências de" L, x "em" w $
$ psi(x, L): "Avalia a natureza do produto cartesiano" X_w times L_w $

Verificando a ocorrẽncia de bijeção, injeção e/ou sobrejeção abstraímos sentidos de acordo ao definido pela Teoria de Conjuntos, em caso de:
+ bijeção, intuimos que $gamma_(x)(w) = gamma_(y)(w) + gamma_(z)(w)$;
+ injeção, mas não sobrejeção, $gamma_(x)(w) < gamma_(y)(w) + gamma_(z)(w)$;
+ sobrejeção, mas não injeção, $gamma_(x)(w) > gamma_(y)(w) + gamma_(z)(w)$

Como as regras de negócio estipuladas ao sistema de acordo ao enunciado da questão preocupam-se apenas com o que já definimos em $Delta$, o súbmódulo $psi$ foca-se no caso 2).

A título de demonstração, tratemos $L = {y}$, $psi(x, L)$ assume o formato:

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
            node(g, align(center)[$E_<=$], shape: format)
            edge(c, "-|>", c, bend: -130deg, loop-angle: 260deg)[
              $*_\#,*_\# bar "D"\
              y,y bar "D"$
            ]
            edge(b, "-|>", c)[<,<|D]
            edge(c, "-|>", g)[$epsilon, epsilon bar D$]
            node(d, align(center)[$E_>$], shape: format)
            edge(c, e, "-|>", label-side: left)[$x, x_\# bar "E"$]
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
                [$\*_\#,\*_\# bar "D"$]
              )
            ]
            edge(f, b, "-|>", label-side: left)[$y,y_\# bar "E"$]
            edge(f, d, "-|>")[$lambda,lambda bar "I"$]
          }
        )
    ]
  ]
]

Os dois estados de saída ou parada desse submódulo serão $E_<$ e $E_>=$, os quais semânticamente representam:
- $E_<$: $X_w < L_w$
- $E_>=$: $X_w >= L_w$

Naturalmente, em caso de $|L| > 1$, as transições que contenham símbolos de $L$ na representação acima, seriam múltiplas mas ainda de formato análogo, apenas tendo uma correspondente para cada símbolo de $L$.

Descrevendo de forma direta, a função de contagem que definimos tem usa de um _loop_ (estrutura de repetição) e vai efetivamente *mapeando* cada ocorrência de $x$ com ocorrências dos símbolos em $L$, nunca repetindo items envolvidos entre pares.

Para isso, é feita uma marcação no formato:
$ "Sendo" x in Gamma | "Marcamos um" x "qualquer o substituindo pelo respectivo" x_\# $

Essa marcação sinaliza que esse símbolo deve ser ignorado nas iterações seguintes do loop.

Vamos então destrinchar o funcionamento de $psi$ transição a transição para verificarmos formalmente a computação das seguintes propriedades:
$ "Parar em" E_> <=> #propriedade_i $
$ "Sair por" E_<= <=> gamma_(x)(w) <= gamma_(y)(w) + gamma_(z)(w) $

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
  + Caso não ache um $x$, escapamos para $E_<=$.
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
    + Caso não encontre, pára em $E_>$.
    + Caso encontre, sobreescreveremos o _y_ na fita com $y_x$ e retornamos ao passo 1.
  ]
]


Um aspecto relevante é que trata-se um _loop_ com apenas duas possíveis interrupções: as etapas 2.b) e 4.a) do passo-a-passo.

Agora faremos uma breve verificação formal de que o algoritmo abstraído na máquina constrói as propriedades almejadas.

Dado que,
$ 𝑛, 𝑖 in N $
$ 𝑥, k_n in {𝑎, 𝑏, 𝑐} $
$ 𝑤 = k_0 ∗ … ∗ k_n $

Os passos 2.a) e 4.b) marcam os elementos substituindo-os por $x_\#$ e $y_\#$, respectivamente construindo:
$ X_w = { j | forall j in N  "tal que" 0 <= j <= n " e" k_j = x } "(Ocorrências de X)" $
$ overline(X)_w = { j | forall j in N  "tal que" 0 <= j <= n " e" k_j != x } "(Ocorrências de não-X)" $

Como fazemos uma substituição 2.a), rebobinamos, fazemos uma substituição em 4.b) e reiniciamos o loop. Estamos sempre compondo $X$ e $overline(X)$, um por um, mantendo igualdade quanto a cardinalidade dos conjuntos. Incrementando primeiro $X$ e então $overline(X)$.

Dessa forma, independente da iteração do loop, no instante precedendo a execução do passo 2.a), temos que $|X_w|$ = $|overline(X)_w| + 1$. 
Até que executarmos 4.b), retornando a igualdade $|X_w| = |overline(X)_w|$.

Ou seja, somente nos pontos de interrupção do loop ocorre disruptura permanente dessas igualdades.

Em 2.b), não encontramos mais $x$ e escapamos para $E_<=$, como interrompemos o processamento do módulo, não buscamos mais $y$, mas temos certeza da cardinalidade de $x$, naquele instante alcançamos que $|X| = |overline(X)$. Entretanto, como não não buscamos mais $y$, podemos afirmar de maneira forte que $gamma(x)_w <= gamma(y)_w + gamma(z)_w$ visto que podem ainda haver mais ocorrências de $y$.

Já na parada em 4.a), temos do passo 2.a) que $|X_w|$ = $|overline(X)_w| + 1$ e interrompemos o processamento em $E_>$. Neste caso, $gamma(x)_w >= gamma(y)_w + 1$, o que equivale a $gamma(x)_w > gamma(y)_w$.
