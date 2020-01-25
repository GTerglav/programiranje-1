let podvoji_vsoto a b = a + a + b + b

let povsod_vecji (a,b,c) (d,e,f) = if a>d then if b>e then c>f else false else false

let uporabi_ce_lahko f x = 
  match x with
  | Some x -> Some (f x)
  | None -> None

let pojavi_dvakrat a list =
  let rec aux a acc = function
    | [] -> acc = 2
    | x :: xs -> if x = a then aux a (acc + 1) xs else aux a acc xs
  in
  aux a 0 list 

let primer = [1;2;3;4;3;5;6;4;1;1]

let izracunaj_v_tocki a list =
  let rec aux a acc = function
    | [] -> List.rev acc
    | f :: fs -> aux a (f a :: acc) fs
  in
  aux a [] list 

let eksponent x p =
  let rec aux x p acc =
    match p with
    | 0 -> acc
    | y -> aux x (y - 1) (acc * x)
  in
  aux x p 1


type 'a mm_drevo =
  | Prazno
  | Vozlisce of 'a mm_drevo * 'a * int * 'a mm_drevo

let rec vstavi el = function
  | Prazno -> Vozlisce (Prazno,el,1,Prazno)
  | Vozlisce (lt,a,b,rt) -> if a < el then vstavi el rt
    else if a > el then vstavi el lt
      else Vozlisce (lt,a,b+1,rt)

