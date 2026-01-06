= Máquina de múltiplas fitas ($"MT"_2$)

Com o objetivo de apresentar uma solução mais eficiente do que a MT1,
introduzimos uma Máquina de Turing determinística de múltiplas fitas,
denominada MT2.

A principal motivação para o uso de múltiplas fitas é permitir
uma separação clara entre as etapas de leitura, contagem,
comparação e decisão.
Essa separação elimina a necessidade de rebobinamentos frequentes da fita de entrada,
reduzindo significativamente o custo computacional total do algoritmo,
sem comprometer a corretude da solução.

Assim como a MT1, a MT2 resolve o problema descrito no enunciado:
determinar qual avenida deve receber o sinal verde em um cruzamento urbano,
a partir da quantidade de veículos em cada via,
respeitando a política de decisão e a ordem de desempate
A > B > C.

== Definição formal e organização em módulos

A MT2 é definida como uma Máquina de Turing determinística de múltiplas fitas,
representada pela seguinte 7-upla:

$ "MT2" = (Q, Sigma, Gamma, delta, q_0, q_"final") $

onde:

- $Q$ é um conjunto finito de estados;
- $Sigma = {A, B, C}$ é o alfabeto de entrada;
- $Gamma = {A, B, C, 1, _}$ é o alfabeto da fita,
  em que `_` representa o símbolo vazio;
- $delta$ é a função de transição determinística da máquina;
- $q_0$ é o estado inicial;
- $q_"final"$ é o estado final de aceitação.

A função de transição possui a forma:

$ delta: Q times Gamma^4 -> Q times Gamma^4 times {E, D, N}^4 $

atuando simultaneamente sobre quatro fitas:
uma fita de entrada e três fitas auxiliares.
Em cada transição, a máquina lê um símbolo de cada fita,
escreve um símbolo em cada fita
e move cada cabeçote de forma independente,
garantindo determinismo durante todo o processamento.

A MT2 opera com quatro fitas:
uma fita de entrada e três fitas auxiliares.
A fita de entrada contém a palavra que representa a distribuição de veículos,
enquanto as fitas auxiliares armazenam, em notação unária,
as quantidades de veículos associadas a cada avenida.

A palavra de entrada segue o formato:

$ A^i B^j C^k $

em que $i$, $j$ e $k$ representam, respectivamente,
o número de veículos nas avenidas A, B e C.

Para adequar o enunciado original do problema ao modelo formal de Máquinas de Turing,
as quantidades numéricas de veículos são representadas na fita de entrada
por meio de codificação unária.
Assim, cada ocorrência do símbolo $A$ representa um veículo na avenida A,
cada $B$ representa um veículo na avenida B,
e cada $C$ representa um veículo na avenida C,
resultando em uma correspondência direta entre os valores do enunciado
e a palavra processada pela máquina.

O processamento da MT2 é organizado nos seguintes módulos lógicos:

- leitura da entrada e contagem das ocorrências de cada símbolo;
- cálculo do número total de veículos;
- cálculo da metade do total;
- verificação de maioria absoluta;
- comparação das quantidades em caso de ausência de maioria;
- escrita da decisão final.

Essa organização modular facilita a compreensão do funcionamento da máquina
e permite uma análise de complexidade estruturada.

== Representação das fitas

Durante a execução da MT2, cada fita possui uma função bem definida.
A primeira fita contém a palavra de entrada
e é utilizada exclusivamente na etapa inicial de leitura.
As três fitas auxiliares armazenam, em notação unária,
o número de ocorrências dos símbolos $A$, $B$ e $C$, respectivamente.

Após a fase de leitura,
não é necessário retornar à fita de entrada,
pois todas as informações relevantes para a decisão
já se encontram armazenadas nas fitas auxiliares.
Esse aspecto é fundamental para a obtenção de complexidade linear.

== Funcionamento da máquina

Inicialmente, a MT2 percorre a fita de entrada da esquerda para a direita.
Durante essa varredura,
cada ocorrência dos símbolos $A$, $B$ e $C$
é registrada na fita auxiliar correspondente,
por meio da escrita de um símbolo $1$ para cada ocorrência.

