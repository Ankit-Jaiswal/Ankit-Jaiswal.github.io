
-----------------------  Prime Factorisation theorem using bezoults lemma --------------

module ankit-project where

---- basics ---

data _×_  (A B : Set) : Set where
  [_,_] : A → B → A × B

p₁ : {A B : Set} → A × B → A
p₁ ([ a , b ]) = a

p₂ : {A B : Set} → A × B → B
p₂ ([ a , b ]) = b


data _⊕_  (A B : Set) : Set where
  ι₁ : A → A ⊕ B
  ι₂ : B → A ⊕ B 


data Σ (A : Set) (B : A → Set) : Set where
  [_,_] : (a : A) → (B a) → Σ A B

proj₁ : {A : Set} → {B : A → Set} → Σ A B → A
proj₁ ([ a , b ]) = a 

proj₂ : {A : Set} → {B : A → Set} → (ab : Σ A B) → (B (proj₁ ab))
proj₂ ([ a , b ]) = b 


data _==_ {A : Set} : A → A → Set where
  refl : (a : A) → a == a

sym : {A : Set} → {x y : A} → x == y → y == x
sym (refl a) = refl a

_&&_ : {A : Set} → {x y z : A} → x == y → y == z  → x == z
_&&_ (refl a) (refl .a) = refl a


---------------------------- Natural no. ----------------------------------------

data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ

{-# BUILTIN NATURAL ℕ #-}

_+_ : ℕ → ℕ → ℕ
zero + m = m
(succ n) + m = succ(n + m)

_·_ : ℕ → ℕ → ℕ
zero · m = zero
(succ n)· m = (n · m) + m



==p1 : {x y : ℕ} → x == y → (succ x) == (succ y) --- this defined property says that if x = y then x+1 = y+1 .
==p1 (refl a) = refl (succ a)  


data _≤_ : ℕ → ℕ → Set where                    ---  m less than or equalt to n if ∃ k such that k+m = n.
  because_ : {m n : ℕ} → Σ ℕ (λ k → (k + m) == n) → m ≤ n

≤p1 : {m n : ℕ} → m ≤ n → m ≤ (succ n)          --- this defined property says that if m ≤ n then m ≤ n+1.
≤p1 (because [ k , k+m=n ]) = because [ succ k , ==p1 k+m=n ]

_-_as_ : (n : ℕ) → (m : ℕ) → m ≤ n → ℕ         --- this defines subtraction exactly when m ≤ n .
n - m as because [ k , k+m=n ] = k 



data _div_ : ℕ → ℕ → Set where             ---  m divides n if ∃ k such that k·m = n . Note that 0 div 0 is possible.
  because_ : {m n : ℕ} → Σ ℕ (λ k → (k · m) == n) → m div n

_÷_as_ : (n : ℕ) → (m : ℕ) → m div n → ℕ
n ÷ m as because [ k , k·m=n ] = k


--==p2 : (x : ℕ) → (y : ℕ) → (α : ℕ) → (α + x) == (α + y) → x  == y
--==p2 x y α (refl α+x) = refl (α+x - α as because [ y , refl α+x ])

--div-p1 : {a b : ℕ} → {pf : a ≤ b} → (m : ℕ) → a ≤ b → ((m div a) × (m div b) → (m div (b - a as pf)))
--div-p1 0 because [ k₁ ,  a+k1=b ] = λ [ 0-div-a , 0-div-b ] → because [ 1 , refl 0 ]
--div-p1 (succ m) because [ k₁ , a+k1=b ] = λ [ because [ k₂ , k2·(m+1)=a ] , because [ k₃ , k3·(m+1)=b ] ] → 

--lemma1 : {m a b : ℕ} → a ≤ b  → {pf : a ≤ b} → ((m div a) × (m div b) → (m div a) × (m div (b - a as pf))) × 
--lemma1 (because [ k₁ , k₁+a=b ]) = λ [ because [ k₂ , k₂·m=a ] , because [ k₃ , k₃·m=b ] ] → [ because [ 


--------- Prime no. ---------

data _prime : ℕ → Set where
  beacuse_ : {p k : ℕ} → (2 ≤ p) × ((k div p) → (k == p) ⊕ (k == 1)) → p prime












