(* =================== *)
(* 1. naloga: funkcije *)
(* =================== *)

let is_root x y = if x * x = y then true else false 

let pack3 x y z = (x, y, z)

let sum_if_not f list =
  let rec sin f list acc =
  match list with
  | [] -> acc
  | x :: xs -> if f x then sin f xs acc else sin f xs (x + acc)
  in 
  sin f list 0

let rec reverse list =
  let rec rev list acc =
    match list with
    | [] -> acc
    | x :: xs -> rev xs (x :: acc)
  in
  rev list [] 

let apply list1 list2 = 
  let rec apply' list1 list2 acc1 acc2=
  match list1
   with
  | [] -> acc1
  | f :: fs ->
    match list2 with
    | [] -> apply' fs list2 (acc2 :: acc1) []
    | y :: ys -> apply' (f :: fs) (ys) acc1 (f y :: acc2)
  in
  reverse(apply' list1 list2 [] [])

(* ======================================= *)
(* 2. naloga: podatkovni tipi in rekurzija *)
(* ======================================= *)

type vrsta_srecanja = Predavanja | Vaje


type srecanje = {predmet: string; vrsta: vrsta_srecanja; trajanje: int;}

let nic = {predmet = "Nic"; vrsta = Vaje ; trajanje = 0;}

let vaje srecanje = {predmet = "Analiza 2a"; vrsta = Vaje; trajanje = 3}

let predavanje srecanje = {predmet = "Programiranje 1"; vrsta = Predavanja; trajanje = 3}

let urnik_profesor () = failwith "dopolni me"

let je_preobremenjen () = failwith "dopolni me"

let bogastvo () = failwith "dopolni me"