Concluída a leitura,
a máquina constrói uma representação unária
do número total de veículos no cruzamento
sobrescrevendo a fita de entrada,
contendo exatamente $i + j + k$ símbolos $1$.

Em seguida, a MT2 calcula a metade desse total.
Para isso, dois símbolos $1$ são removidos por vez da fita do total,
e um símbolo $1$ é escrito em uma fita auxiliar
para cada par removido.
Caso reste um símbolo sem par,
este é descartado,
obtendo-se assim a representação unária de:

$ ceil((i + j + k) / 2) $

Com o valor da metade calculado,
a MT2 compara as quantidades de veículos de cada avenida
com esse valor.
As comparações são realizadas de forma sequencial,
seguindo a ordem A, B e C,
por meio de varredura simultânea e não destrutiva
das fitas envolvidas,
sendo encerradas quando uma das fitas atinge o símbolo branco `_`.

Se alguma avenida possuir uma quantidade de veículos
estritamente maior que a metade do total,
essa avenida é imediatamente definida como prioritária,
e o símbolo correspondente pertencente a $\{A,B,C\}$
é escrito na fita de saída.
Após o registro da decisão,
o processamento é encerrado,
e a máquina transita para o estado $q_"final"$.

Caso nenhuma avenida apresente maioria absoluta,
a MT2 inicia uma nova fase de decisão
baseada em comparações diretas
entre as quantidades individuais armazenadas
nas fitas auxiliares das avenidas.

Essas comparações são realizadas duas a duas,
por meio de varredura simultânea das fitas correspondentes,
sem modificação de seus conteúdos.
Em cada comparação,
os cabeçotes avançam sincronamente até que uma das fitas
atinja o símbolo branco `_`.
A fita que alcançar o símbolo `_` primeiro
é considerada como representando a menor quantidade.

Inicialmente,
a MT2 compara as fitas das avenidas A e B.
Se a fita da avenida A for estritamente maior que a da avenida B,
o símbolo A é imediatamente escrito na fita de saída
como candidato prioritário.
Caso contrário,
o símbolo B é escrito na fita de saída.

Em seguida,
a avenida cujo símbolo encontra-se registrado na fita de saída
é comparada com a avenida C,
utilizando o mesmo procedimento.
Se a quantidade da avenida registrada for estritamente maior,
seu símbolo é mantido na fita de saída.
Caso contrário,
o símbolo C sobrescreve o conteúdo da fita de saída.

Se, durante qualquer uma dessas comparações,
as duas fitas atingirem o símbolo branco `_` simultaneamente,
caracteriza-se um empate.
Nessa situação,
a MT2 resolve a decisão com base no critério de prioridade fixo
estabelecido no projeto da máquina,
dado pela ordem:

$ A > B > C $

Nessa situação,
o símbolo correspondente à avenida prioritária
segundo essa ordem é escrito na fita de saída.

Ao final do processamento,
a fita de saída contém exatamente um único símbolo
pertencente ao conjunto $\{A, B, C\}$,
correspondente à avenida definida como prioritária.
A execução é encerrada ao alcançar o estado $q_"final"$.


== Análise formal de complexidade

Seja $w = A^i B^j C^k$ a palavra de entrada fornecida à MT2
e seja

$ n = |w| = i + j + k $

o tamanho da entrada.

=== Leitura da entrada e contagem

A MT2 percorre a fita de entrada uma única vez,
da esquerda para a direita,
até encontrar o símbolo branco `_`.

Durante essa varredura:

- cada um dos $n$ símbolos da entrada é lido exatamente uma vez;
- para cada símbolo lido, é realizada exatamente uma escrita
  de um símbolo $1$ em uma das fitas auxiliares;
- não há rebobinamentos da fita de entrada.

Portanto:

$ T_1(n) = n $

e

$ T_1(n) in O(n) $

=== Construção da fita do total de veículos

A construção da fita do total escreve exatamente $n$ símbolos $1$,
logo:

$ T_2(n) = n $

e

$ T_2(n) in O(n) $

=== Cálculo da metade do total
Para calcular a metade do total de veículos, a máquina remove dois símbolos
1 por iteração da fita do total e escreve um símbolo
1 na mesma fita, agora representando a metade.

No pior caso:

$ floor(n / 2) $

iterações são realizadas.
Assim:

