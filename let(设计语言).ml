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
