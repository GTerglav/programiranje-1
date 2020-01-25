from functools import lru_cache

# Cilj: izračunajte vrednosti Fibonaccijevega zaporadja za 100, 500, 1000,
# 10**5, and 10**6 člen.
# Za vsako definicijo preizkusite kako pozne člene lahko izračuante in poglejte
# zakaj se pojavi problem (neučinkovitost, pregloboka rekurzija,
# premalo spomina ...).

# Definirajte naivno rekurzivno različico.
# Omejitev: Prepočasno.
def fib(n):
    if n <= 0:
        return 0
    if n == 1:
        return 1
    else:
        return fib(n-2) + fib(n-1)
# Z uporabo dekoratorja izboljšajte naivno različico.
# Omejitev: Preseže največjo dovoljeno globino rekurzija za ~350.
from functools import lru_cache
@lru_cache(maxsize=100000)
def fib_cache(n):
    if n <= 0:
        return 0
    if n == 1:
        return 1
    else:
        return fib_cache(n-2) + fib_cache(n-1)
# Nariši drevo klicov za navadno rekurzivno fib funkcijo pri n=5 in
# ugotovi kateri podproblemi so klicani večkrat.

# Definirajte rekurzivno memoizirano funkcijo fib brez uporabe dekoratorja.
# Omejitev: Preseže največjo dovoljeno globino rekurzija za ~1000.
def fib_memo_rec(n):
    return 0
# Na katere podprobleme se direktno skicuje rekurzivna definicija fib?

# Definirajte fib ki gradi rezultat od spodaj navzgor (torej računa in si zapomni
# vrednosti od 1 proti n.)
def fib_memo_iter(n):
    max_sez = [0 for j in range(n+1)]
    for i in range(n+1):
        if i == 0: 
            max_sez[i] = 0
        if i == 1:
            max_sez[i] = 1
        else:
            max_sez[i] = max_sez[i - 1] + max_sez[i - 2]
    return max_sez[n] 
# Izboljšajte prejšnjo različico tako, da hrani zgolj rezultate, ki jih v
# nadaljevanju nujno potrebuje.
def fib_iter(n):
    max_sez = [0, 1]
    for i in range(n-1):
        max_sez[0], max_sez[1]= max_sez[1], max_sez[0] + max_sez[1]        
    return max_sez[1] 