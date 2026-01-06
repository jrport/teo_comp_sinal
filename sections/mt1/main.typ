#include "modulo_alfa.typ"
#pagebreak()
#include "analise_temporal_alfa.typ"
#pagebreak()
#include "alfa_na_integra.typ"
#pagebreak()
#include "modulo_beta.typ"
#pagebreak()
#include "modded_couting_function.typ"
#pagebreak()
#include "analise_temporal_beta.typ"

==== Custo total da $"MT"_1$

Portanto, no pior caso, $"MT"_1$, recebe como entrada:
$ w = z^j + y^k + x^m or w = y^j + z^k + x^m $
Sendo,
$ k = j = m - 1 and x, y, z in {a, b, c} and x != y and y != z $
E determina a avenida $X$ como prioritária com o custo computacional total de:
$ T(n) = T_"alfa" + T_"beta" = (3n^2) + (2n^2 + 4n + 2) = 5n^2 + 4n + 2 $
Logo,
$ "MT"_1 in Theta(n^2) $

#pagebreak()
#include "beta_na_integra.typ"
#include "maquina_na_integra.typ"
// #include "exemplos.typ"
