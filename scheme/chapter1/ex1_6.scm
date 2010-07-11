;; Exercise 1.6.
;; Alyssa P. Hacker doesn't see why if needs to be provided as a special form. ``Why can't I
;; just define it as an ordinary procedure in terms of cond?'' she asks. Alyssa's friend Eva Lu Ator claims
;; this can indeed be done, and she defines a new version of if:
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;; Eva demonstrates the program for Alyssa:
(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0
;; Delighted, Alyssa uses new-if to rewrite the square-root program:
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
;; What happens when Alyssa attempts to use this to compute square roots? Explain.


; When Alyssa attempts to use this new-if in sqrt-iter then an endless loop will ensue.
; This is explained by applicative-order evaluation done by the interpreter, meaning the
; else-clause will always be evaluated no matter what the predicate is.
;
; This exercise puzzled me for a minute because we know the 'if' procedure works fine.  The
; answer to this puzzle was in section 1.1.6.  'cond' and 'if' are *special forms* and are
; evaluated differently than regular forms.  An if statement behaves just as you expect
; it would - it delays evaluation of any of the clauses until the predicate dictates that
; it is the appropriate clause to evaluate and return it's value.