$ T_3(n) in O(n) $

=== Verificação de maioria absoluta e comparações

A verificação de maioria absoluta é realizada comparando, de forma sequencial,
as quantidades de veículos de cada avenida com o valor da metade do total,
seguindo a ordem A, B e C.

Cada comparação é feita de maneira não destrutiva.
Para comparar a fita de uma avenida X ∈ {A, B, C} com a fita da metade,
a MT2 posiciona simultaneamente os cabeçotes no início das duas fitas
e realiza uma varredura síncrona da esquerda para a direita,
avançando um símbolo por passo, sem realizar escritas.

A comparação é encerrada assim que um dos cabeçotes encontra o símbolo branco `_`.
Se a fita da metade atingir o símbolo `_` primeiro, conclui-se que a avenida X
possui uma quantidade de veículos estritamente maior que a metade do total.
Caso a fita da avenida X atinja o símbolo `_` antes (ou simultaneamente),
conclui-se que não há maioria absoluta para essa avenida.

O número de passos executados em cada comparação é igual ao comprimento
da menor fita entre a avenida considerada e a fita da metade.
Assim, o custo de uma comparação envolvendo a avenida X é dado por:

$ T_X = min(|X|, ceil(n / 2)) $

No pior caso, nenhuma avenida possui maioria absoluta,
e as três comparações são realizadas. Portanto, o custo total dessa etapa é:

$ T_4(n) = sum_{X ∈ {A,B,C}} min(|X|, ceil(n / 2)) $

Como |A| + |B| + |C| = n, segue que:

$ T_4(n) <= n $

e, consequentemente:

$ T_4(n) ∈ O(n) $


=== Escrita da saída e encerramento

Após a conclusão das etapas de verificação e comparação,
a MT2 determina uma única avenida como prioritária.

Nessa fase final, a máquina:
- limpa a fita de saída;
- escreve exatamente um único símbolo pertencente ao conjunto {A, B, C},
  correspondente à avenida selecionada;
- realiza a transição para o estado final de aceitação q_final.

Todas as operações dessa etapa envolvem um número constante de leituras,
escritas e movimentos de cabeçote, independentemente do tamanho da entrada.
Assim, o custo temporal dessa fase é constante:

$ T_5(n) ∈ O(1) $

=== Custo total no pior caso

No pior caso, nenhuma avenida possui maioria absoluta,
e todas as etapas do processamento da MT2 são executadas completamente.

Somando os custos das fases individuais, tem-se:

- leitura da entrada e contagem:        $ T_1(n) = n $
- construção da fita do total:          $ T_2(n) = n $
- cálculo da metade do total:            $ T_3(n) = floor(n / 2) $
- verificação e comparações:             $ T_4(n) ∈ O(n) $
- escrita da saída e encerramento:       $ T_5(n) ∈ O(1) $

Portanto, o custo total de execução no pior caso é dado por:

$ T(n) = n + n + floor(n / 2) + O(n) + O(1) $

Agrupando os termos dominantes, obtém-se:

$ T(n) ∈ O(n) $


=== Complexidade em número de estados

A MT2 é definida por um conjunto finito de módulos lógicos bem delimitados:
leitura e contagem, construção do total, cálculo da metade, verificação de maioria,
comparações finais e escrita da saída.

Cada módulo é implementado por um número constante de estados,
independente do tamanho da entrada ou dos valores i, j e k codificados na fita.
Não há criação dinâmica de estados nem duplicação de submáquinas
em função do comprimento da palavra de entrada.

Assim, o número total de estados da máquina é fixo e determinado
exclusivamente pela especificação do algoritmo.

Portanto, a complexidade da MT2 em número de estados é constante:

$ |Q| ∈ O(1) $


== Exemplos passo a passo

A seguir, apresentam-se exemplos ilustrativos do funcionamento da MT2,
explicitando o conteúdo das fitas auxiliares,
incluindo as representações unárias do total e da metade,
bem como a aplicação correta do critério de maioria absoluta.

=== Exemplo 1

Considere a entrada:

$ A^3 B^2 C^1 $

Após a leitura da fita de entrada, a MT2 registra,
em notação unária, as quantidades de veículos em cada avenida:

- fita A:       AAA
- fita B:       BB
- fita C:       C

