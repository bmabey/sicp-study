#lang planet neil/sicp
; SICP exercise 1.23

(define (square x) (* x x))


(define (prime? n)
  (define (next test-divisor)
    (if (= test-divisor 2) 3
        (+ test-divisor 2)))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (define (divides? a b)
    (= (remainder b a) 0))
  
  (define (smallest-divisor n)
    (find-divisor n 2))

  (= n (smallest-divisor n)))




(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      0))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
   1)

(define (find-three-primes starting-num)
  (define (loop num primes-found)
    (if (= primes-found 3) true
        (loop (+ num 2) (+ primes-found (timed-prime-test num)))))
  (newline)
  (loop (+ 1 starting-num) 0))

; When ran with the extra checks I got these times:
;(find-three-primes 100000000000000) ; (+ 13032210 13068029 12948528) # => 39048767
; After I implemented the next procedure I got:
;(find-three-primes 100000000000000) ; (+ 6929346 6756755 6998871) # => 20684972
; So, it is about half as fast as the orginal as you would expect it to be since we avoid half of the calls to find-divisor.


