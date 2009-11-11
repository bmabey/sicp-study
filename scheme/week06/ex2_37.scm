#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.37
; Fill in the missing expressions in the following procedures for computing the other matrix operations.
; (The procedure accumulate-n is defined in exercise 2.36.)
; (define (matrix-*-vector m v)
;   (map <??> m))
; (define (transpose mat)
;   (accumulate-n <??> <??> mat))
; (define (matrix-*-matrix m n)
;   (let ((cols (transpose n)))
;     (map <??> m)))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (curry f x) (lambda args (apply f x args)))

(define (matrix-*-vector m v)
  (map (curry dot-product v) m))

(define (transpose mat)
  (accumulate-n cons null mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (curry matrix-*-vector cols) m)))



(check-equal?
 (dot-product '(1 2 3 4) '(1 2 3 4))
 (+ (* 1 1) (* 2 2) (* 3 3) (* 4 4))
 )

(check-equal?
 (matrix-*-vector '((1 3 5) (2 4 6)) '(1 2 3))
 '(22 28)
 )

(check-equal?
 (transpose '((1 3) (2 4)))
 '((1 2) (3 4))
 )

(check-equal?
 (transpose '((1 4 7) (2 5 8) (3 6 9)))
 '((1 2 3) (4 5 6) (7 8 9))
 )

(check-equal?
 (matrix-*-matrix '((1 4 7) (2 5 8) (3 6 9)) '((1 4 7) (2 5 8) (3 6 9)))
 '((30 66 102) (36 81 126) (42 96 150))
 )
