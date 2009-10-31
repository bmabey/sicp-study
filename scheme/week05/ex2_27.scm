#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.27
; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse
; procedure that takes a list as argument and returns as its value the list with its elements reversed and with
; all sublists deep-reversed as well. For example,
; (define x (list (list 1 2) (list 3 4)))
; x
; ((1 2) (3 4))
; (reverse x)
; ((3 4) (1 2))
; (deep-reverse x)
; ((4 3) (2 1))


(define (reverse items)
 (define (reverse-iter reversed items)
  (if (null? items)
   reversed
   (reverse-iter (cons (car items) reversed) (cdr items))))
  (reverse-iter (list) items))

(define (deep-reverse items)
  (define (reverse-iter reversed items)
    (cond ((null? items) reversed)
          ((not (pair? items)) items)
          (else (reverse-iter
                 (cons (deep-reverse (car items)) reversed)
                 (cdr items)))))
  (reverse-iter (list) items))

(check-equal? (reverse (list)) (list))
(check-equal? (reverse (list 42)) (list 42))
(check-equal? (reverse (list 23 42)) (list 42 23))
(check-equal? (reverse (list 23 72 149 34)) (list 34 149 72 23))

(let ((x (list (list 1 2) (list 3 4))))
  (check-equal? (reverse x) (list (list 3 4) (list 1 2)))
  (check-equal? (deep-reverse x) (list (list 4 3) (list 2 1))))
