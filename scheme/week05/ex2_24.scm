; Exercise 2.24
; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). Give the 
; result printed by the interpreter, the corresponding box-and-pointer structure, and the interpretation of 
; this as a tree (as in figure 2.6)
;
; It would evaluate to:
; (1 (2 (3 4)))
;
; ASCII art FTW:
;
; (1 (2 (3 4)))
;     /\
;    1  (2 (3 4))
;     /     \
;   2       (3 4)
;           /  \
;          3    4
