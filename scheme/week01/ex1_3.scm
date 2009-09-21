;; SICP 1.3

;; Exercise 1.3. Define a procedure that takes three numbers as
;; arguments and returns the sum of the squares of the two larger
;; numbers.

(define (square x) (* x x))
(define (squared-sum x y)
  (+ (square x) (square y))
  )

(define (squared-sum-of-two-greatest x y z)
  (if (> x y)
      (if (> y z)
          (squared-sum x y)
          (squared-sum x z)
          )
      (if (> x z)
          (squared-sum y x)
          (squared-sum y z)
          )
      )
  )

(squared-sum-of-two-greatest 2 1 3)
; # => 13
(squared-sum-of-two-greatest 5 5 9)
; # => 106
(squared-sum-of-two-greatest 1 3 4)
; # => 25