O número total de veículos é:

$ 3 + 2 + 1 = 6 $

A fita do total contém exatamente seis símbolos 1:

- fita total:   111111

Em seguida, a MT2 calcula o floor da metade do total.
Obtém-se:

$ 6 / 2 = 3 $

resultando na seguinte fita da metade:

- fita metade:  111

Na etapa de verificação de maioria absoluta,
a MT2 compara, de forma não destrutiva,
a fita da avenida A com a fita da metade,
realizando uma varredura simultânea até o símbolo branco `_`.

Ambas as fitas atingem o símbolo `_` ao mesmo tempo,
pois possuem o mesmo comprimento.
Assim, a quantidade de veículos da avenida A
é igual à metade do total,
e, portanto, *não caracteriza maioria absoluta*.

Não havendo maioria absoluta,
a MT2 prossegue para a fase de comparações diretas
entre as quantidades individuais.
Como a avenida A possui estritamente mais veículos
que as avenidas B e C,
ela é selecionada como prioritária.

Ao final do processamento,
o símbolo A é escrito na fita de saída,
e a máquina alcança o estado final de aceitação.


=== Exemplo 2

Considere a entrada:

$ A^2 B^2 C^2 $

Após a leitura da entrada, as fitas auxiliares contêm:

- fita A:       AA
- fita B:       BB
- fita C:       CC

O número total de veículos é:

$ 2 + 2 + 2 = 6 $

logo, a fita do total é:

- fita total:   111111

A metade do total é:

$ 6 / 2 = 3 $

resultando em:

- fita metade:  111

Na verificação de maioria absoluta,
nenhuma das fitas A, B ou C possui comprimento
estritamente maior que o da fita da metade.
Assim, nenhuma avenida apresenta maioria absoluta.

A MT2 então realiza comparações diretas
entre as quantidades armazenadas nas fitas auxiliares.
As comparações indicam empate entre as três avenidas.

Nesse caso, a decisão final segue o critério de desempate
pré-definido pela máquina, baseado na ordem de prioridade:

$ A > B > C $

Consequentemente, a avenida A é selecionada,
o símbolo A é escrito na fita de saída,
e o processamento é encerrado no estado final de aceitação.


== Comparação com a MT1

A MT1, definida como uma Máquina de Turing determinística de fita única,
realiza o processamento da entrada e todas as etapas de decisão
utilizando apenas uma fita de trabalho.
Como consequência, diversas informações intermediárias
precisam ser acessadas repetidamente por meio de
rebobinamentos completos da fita.

Em particular, na MT1:
- a contagem das ocorrências de cada símbolo exige múltiplas varreduras
  da fita de entrada;
- o cálculo do total e da metade do número de veículos
  envolve deslocamentos frequentes do cabeçote ao longo de uma fita
  de comprimento linear;
- as comparações entre quantidades são realizadas por meio de
  cancelamentos sucessivos e retornos ao início da fita,
  resultando em custos quadráticos no pior caso.

Essas operações implicam que símbolos da entrada e de estruturas auxiliares
são revisitados um número linear de vezes,
o que conduz a um tempo total de execução da ordem de:

$ Θ(n^2) $

Por outro lado, a MT2 explora o modelo de Máquina de Turing multifitas,
dispondo de uma fita de entrada e três fitas auxiliares,
o que permite separar fisicamente as informações relevantes
e evitar rebobinamentos desnecessários.

Na MT2:
- a leitura da entrada é realizada em uma única varredura;
- as quantidades individuais são armazenadas em fitas distintas;
- todas as comparações são feitas por varreduras simultâneas,
  sem modificações destrutivas nem retornos repetidos ao início das fitas.

Como resultado, cada fita é percorrida apenas um número constante de vezes,
e todas as etapas do processamento possuem custo linear
no tamanho da entrada.

Assim, o tempo total de execução da MT2 é:

$ T(n) ∈ O(n) $

Essa diferença evidencia o ganho assintótico proporcionado
pelo uso do modelo multifitas:
embora ambos os modelos sejam computacionalmente equivalentes
em termos de linguagens reconhecíveis,
a MT2 apresenta eficiência assintoticamente superior
em relação à MT1 para o problema considerado.