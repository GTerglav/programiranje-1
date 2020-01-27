let odstej_trojici (a,b,c) (d,e,f) = (a-d,b-e,c-f)

let rec max_rezultat_do_n f n = 
  if n < 1 then f 0 
  else if (f n) > (max_rezultat_do_n f (n-1)) then f n
    else max_rezultat_do_n f (n-1)

let fu x = x + 1

let rec pocisti_seznam list =
  let rec aux list acc =
    match list with
    | [] -> acc
    | None :: xs -> aux xs acc
    | Some x :: xs -> aux xs (x :: acc)
  in 
  aux list []

let test = [Some 4; Some 3; None; Some 2]

let rec preveri_urejenost list =
  let rec aux list acc1 acc2 =
    match list with
    | [] -> true
    | x :: xs -> 
      if x mod 2 = 0 then if x > acc1 then aux xs x acc2 else false
      else if acc2 = 0 then aux xs acc1 x
        else if x > acc2 then false 
          else aux xs acc1 x
  in
  aux list 0 0 
  
let test2 = [3; 2; 4; 5; 6]
let test3 = [7; 5; 2; 4; 1; 6; 10; 19]

type 'a gnezdenje =
  | Element of 'a
  | Podseznam of 'a gnezdenje list

let gnezdenje_primer = [Element 1; Element 2; Podseznam [Element 1; Podseznam [Element 3; Podseznam [Element 4]; Podseznam []; Element 2]; Element 4]]

let najvecja_globina_ene list =
  let rec aux list acc =
    match list with
    | [] -> acc
    | Element x :: xs -> aux xs acc 
    | Podseznam ys :: xs -> aux ys (acc + 1)
  in
  aux list 1

let najvecja_globina list =
  let rec aux list acc =
    match list with
    | [] -> acc
    | Element x :: xs -> aux xs acc 
    | Podseznam ys :: xs -> aux xs (max acc (1 + najvecja_globina_ene ys))
  in
  aux list 1


let preslikaj list f =
  let rec aux list f acc =
    match list with
    | [] -> List.rev acc
    | Element x :: xs -> aux xs f ((Element (f x)) :: acc) 
    | Podseznam ys :: xs -> aux xs f ((Podseznam (aux ys f [])) :: acc)
  in
  aux list f []

let splosci' list = 
  let rec aux list acc =
    match list with
    | [] -> acc
    | Element x :: xs -> aux xs (x :: acc) 
    | Podseznam ys :: xs -> aux xs (aux ys acc)
  in
  aux list []

let splosci list = List.rev (splosci' list)

let alternirajoci_konstruktorji list =
  let rec aux list acc =
    match list with
    | [] -> true
    | Element x :: xs -> 
      if acc = 1 then aux xs 2 
      else 
        if acc = 0 then aux xs 2 
        else false
    | Podseznam ys :: xs -> 
      if acc = 2 then aux xs 1
      else 
        if acc = 0 then aux xs 1  
        else false
  in
  aux list 0

let join_list list1 list2 =
  let rec aux list1 list2 acc =
    match list2 with
    | [] -> List.rev acc
    | x :: xs -> aux list1 xs (x :: acc)
  in
  aux list1 list2 (List.rev list1)

let lst = [1; 2; 3]
let lest = [4; 5; 6]

