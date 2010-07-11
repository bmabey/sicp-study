#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.1.
; Define a better version of make-rat that handles both positive and negative arguments.
; Make-rat should normalize the sign so that if the rational number is positive, both the numerator and
; denominator are positive, and if the rational number is negative, only the numerator is negative.

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (make-rat n d)
  (define (make n d)
    (let ((g (abs (gcd n d))))
      (cons (/ n g) (/ d g))))
  (if (< d 0)
      (make (- n) (- d))
      (make n d)))


(check-equal? (make-rat 1 2) (cons 1 2))
(check-equal? (make-rat -1 2) (cons -1 2))
(check-equal? (make-rat 1 -2) (cons -1 2))
(check-equal? (make-rat -1 -2) (cons 1 2))

(check-equal? (make-rat 2 4) (cons 1 2))
(check-equal? (make-rat -2 4) (cons -1 2))
(check-equal? (make-rat 2 -4) (cons -1 2))
(check-equal? (make-rat -2 -4) (cons 1 2))
