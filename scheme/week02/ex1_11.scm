#lang scheme/base
(require (planet schematics/schemeunit:3))

; recursive process
(define (f n)
  (if (< n 3)
        n
        (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

; iterative process
(define (fi n)
 (define (f-iter x y z max-count)
  (if (= max-count 0)
      z
      (f-iter (+ x (* 2 y) (* 3 z)) x y (- max-count 1))))

  (f-iter 2 1 0 n)
  )

(check-eq? (f 2) 2)
(check-eq? (f 3) 4)
(check-eq? (f 4) 11)

(check-eq? (fi 2) 2)
(check-eq? (fi 3) 4)
(check-eq? (fi 4) 11)
(check-eq? (fi 20) (f 20))



