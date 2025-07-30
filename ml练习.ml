let rec fold_right f l a=
  match l with
    |[]->a
    |hd::tl->f hd (fold_right f tl a);;
let rec fold_left f a l=
  match l with
    |[]->a
    |hd::tl->fold_left f  (f a hd) tl;;
let sum lst= fold_right (+) lst 0

let length l= fold_right (fun x y-> 1+y) l 0;;
length [1;2;3;4;5];;
let reverse l= fold_left (fun x y-> y::x) [] l;;
reverse [1;2;3;4;5];;
let is_all_pos l=fold_right(fun x y->(x>0) && y) l true;;
is_all_pos [1;2;3;4;-1];;
let is_all_pos l=fold_left(fun x y->x && y>0) true l;;
is_all_pos [1;2;3;4;-1];;
let map f l=fold_right(fun x y->(f x) :: y) l [];;
let map f l=fold_left(fun x y->x @ [f y]) [] l;;
let filter f l=fold_right (fun x y->if f x then x::y else y) l [];;
let filter f l=fold_left(fun x y->if f y then [y] else [])  [] l;;
