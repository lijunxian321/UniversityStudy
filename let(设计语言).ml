type program = exp
and exp =
  | Int of int
  | Var of string
  | Plus of exp * exp
  | Mins of exp * exp
  | Mult of exp * exp
  | Div of exp * exp
  | Iszero of exp * exp
  | If of exp * exp * exp
  | Let of string * exp * exp
  | Read;;
let p1 = 
  Let ("x", Int 1, 
    Plus (Var "x",Int 2))
let p2 =
  Let ("x", Int 1,
    Let ("y", Int 2,
      Plus (Var "x", Var "y")))
let p3=
  Let ("x",Let("y",Int 2,
            Plus (Var "y", Int 1)),
    Plus (Var "x", Int 3))
let p4=
  Let ("x", Int 1,
    Let ("x", Int 2,
      Let ("x", Int 3,
        Plus (Var "x", Var "y"))
    )
  )
type value =
  | VInt of int
  | VBool of bool
module Env = struct
  type t = (string * value) list
  let empty = []
  let add (x,v) e = (x,v)::e
  let rec lookup x e = 
    match e with 
      | []-> raise (Failure (x^ ":not bound "))
      | (y,v)::tl-> 
          if x=y then v else lookup x tl
end;;
module Env2 = struct
  type t = string -> value
  let empty = fun x -> raise (Failure (x^ ":not bound "))
  let lookup x e = e x
  let add (x,v) e = 
    fun y -> if x=y then v else e x
end;;
