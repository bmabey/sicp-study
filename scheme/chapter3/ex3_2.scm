#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 3.2
; In software-testing applications, it is useful to be able to count the number of times a given
; procedure is called during the course of a computation. Write a procedure make-monitored that takes
; as input a procedure, f, that itself takes one input. The result returned by make-monitored is a third
; procedure, say mf, that keeps track of the number of times it has been called by maintaining an internal
; counter. If the input to mf is the special symbol how-many-calls?, then mf returns the value of the
; counter. If the input is the special symbol reset-count, then mf resets the counter to zero. For any
; other input, mf returns the result of calling f on that input and increments the counter. For instance, we
; could make a monitored version of the sqrt procedure:
; (define s (make-monitored sqrt))
; (s 100)
; 10
; (s 'how-many-calls?)
; 1

(define (square x)
 (* x x))

(define (make-monitored fn)
 (let ((times-called 0))
  (lambda args
   (if (eq? 'how-many-calls? (car args))
    times-called
   (begin
    (set! times-called (+ times-called 1))
    (apply fn args))))))

(let ((monitored-square (make-monitored square)))
 (check-equal? (monitored-square 2) 4)
 (check-equal? (monitored-square 3) 9)
 (check-equal? (monitored-square 'how-many-calls?) 2))
