from functools import lru_cache
def simetricen(niz):
    if niz == "":
        return True
    elif niz[0] == niz[-1]:
        return simetricen(niz[1:-1])

test = "01110"

test2 = "00101011"
    
@lru_cache(maxsize=None)
def stevilo_delov(w, je_simetricen):
    if w == []:
        return 0
    if je_simetricen(w):
        return 1

    options = [stevilo_delov(w[:i], je_simetricen) +
               stevilo_delov(w[i:], je_simetricen) for i in range(1, len(w))]

    return min(options)

    


def razdeli(niz):
    sez = []
    if niz == "":
        return sez
    lower = 0
    for i in range(len(niz)):        
        if i == len(niz):
            sez.append(niz[lower:])
        if simetricen(niz[lower:i]) and not simetricen(niz[lower:i + 1]):
            sez.append(niz[lower:i])
            lower = i + 1
    return sez
            

def vsotno_simetricen(niz):
    n = len(niz) // 2
    if len(niz) % 2 == 0:
        leva = 0
        for i in niz[:n]:
            leva += int(i)
        desna = 0
        for j in niz[n:]:
            desna += int(j)
        return desna == leva
    else:
        leva = 0
        for i in niz[:n]:
            leva += int(i)
        desna = 0
        for j in niz[n+1:]:
            desna += int(j)
        return desna == leva

test3 = "01001000"
test4 = "1011"