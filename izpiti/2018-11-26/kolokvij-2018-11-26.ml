(* -------- 1 -------- *)
let sestej list =
  let rec ses' list acc =
  match list with 
    | [] -> acc
    | x :: xs -> ses' xs (x + acc)
  in
  ses' list 0



(* -------- 2 -------- *)
let rec urejen_sez = function
  | [] -> true
  | [x] -> true
  | x :: y :: xs -> if x <= y then urejen_sez (y :: xs) else false

(* -------- 3 -------- *)
let rec reverse list =
  let rec rev list acc =
    match list with
    | [] -> acc
    | x :: xs -> rev xs (x :: acc)
  in
  rev list [] 

let rec vstavi list stevilo = 
  let rec vstavi' list stevilo acc = 
  match list with
    | [] -> (reverse acc) @ [stevilo]
    | x :: xs -> if x > stevilo then (reverse acc) @ (stevilo :: x :: xs) else vstavi' xs stevilo (x :: acc)
  in
  vstavi' list stevilo []

let rec uredi list =
  let rec uredi' list acc = 
  match list with
   | [] -> acc
   | x :: xs -> uredi' xs (vstavi acc x)
  in
  uredi' list [] 

(* -------- 4 -------- *)
let rec vstavi'' f list stevilo = 
  let rec vstavi''' f list stevilo acc = 
  match list with
    | [] -> (reverse acc) @ [stevilo]
    | x :: xs -> if f x stevilo then (reverse acc) @ [stevilo] @ (x :: xs) else vstavi''' f xs stevilo (x :: acc)
  in
  vstavi''' f list stevilo []

let rec uredi'' f list =
  let rec uredi''' f list acc = 
  match list with
   | [] -> acc
   | x :: xs -> uredi''' f xs (vstavi'' f acc x)
  in
  uredi''' f list [] 

let funkc j k = not (j < k)
(* -------- 5 -------- *)

(*type flyer = { status : status ; name : string }

let flyers = [ {status = Staff; name = "Quinn"}
             ; {status = Passenger (Group 0); name = "Xiao"}
             ; {status = Passenger Top; name = "Jaina"}
             ; {status = Passenger (Group 1000); name = "Aleks"}
             ; {status = Passenger (Group 1000); name = "Robin"}
             ; {status = Staff; name = "Alan"}
             ]*) 

type priority =
  | Group of int
  | Top

type status =
  | Staff
  | Passenger of priority
(* -------- 6 -------- *)

let first_has_priority x y =
  match x.status with
  | Staff -> true
  | Passenger -> false



(* -------- 7 -------- *)
