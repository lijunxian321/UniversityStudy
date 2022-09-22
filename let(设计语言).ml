type program = exp
and exp =
  | Int of int
  | Var of string
  | Plus of exp * exp
  | Mins of exp * exp
  | Mult of exp * exp
  | Div of exp * exp
  | Iszero of exp
  | If of exp * exp * exp
  | Let of string * exp * exp
  | Read
  | Print of exp;;
      
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
    fun y -> if x=y then v else e y
end
exception TypeError of string

let rec binop op env e1 e2=
  let v1 = eval env e1 in
  let v2 = eval env e2 in
    begin
    match v1, v2 with 
      | VInt n1, VInt n2 -> VInt (op n1 n2)
      | VBool _, _
      | _,VBool _-> raise (TypeError "binop")
    end
        
and eval : Env.t -> exp -> value
=fun env exp->
  match exp with
    | Int n -> VInt n
    | Var x -> Env.lookup x env
    | Plus (e1, e2) -> binop (fun x y-> x+y) env e1 e2
    | Mins(e1, e2) -> binop (fun x y-> x-y) env e1 e2
    | Mult(e1, e2) -> binop (fun x y-> x*y) env e1 e2
    | Div(e1, e2) -> binop (fun x y-> x/y) env e1 e2
    | Read -> VInt (read_int ())
    | Print e ->
      begin
        match eval env e with
          | VInt n -> (print_endline (string_of_int n); VInt n)
          | VBool b -> (print_endline (string_of_bool b); VBool b)
      end
    | Iszero e->
      begin
        match eval env e with
          | VBool _-> raise (TypeError "iszero")
          | VInt n -> VBool(n=0)
      end
    | If (e1,e2,e3)->
      begin
        match eval env e1 with
          | VBool true -> eval env e2
          | VBool false -> eval env e3
          | _-> raise (TypeError "if")
      end
    | Let (x,e1,e2) ->
      let v1= eval env e1 in 
         eval (Env.add (x, v1) env) e2
  let interpret: program -> value
  =fun pgm -> eval Env.empty pgm;;
  
