(* -------- 1 -------- *)
let sestej list =
  let rec ses' list acc =
  match list with 
    | [] -> acc
    | x :: xs -> ses' xs (x + acc)
  in
  ses' list 0



(* -------- 2 -------- *)

(* -------- 3 -------- *)

(* -------- 4 -------- *)

(* -------- 5 -------- *)

(*type flyer = { status : status ; name : string }

let flyers = [ {status = Staff; name = "Quinn"}
             ; {status = Passenger (Group 0); name = "Xiao"}
             ; {status = Passenger Top; name = "Jaina"}
             ; {status = Passenger (Group 1000); name = "Aleks"}
             ; {status = Passenger (Group 1000); name = "Robin"}
             ; {status = Staff; name = "Alan"}
             ]*) 

(* -------- 6 -------- *)

(* -------- 7 -------- *)
