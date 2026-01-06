= Máquina de múltiplas fitas

Com o objetivo de apresentar uma solução mais eficiente do que a MT1,
introduzimos uma Máquina de Turing determinística com múltiplas fitas,
denominada MT2.

A principal motivação para o uso de múltiplas fitas é permitir
uma separação clara entre as etapas de leitura, contagem,
comparação e decisão.
Essa separação reduz a necessidade de varreduras repetidas sobre a fita de entrada,
diminuindo significativamente o custo computacional total do algoritmo,
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
- $Sigma = { A, B, C }$ é o alfabeto de entrada;
- $Gamma = { A, B, C, 1, ␣ }$ é o alfabeto da fita, em que ␣ representa o símbolo vazio;
- $delta$ é a função de transição determinística definida sobre múltiplas fitas;
- $q_0$ é o estado inicial;
- $q_"final"$ é o estado final de aceitação.

A MT2 opera com quatro fitas:
uma fita de entrada e três fitas auxiliares.
A fita de entrada contém a palavra que representa a distribuição de veículos,
enquanto as fitas auxiliares armazenam, em notação unária,
as quantidades de veículos associadas a cada avenida.

A palavra de entrada segue o formato:

$ A^i B^j C^k $

em que $i$, $j$ e $k$ representam,
respectivamente, o número de veículos
nas avenidas A, B e C.

Para adequar o enunciado original do problema ao modelo formal de Máquinas de Turing,
as quantidades numéricas de veículos informadas para cada avenida são representadas
na fita de entrada por meio de uma codificação em notação unária.
Assim, o número de veículos na avenida A é codificado pela repetição do símbolo
$A$ exatamente $i$ vezes, o número de veículos na avenida B pela repetição do símbolo
$B$ exatamente $j$ vezes e, de forma análoga, o número de veículos na avenida C pela
repetição do símbolo $C$ exatamente $k$ vezes, resultando em uma palavra de entrada
no formato $A^i B^j C^k$.
Dessa maneira, existe uma correspondência direta entre os valores numéricos
fornecidos no enunciado e a palavra processada pela máquina, garantindo a fidelidade
da modelagem e a corretude da solução proposta.

O processamento da MT2 pode ser dividido nos seguintes módulos lógicos:

- leitura da entrada e contagem das ocorrências de cada símbolo;
- cálculo do número total de veículos;
- cálculo da metade do total;
- verificação de maioria absoluta;
- escolha da maior quantidade em caso de ausência de maioria;
- escrita da decisão final.

Essa organização modular facilita a compreensão do funcionamento da máquina
e permite relacionar diretamente sua arquitetura com a análise de complexidade.

== Representação das fitas

Durante a execução da MT2, cada fita possui uma função bem definida.
A primeira fita contém a palavra de entrada e é utilizada apenas na etapa inicial
de leitura.
As três fitas auxiliares registram, em notação unária,
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
é registrada nas fitas auxiliares correspondentes,
por meio da escrita de um símbolo $1$ para cada ocorrência.

Concluída a contagem,
a máquina constrói uma representação unária
do número total de veículos no cruzamento, dada por:

$ i + j + k $

Em seguida, a MT2 calcula a metade desse total.
Para isso, dois símbolos $1$ são removidos por vez da fita do total,
e um símbolo $1$ é escrito em uma fita auxiliar para cada par removido.
Caso reste um símbolo sem par,
este é descartado,
obtendo-se assim a representação unária de:

$ ceil((i + j + k) / 2) $

Com o valor da metade calculado,
a MT2 compara as quantidades de veículos de cada avenida
com esse valor.
As comparações são realizadas de forma sequencial,
seguindo a ordem A, B e C,
o que garante automaticamente o critério de desempate.

Se alguma avenida possuir uma quantidade de veículos
estritamente maior que a metade do total,
o processamento é encerrado imediatamente,
e essa avenida é selecionada como prioritária.

Caso nenhuma avenida apresente maioria absoluta,
a MT2 realiza comparações diretas entre as quantidades das avenidas,
selecionando aquela com maior número de veículos.
Em situações de empate,
a decisão segue a ordem de prioridade A > B > C,
conforme definido no enunciado.

Ao final do processamento,
a fita de saída é limpa
e a máquina escreve um único símbolo pertencente a ${A, B, C}$,
correspondente à avenida escolhida.
A execução é encerrada ao alcançar o estado $q_"final"$.

== Análise de complexidade

Seja $n = i + j + k$ o tamanho da palavra de entrada.

A leitura inicial da fita de entrada é realizada em tempo linear.
As etapas de contagem,
cálculo do total,
cálculo da metade
e comparação entre quantidades
também realizam, no pior caso,
um número linear de movimentos sobre as fitas.

Dessa forma, o tempo total de execução da MT2,
no pior caso,
pertence à classe:

$ O(n) $

Além disso, o número de estados da máquina é constante
e independe do tamanho da entrada, isto é:

$ |Q| = O(1) $

Quando comparada à MT1,
a MT2 apresenta uma melhora assintótica significativa,
reduzindo o custo total de Θ($n^2$) para O($n$),
evidenciando o impacto do uso de múltiplas fitas
na eficiência do processamento.

== Exemplos passo a passo

Considere a entrada:

$ A^3 B^2 C^1 $

Inicialmente, a MT2 registra três símbolos $1$ na fita de A,
dois na fita de B
e um na fita de C.
O total de veículos é $3 + 2 + 1 = 6$,
e a metade do total é igual a $3$.

Como nenhuma avenida possui quantidade estritamente maior que 3,
não há maioria absoluta.
A máquina então compara as quantidades individuais,
identificando que a avenida A possui o maior número de veículos.
Assim, a MT2 seleciona a avenida A como prioritária.

Em entradas com distribuição uniforme,
como $A^2 B^2 C^2$,
nenhuma avenida possui maioria absoluta,
e todas apresentam a mesma quantidade de veículos.
Nesses casos, a decisão final é sempre determinada
pela ordem de prioridade A > B > C.
