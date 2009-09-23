;; Exercise 1.7.
;; The good-enough? test used in computing square roots will not be very effective for
;; finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost
;; always performed with limited precision. This makes our test inadequate for very large numbers. Explain
;; these statements, with examples showing how the test fails for small and large numbers. An alternative
;; strategy for implementing good-enough? is to watch how guess changes from one iteration to the
;; next and to stop when the change is a very small fraction of the guess. Design a square-root procedure
;; that uses this kind of end test. Does this work better for small and large numbers?

; The problem with the good-enough? procedure for small numbers is that there radicant is much smaller than
; the 0.001 hardcoded threshold.  The logic prevents the improvement of the guess past this threshold.
; For example, the square-root of 0.005 is ~0.007110678 but the computed value with the 0.001 threshold
; is 0.031781009679092864 since the logic prevents any further improvements.
;
; The problem with large numbers is you enter an endless loop as the program is unable to improve the guess
; any further.  An example of this is (sqrt 123456789012345678901234567890). At some point the value of the guess
; becomes 4.4351364182882e16 and the improve guess continues to return the same value unable to improve it.  As
; the question alluded to math on computers is done with limited precision. This fact is evident as the floating
; point value guess is not changed with subsequent applications of improve on it and the original number.
;
; Below is my implementation of the proposed solution.  Instead of having a good-enough? function I introduced a
; within-delta? function that sqrt-iter used to compare old and current guesses.  To enable this state to be carried
; by all the recursive calls I added it as an argument to the sqrt-iter.  With this solution small and large numbers
; are computed correctly.

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (within-delta? x y delta)
  (<= (abs (- x y)) delta))


(define (sqrt-iter old-guess guess x)
  (if (within-delta? old-guess guess 0.000001)
      guess
      (sqrt-iter guess (improve guess x)
                 x)))

(define (sqrt x)
  (sqrt-iter 0.0 1.0 x))

(sqrt 9)

(sqrt (+ 100 37))

(sqrt (+ (sqrt 2) (sqrt 3)))

(square (sqrt 1000))

(sqrt 0.005)
(sqrt 123456789012345678901234567890)
