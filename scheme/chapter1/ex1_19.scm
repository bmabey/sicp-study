#lang scheme/base
(require (planet schematics/schemeunit:3))

; SICP Exercise 1.19
; My alegraba for this problem can be found in ex1_19.tex.  I should really look into SLaTeX...

(define (fib-tree-recusive-process n)
 (cond ((= n 0) 0)
  ((= n 1) 1)
  (else
   (+ (fib-tree-recusive-process (- n 1)) (fib-tree-recusive-process (- n 2))))))


(define (fib-iterative-process n)
 (define (fib-iter a b count)
  (if (= count 0)
    b
    (fib-iter (+ a b) a (- count 1))))

 (fib-iter 1 0 n))

(define (square x) (* x x))

(define (fib-log n)
 (define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter
          a
          b
          (+ (square p) (square q)) ; compute p'
          (+ (* 2 p q) (square q))  ; compute q'
          (/ count  2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                 (+ (* b p) (* a q))
                 p
                 q
                 (- count 1)))))
  (fib-iter 1 0 0 1 n))


(define (expmod base exp m) 
  (cond ((= exp 0) 1) 
        ((even? exp) 
         (remainder (square (expmod base (/ exp 2) m)) 
                    m))
        (else 
         (remainder (* base (expmod base (- exp 1) m)) 
                    m))))


(check-eq? (fib-tree-recusive-process 8) 21)
(check-eq? (fib-iterative-process 8) 21)
(check-eq? (fib-log 8) 21)
(check-eq? (fib-log 20) 6765)
