let razlika_kvadratov a b = (a + b) * (a + b) - a * a - b * b

let uporabi_na_paru f (a,b) = (f a, f b)

let rec ponovi_seznam n sez =
    if n <= 0 then [] 
        else if n = 1 then sez
            else ponovi_seznam (n - 1) (sez @ sez)

let razdeli list =
  let rec aux acc1 acc2 = function
    | [] -> (List.rev acc1, List.rev acc2)
    | x :: xs -> if x < 0 then aux (x :: acc1) acc2 xs 
      else aux acc1 (x :: acc2) xs 
  in
  aux [] [] list

type 'a veriga = 
  | Filter of ('a -> bool) * 'a list * 'a veriga
  | Ostalo of 'a list

let test = Filter ((>) 0, [], Filter ((>)10, [], Ostalo []))

let rec vstavi a = function
  | Filter (f,list,chain) -> if f a then Filter (f,list @ [a],chain)
    else Filter (f,list,vstavi a chain)
  | Ostalo xs -> Ostalo (xs @ [a])