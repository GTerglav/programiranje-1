test = [
    [2,4,1,1],
    [3,2,0,5],
    [8,0,7,2]    
]
from functools import lru_cache

def jabolka(j_matrika, n):
    max_i = len(j_matrika) - 1
    max_j = len(j_matrika[0]) - 1
    def korak(i, j, n):
        if i > max_i or j > max_j:
            return 0
        if n == 0 or j == max_j:
            return j_matrika[i][j]
        else:
            return j_matrika[i][j] + max(korak(i, j+1, n-1), korak(i+1, 0, n-1))
    options = [korak(i,0,n-1) for i in range(len(j_matrika))]
    return korak(0,0,n -1)

def jabolka2(j_matrika, n):
    max_i = len(j_matrika) - 1
    max_j = len(j_matrika[0]) - 1

    @lru_cache(maxsize=None)
    def korak(i, j, n):
        if i > max_i or j > max_j:
            return 0
        if n == 0 or j == max_j:
            return j_matrika[i][j]
        else:
            print("racunam")
            return j_matrika[i][j] + max(korak(i, j+1, n-1), korak(i+1, 0, n-1))
    options = [korak(i,0,n-1) for i in range(len(j_matrika))]
    return max(options)