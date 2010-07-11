#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.18
; Define a procedure reverse that takes a list as argument and returns a list of the same
; elements in reverse order:
; (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)

(define (empty? items)
 (zero? (length items)))

(define (reverse items)
 (define (reverse-iter reversed items)
  (if (empty? items)
   reversed
   (reverse-iter (cons (car items) reversed) (cdr items))))
  (reverse-iter (list) items))

(check-equal? (reverse (list)) (list))
(check-equal? (reverse (list 42)) (list 42))
(check-equal? (reverse (list 23 42)) (list 42 23))
(check-equal? (reverse (list 23 72 149 34)) (list 34 149 72 23))
