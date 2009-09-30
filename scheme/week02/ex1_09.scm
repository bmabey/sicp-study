;; SICP 1.9

;; Exercise 1.9.  Each of the following two procedures defines a
;; method for adding two positive integers in terms of the procedures
;; inc, which increments its argument by 1, and dec, which decrements
;; its argument by 1.

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

; The above solution is a linear recursive process because it builds of a chain
; of deferred operations which grows linearly with the supplied 'a' variable.

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

; (+ 4 5)
; (+ 3 6)
; (+ 2 7)
; (+ 1 8)
; (+ 0 9)
; 9

; This solution is a recursive *procedure* but an iterative *process* due
; to the fact that the state of the proccess is always encoded in 'a' and 'b'.

