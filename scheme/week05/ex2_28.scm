#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.28
; Write a procedure fringe that takes as argument a tree (represented as a list) and
; returns a list whose elements are all the leaves of the tree arranged in left-to-right order. For example,
; (define x (list (list 1 2) (list 3 4)))
; (fringe x)
; (1 2 3 4)
; (fringe (list x x))
; (1 2 3 4 1 2 3 4)


(define (fringe tree)
 (define (loop tree leaves)
  (cond ((null? tree) leaves)
    ((not (pair? tree)) (list tree))
    (else (loop
           (cdr tree)
           (append leaves (fringe (car tree)))))))
 (loop tree (list)))

(let ((x (list (list 1 2) (list 3 4))))
  (check-equal? (fringe x) (list 1 2 3 4))
  (check-equal? (fringe (list x x)) (list 1 2 3 4 1 2 3 4)))

(check-equal? (fringe (list 1 (list 2) 3)) (list 1 2 3))
(check-equal? (fringe (list 1 2 3)) (list 1 2 3))
