#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.21.  The procedure square-list takes a list of numbers as argument and returns a list of
; the squares of those numbers.
; (square-list (list 1 2 3 4))
; (1 4 9 16)
; Here are two different definitions of square-list. Complete both of them by filling in the missing
; expressions:
; (define (square-list items)
;   (if (null? items)
;       nil
;       (cons <??> <??>)))
; (define (square-list items)
;   (map <??> <??>))

(define (square x) (* x x))

(define (square-list-wo-map items)
 (if (null? items)
     null
     (cons (square (car items)) (square-list-wo-map (cdr items)))))

(define (square-list-w-map items) (map square items))

(check-equal? (square-list-w-map (list 1 2 3 4)) (list 1 4 9 16))
(check-equal? (square-list-wo-map (list 1 2 3 4)) (list 1 4 9 16))
