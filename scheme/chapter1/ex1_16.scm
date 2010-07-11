#lang scheme/base
(require (planet schematics/schemeunit:3))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

; recursive process
(define (fast-expt-recur b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-recur b (/ n 2))))
        (else (* b (fast-expt-recur b (- n 1))))))

; iterative process
(define (fast-expt b n)
  (define (fast-expt-incr b n a)
    (cond ((zero? n) a )
          ((even? n) (fast-expt-incr (square b) (/ n 2) a))
          (else (fast-expt-incr b (- n 1) (* b a)))))
   (fast-expt-incr b n 1))

(check-eq? (fast-expt-recur 0 23) 0)
(check-eq? (fast-expt-recur 1 23) 1)
(check-eq? (fast-expt-recur 2 2) 4)
(check-eq? (fast-expt-recur 2 8) 256)
(check-eq? (fast-expt-recur 3 7) 2187)

(check-eq? (fast-expt 0 23) 0)
(check-eq? (fast-expt 1 23) 1)
(check-eq? (fast-expt 2 2) 4)
(check-eq? (fast-expt 2 8) 256)
(check-eq? (fast-expt 3 7) 2187)
