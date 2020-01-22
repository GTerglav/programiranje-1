let odstej_trojici (a,b,c) (d,e,f) = (a-d,b-e,c-f)

let rec max_rezultat_do_n f n = 
  if n < 1 then f 0 
  else if (f n) > (max_rezultat_do_n f (n-1)) then f n
    else max_rezultat_do_n f (n-1)

let fu x = (x - 1) * (x - 5)

let pocisti_seznam