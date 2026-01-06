#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#show link: it => {
  set text(fill: rgb("#6a41ff"))
  underline(it)
}

#set heading(numbering: "1.")
#set page(
  margin: 1in,
  numbering: "1",
)
#set par(
  justify: true,
)
#set text(
  font: "New Computer Modern",
  size: 12pt,
)

#align(center)[
  #v(16.5em)

  #title[Controle de Tráfego Urbano Inteligente]

  #v(1em)

  #text(14pt)[
    Trabalho Final do Curso de Teoria da Computação
  ]

  #v(2em)

  #align(center)[
    João Roberto \
    Caio Mello \
    Jonas Oliveira \
    Leandro Barbosa \
    Vinicius Caires \
  ]

  #v(3em)

  #align(bottom)[
    #text(12pt)[
      #text(weight: "bold")[Período Letivo] \
      2025.2
    ]
  ]
]

#pagebreak()
#outline(title: "Índice")

#include "sections/intro/main.typ"
#include "sections/mt1/main.typ"
#include "sections/mt2/main.typ"

= Considerações finais

Nesse projeto, pudemos explorar as limitações e potencialidades das Máquinas de Turing como abstrações computacionais,
da resolução de problemas lógico-matemáticos de natureza elementar, no percurso percebemos a robustez do módulo de Turing, à
medida que fomos capazes de arquitetar soluções para questões como contagem e comparação de cardinalidade, além de emular estruturas
típicas de linguagens de programação, como mecanismos de tomada de decisão e enlaces de repetição.

Por esse caminho, também nos deparamos com as frustrações e vantagens inerentes a cada variante das MTs, não só no que tange a complexidade temporal, como também
a clareza e concisão das soluções propostas.

Inicialmente, a implementação com uma única fita logo mostrou uma complicação aparante: a impossibilidade de estruturar diferentes operações em paralelo, 
forçando-nos a repetir diversas leituras, escritas e até etapas de higienização sobre a fita. Durante esse processo, optamos por uma abordagem modular, e 
tomamos decisões que não necessariamente eram as mais eficientes, mas que facilitavam a compreensão e a organização do código. Esse conjunto de circunstâncias culminou
numa complexidade quadrática, o que reforçou a percepção de que a MT1, apesar de ser um modelo fundamental, pode não ser a mais adequada para todos os tipos de problemas.

Em seguida, o mesmo problema foi reespecificado
no modelo de Máquina de Turing determinística de múltiplas fitas (MT2).
A separação física das informações em uma fita de entrada
e fitas auxiliares independentes
possibilitou a execução das principais operações
— leitura, contagem, cálculo da metade e comparações —
por meio de varreduras lineares e não destrutivas.
Como consequência, todas as etapas do processamento da MT2
foram demonstradas como executáveis em tempo linear,
resultando em uma complexidade total de $O(n)$, sem a necessidade releituras ou limpezas.

A comparação entre MT1 e MT2 expõe de forma clara
o ganho assintótico proporcionado pelo modelo multifitas.
Embora ambos os modelos sejam equivalentes
em termos de poder computacional e linguagens reconhecíveis,
a MT2 apresenta eficiência significativamente superior
para o problema proposto,
reforçando a importância da escolha adequada do modelo de computação
na análise de algoritmos.

Além da análise temporal,
o trabalho também demonstrou que o número de estados da MT2
é constante e independente do tamanho da entrada,
o que reforça a viabilidade estrutural da solução proposta.
Os exemplos passo a passo apresentados
complementam a descrição formal,
tornando explícita a evolução do conteúdo das fitas
e o processo de decisão em diferentes cenários de entrada.

Por fim, este estudo destaca como modelos clássicos
da computação teórica podem ser aplicados
à formalização de problemas do mundo real,
como o controle inteligente de tráfego urbano.
A abordagem adotada demonstra que,
mesmo em sistemas abstratos como Máquinas de Turing,
é possível capturar regras práticas de decisão,
analisar corretude e eficiência,
e comparar soluções sob diferentes arquiteturas computacionais,
contribuindo tanto para a formação teórica
quanto para a compreensão de aplicações computacionais modernas.
