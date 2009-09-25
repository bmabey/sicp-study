#lang scheme/base
(require (planet schematics/schemeunit:3))

;; Exercise 1.8.  Newton's method for cube roots is based on the fact that if y is an approximation to the
;; cube root of x, then a better approximation is given by the value
;; ((x / y^2) + 2y) / 3
;; Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In
;; section 1.3.4 we will see how to implement Newton's method in general as an abstraction of these
;; square-root and cube-root procedures.)



; square and within-delta? seem reasonably helpful/general so I'm not boxing them in to cbrt
(define (square x)
  (* x x))

(define (within-delta? x y delta)
  (<= (abs (- x y)) delta))

(define (cbrt x)
  (define (improve guess x)
   (/ (+ (/ x (square guess)) (* 2 guess)) 3))
  (define (cbrt-iter old-guess guess x)
    (if (within-delta? old-guess guess 0.000001)
        guess
        (cbrt-iter guess (improve guess x)
                   x)))

  (cbrt-iter 0.0 1.0 x))

(check-= (cbrt 27) 3.0 0.000001)
(check-= (cbrt 8E-15) 2E-5 1.0)
(check-= (cbrt 8E15) 2E5 1.0)
