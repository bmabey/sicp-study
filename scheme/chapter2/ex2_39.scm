#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.39
; Complete the following definitions of reverse (exercise 2.18) in terms of
; fold-right and fold-left from exercise 2.38:
; (define (reverse sequence)
;   (fold-right (lambda (x y) <??>) nil sequence))
; (define (reverse sequence)
;   (fold-left (lambda (x y) <??>) nil sequence))
;
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define fold-right accumulate)

(define (reverse-right sequence)
  (fold-right (lambda (x y) (append y (list x))) null sequence))

(define (reverse-left sequence)
  (fold-left (lambda (x y) (append (list y) x)) null sequence))

(check-equal? (reverse-right (list)) (list))
(check-equal? (reverse-right (list 42)) (list 42))
(check-equal? (reverse-right (list 23 42)) (list 42 23))
(check-equal? (reverse-right (list 23 72 149 34)) (list 34 149 72 23))

(check-equal? (reverse-left (list)) (list))
(check-equal? (reverse-left (list 42)) (list 42))
(check-equal? (reverse-left (list 23 42)) (list 42 23))
(check-equal? (reverse-left (list 23 72 149 34)) (list 34 149 72 23))

