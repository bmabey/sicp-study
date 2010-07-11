#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.31
;  Abstract your answer to exercise 2.30 to produce a procedure tree-map with the
; property that square-tree could be defined as
; (define (square-tree tree) (tree-map square tree))

(define (square x) (* x x))

(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

(define (square-tree tree) (tree-map square tree))

(check-equal? (square-tree (list 1 (list 2 (list 3 4) 5)))
             (list 1 (list 4 (list 9 16) 25)))
