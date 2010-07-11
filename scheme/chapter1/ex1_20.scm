; Exercise 1.20
;
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; The process that a procedure generates is of course dependent on the rules used by the
;; interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were to
;; interpret this procedure using normal-order evaluation, as discussed in section 1.1.5. (The
;; normal-order-evaluation rule for if is described in exercise 1.5.) Using the substitution method (for
;; normal order), illustrate the process generated in evaluating (gcd 206 40) and indicate the
;; remainder operations that are actually performed. How many remainder operations are actually
;; performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?


; normal-order:
(if (= b 0) a (gcd b (r a b)))
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (r 206 40)))
(gcd 40 (r 206 40))
(if (= (r 206 40) 0) 40 (gcd (r 206 40) (r 40 (r 206 40))))
(if (= 6 0) 40 (gcd (r 206 40) (r 40 (r 206 40)))) ; 1
(gcd (r 206 40) (r 40 (r 206 40)))
(if (= (r 40 (r 206 40)) 0) (r 206 40) (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))
(if (= (r 40 6) 0) (r 206 40) (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))) ; 2
(if (= 4 0) (r 206 40) (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))) ; 3
(gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))
(if (= (r (r 206 40) (r 40 (r 206 40))) 0) (r 40 (r 206 40))  (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))
(if (= (r (r 206 40) (r 40 6)) 0) (r 40 (r 206 40))  (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))) ; 4
(if (= (r (r 206 40) 4) 0) (r 40 (r 206 40))  (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))) ; 5
(if (= (r 6 4) 0) (r 40 (r 206 40))  (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))) ; 6
(if (= 2 0) (r 40 (r 206 40))  (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))) ; 7
(gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))
(if (= (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))))))

(if (= (r (r 40 (r 206 40))  (r (r 206 40) (r 40 6))) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 8
(if (= (r (r 40 (r 206 40))  (r (r 206 40) 4)) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 9
(if (= (r (r 40 (r 206 40))  (r 6 4)) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 10
(if (= (r (r 40 (r 206 40))  2) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 11
(if (= (r (r 40 6)  2) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 12
(if (= (r 4 2) 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 13
(if (= 0 0) (r (r 206 40) (r 40 (r 206 40))) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 14
(if (= 0 0) (r (r 206 40) (r 40 6)) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 15
(if (= 0 0) (r (r 206 40) 4) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 16
(if (= 0 0) (r 6 4) (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 17
(if (= 0 0) 2 (gcd (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40))  (r (r 206 40) (r 40 (r 206 40))))))) ; 18
; remainder (r) was evaluated 18 times before the answer 2 was returned. Every single call to remainder, but one, was repeated.

; Applicative-order with the special-form of if.
(if (= b 0) a (gcd b (r a b)))
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (r 206 40)))
(if (= 40 0) 206 (gcd 40 6)) ; 1
(gcd 40 6)
(if (= 6 0) 40 (gcd 6 (r 40 6)))
(if (= 6 0) 40 (gcd 6 4)) ; 2
(gcd 6 4)
(if (= 4 0) 6 (gcd 4 (r 6 4)))
(if (= 4 0) 6 (gcd 4 2)) ; 3
(gcd 4 2)
(if (= 2 0) 4 (gcd 2 (r 4 2)))
(if (= 2 0) 4 (gcd 2 0)) ; 4
(gcd 2 0)
(if (= 0 0) 2 (gcd 0 (r 2 0))) ; --> 2
; remainder (r) was evaluated 4 times before the answer 2 was returned.
