#lang scheme/base
(require (planet schematics/schemeunit:3))

(define (cube x) (* x x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (integral-simpsons f a b n)
 (let ((h (/ (- b a) n)))

  (define (y-k k)
   (let ((y (f (+ a (* k h)))))
    (cond ((or (= k n) (= k 0)) y)
          ((even? k) (* 2 y))
          (else (* 4 y)))))

  (define (loop k total)
   (if (> k n) total
       (loop (+ k 1) (+ total (y-k k)))))

  (* (/ h 3) (loop 0 0))))


(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)

     dx))

(integral cube 0 1 0.01)
(integral cube 0 1 0.001)
(integral cube 0 1 0.0001)

(integral-simpsons cube 0 1 2)
(integral-simpsons cube 0 1 100)
(integral-simpsons cube 0 1 1000)

; The integral method from the book even after 1000 iterations is unable to arrive to the correct solution.
; (It approximates to 0.24999999874993412 after 1000.)  However, Simpson's method finds the exact answer
; even with n just set to 2.

