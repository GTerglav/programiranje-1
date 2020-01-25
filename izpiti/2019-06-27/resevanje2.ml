
type complex = {re : float; im : float}

let p = {re = 1.; im = 1.}

let complex_add a b = {re = a.re +. b.re; im = b.im +. a.im}

let complex_conjugate a = {re = a.re; im = -. a.im}

let list_apply_either pred f g list =
  let rec aux pred f g list acc =
    match list with
    | [] -> List.rev acc
    | x :: xs -> if pred x then  aux pred f g xs (f x :: acc)
      else aux pred f g xs (g x :: acc)
  in
  aux pred f g list []

let r = [3; -2; 0; 1]

let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
    let b = pow a (n / 2) in
    b * b * (if n mod 2 = 0 then 1 else a)

let eval_poly list t =
  let rec aux list t acc1 acc2 =
    match list with
    | [] -> acc1
    | x :: xs -> aux xs t (acc1 + (x * (pow t acc2))) (acc2 + 1)
  in
  aux list t 0 0


type najemnik = string

type vrt = Obdelovan of najemnik
          | Oddan of najemnik * (vrt * vrt list)
          | Prost

let primer = Oddan ("Kovalevskaya", (Obdelovan "Galois", [Obdelovan "Lagrange"; Prost]))
let primer2 = Obdelovan "Galois"

let obdelovalec_vrta vrt = 
  match vrt with
  | Oddan (x, (y,xs)) -> None
  | Prost -> None
  | Obdelovan x -> Some x

let list_max list =
  let rec aux list acc =
    match list with
    |[] -> acc
    |x :: xs -> if x > acc then aux xs x else aux xs acc
  in
  aux list 0

let f_na_sez f list =
  let rec aux f list acc =
    match list with
    | [] -> list_max acc
    | x :: xs -> aux f xs (f x :: acc)
  in
  aux f list []

  

let rec globina_oddajanja vrt =
  let rec aux vrt acc =
    match vrt with 
    | Obdelovan x -> acc
    | Prost -> acc
    | Oddan (x, (y, xs)) -> max (aux y (acc + 1)) ((f_na_sez globina_oddajanja xs) + 1) 
  in 
  aux vrt 0
