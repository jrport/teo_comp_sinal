== Exemplos passo a passo
=== Exemplo 1
Considere a entrada:
$ w = A^(4)B^(2)C^(1) $

Já na avaliação da primeira função de contagem, $psi(a, {b, c})$, já é determinado a superioridade da cardinalidade de $a$ sobre a soma das outras duas, logo ocorre parada em $F_a$ e a avenida $A$ é definida como prioritária.

O processo de computação sendo composto apenas pelos passos do primeiro submódulo de contagem até o esgotamento dos símbolos $b$ e $c$, culminando num $a$ não pareado restante na fita.

=== Exemplo 2
Considere a entrada:
$ w = C^(3)A^(3)B^(3) $

Aqui a computação será mais demorada, apesar da mesma tomada de decisão final -- a da priorização da avenida $A$ --, existe um empate na cardinalidade dos símbolos, o que exige a avaliação do módulo $beta$ para desempate.

Portanto, serão feitas todas as comparações de $alpha$, até que seja verificado que:
$ gamma_(w)(a) gt.not gamma_(w)(b) and gamma_(w)(b) gt.not gamma_(w)(a) and gamma_(w)(b) gt.not gamma_(w)(c) and gamma_(w)(c) gt.not gamma_(w)(a) $
Ou seja, não há símbolo com cardinalidade maior que os outros, e o módulo $beta$ é acionado para desempate.

Lá serão computados os duelos $A times B$ e $A times C$, ambos determinando empate e seguindo ao estado final $F^(')_a$