test1 = [2,4,1,2,1,3,1,1,5]
test2 = [4,1,8,2,11,1,1,1,1]
from functools import lru_cache

def zaba(sez):

    @lru_cache(maxsize=256)
    def pobeg(i, energija):
        if i + energija > (len(sez) - 1) :
            return 1
        def skok_za(j):
            return 1 + pobeg(i+j, energija - j + sez[i+j])
        for k in range(1, energija + 1):
            moznosti = []
            moznosti.append(skok_za(k))
        mini = moznosti[0]
        for j in range(len(moznosti)):
            if moznosti[j] < mini:
                mini = moznsti[j]
        return mini

    return pobeg(0, sez[0])
        
