#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.33.
; Fill in the missing expressions to complete the following definitions of some basic
; list-manipulation operations as accumulations:
;
; (define (map p sequence)
;   (accumulate (lambda (x y) <??>) nil sequence))
; (define (append seq1 seq2)
;   (accumulate cons <??> <??>))
; (define (length sequence)
;   (accumulate <??> 0 sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (map p sequence)
 (accumulate (lambda (first rest) (cons (p first) rest)) null sequence))
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length sequence)
 (accumulate (lambda (first rest) (+ 1 rest)) 0 sequence))

(define (square x) (* x x))

(check-equal? (map square (list 2 4)) (list 4 16))
(check-equal? (append (list 0 1) (list 2 4)) (list 0 1 2 4))
(check-equal? (length (list 2 4 1)) 3)
