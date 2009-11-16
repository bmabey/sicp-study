#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.40
; Define a procedure unique-pairs that, given an integer n, generates the sequence of
; pairs (i,j) with 1< j< i< n. Use unique-pairs to simplify the definition of prime-sum-pairs
; given above.


(define (inc x) (+ 1 x))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
    null
    (cons low (enumerate-interval (+ low 1) high))))

; (define (pairs coll)
;  (define (loop pairs remaining-coll)
;   (if (< (length remaining-coll) 2)
;    pairs
;    (loop (cons (list (car remaining-coll) (cadr remaining-coll)) pairs) (cdr remaining-coll))))
;  (loop '() coll))


(define (unique-pairs n)
  (flatmap
   (lambda (j) (map
                (lambda (i) (cons j i))
                (enumerate-interval j n)))
   (enumerate-interval 1 n)))

;(check-equal? (pairs '(1 2 3)) '((2 3) (1 2)))
(check-equal? (unique-pairs 3) '((1 . 1) (1 . 2) (1 . 3) (2 . 2) (2 . 3) (3 . 3)))

