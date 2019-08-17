prelude

inductive bool : Type :=
| tt : bool
| ff : bool

inductive nat : Type :=
| zero : nat
| succ : nat → nat

inductive fin : nat → Type :=
| fz : Π n:nat, fin (nat.succ n)
| fs : Π {n:nat}, fin n → fin (nat.succ n)



namespace bool
definition not: bool → bool := bool.rec ff tt

definition and: bool → bool → bool := bool.rec (bool.rec tt ff) (bool.rec ff ff)

definition if_then_else {A : Type} (x: A) (y: A) : bool → A  := bool.rec x y 
end bool



namespace nat
definition pred: nat → nat := nat.rec zero (λ (n:nat) (v:nat), n )

definition add: nat → nat → nat := λ m:nat, nat.rec m (λ (n:nat), succ ) 

definition mult: nat → nat → nat := λ m:nat, nat.rec zero (λ (n:nat), nat.add n )

definition eq: nat → nat → bool := nat.rec (nat.rec bool.tt (λ (n:nat) (b:bool), bool.ff)) (λ (n:nat) (f: nat → bool), nat.rec bool.ff (λ (k:nat) (b:bool), f k ) ) 

end nat


 
namespace fin
definition inc {n: nat} (k: fin n) : nat := fin.rec_on k (λ n:nat, nat.zero) ( λ (n:nat) (k:fin n), nat.succ ) 

definition phi : Π n:nat, fin (nat.succ n)  :=  nat.rec (fz nat.zero) (λ (m:nat) (k: fin (nat.succ m)), (fs (fz m) ) )

definition cyc {n :nat} (k: fin n) : fin n := fin.rec_on k (phi) (λ (n:nat)(k: fin n)(v: fin n), bool.if_then_else (fz n) (fs v) (nat.eq  (inc v) nat.zero ) )
end fin




inductive empty : Type

inductive unit : Type :=
star : unit


definition mod (p: nat) : nat → fin (nat.succ p) := nat.rec (fin.fz p) (λ (n:nat)(k:fin (nat.succ p)), fin.cyc k) 
/- mod p k, means k modulo p+1   -/


definition isTrue : bool → Type.{0} := bool.rec unit empty 




inductive mod_rel : nat → nat → nat → Type :=       /- mod-rel p m n is nothing but type for m=n modulo p+1  -/
cs : Π (p:nat)(m:nat)(n:nat), isTrue(nat.eq (fin.inc (mod p m)) (fin.inc (mod p n))) → mod_rel p m n



/-
thm1 : Π {p:nat} {m:nat} {n:nat} (k:nat),  (mod_rel p m n) →  ( mod_rel p (nat.add m k) (nat.add n k) )
thm1 k (cs p m n star) := cs p (nat.add m k) (nat.add n k) star 
-/


/-
thm2 : Π {p:nat} {m:nat} {n:nat} (k:nat),  mod_rel p m n →  mod_rel p (nat.mult m k) (nat.mult n k)
thm2 k (cs p m n star) := cs p (nat.mult m k) (nat.add n k) star
-/
