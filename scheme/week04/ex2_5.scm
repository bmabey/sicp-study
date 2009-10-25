#lang scheme/base
(require (planet schematics/schemeunit:3))

; Exercise 2.5
; Show that we can represent pairs of nonnegative integers using only numbers and 
; arithmetic operations if we represent the pair a and b as the integer that is the product 2^a3^b. Give the 
; corresponding definitions of the procedures cons, car, and cdr.

(define (root x r)
 (expt x (/ 1 r)))

(define (cbrt x) (root x 3))

(define (cons a b)
 (* (expt 2 a) (expt 3 b)))

(define (count-factors n p)
  (if (zero? (remainder p n)) (+ 1 (count-factors n (/ p n)))
      0))

; Gonna curry just because I can... Probably not the best for debugging and doesn't save me anything...
(define (curry f x) (lambda args (apply f x args)))
(define car (curry count-factors 2))
(define cdr (curry count-factors 3))

(check-equal? (cons 2 3) 108)

(check-equal? (car (cons 0 3)) 0)
(check-equal? (cdr (cons 0 3)) 3)

(check-equal? (car (cons 4 3)) 4)
(check-equal? (cdr (cons 4 3)) 3)

(check-equal? (car (cons 4 0)) 4)
(check-equal? (cdr (cons 4 0)) 0)
