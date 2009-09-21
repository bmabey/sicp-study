;; SICP 1.4

;; Exercise 1.4.  Observe that our model of evaluation allows for
;; combinations whose operators are compound expressions. Use this
;; observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))


; The behaviour of interest in this code sample is when the if procedure
; is evaluated it returns an operator which is then applied to the
; remaining elemetns of the list. This is interesting to me because of the
; implicit application of the operator (- or +). Since the if procedure is
; evalutaed and expanded out first it reduces to:
;  (+ a b) ; | b > 0
;  (- a b) ; | b <= 0
