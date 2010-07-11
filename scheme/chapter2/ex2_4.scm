#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.4.
; Here is an alternative procedural representation of pairs. For this representation, verify that
; (car (cons x y)) yields x for any objects x and y.
; (define (cons x y)
;   (lambda (m) (m x y)))
; (define (car z)
;   (z (lambda (p q) p)))
; What is the corresponding definition of cdr? (Hint: To verify that this works, make use of the
; substitution model of section 1.1.5.)

(define (cons x y)
 (lambda (m) (m x y)))

(define (car z)
 (z (lambda (p q) p)))

(define (cdr z)
 (z (lambda (p q) q)))

(check-equal? (car (cons 10 20)) 10)
(check-equal? (cdr (cons 10 20)) 20)

; What is going on here is the cons is creating a closure around x and y by returning a lambda which
; takes yet another procedure that yields the original x and y to this given procedure.
; Both the car and cdr definitions then, in turn, call the lambda (the pair) with another lambda that returns the
; appropriate variable.  For clarity the p and q should be renamed to x and y IMO.  I think the book
; authors probably realized this but didn't want to give any hints about what was going on. :)
