#lang planet neil/sicp

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
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

;(sqrt 10) => 3.1622776601683795
(find-three-primes 1000) ; (+ 23 23 22) =>  68 
(find-three-primes 10000) ; (+ 59 59 59) => 177: 2.6029411764705883x slower
(find-three-primes 100000); (+ 174 305 176) => 655: 3.7005649717514126x slower
(find-three-primes 1000000); (+ 549 568 563) => 1680: 2.564885496183206x slower

(find-three-primes 100000000000)  ; (+ 481263 410991 435095) => 1327349
(find-three-primes 1000000000000)  ; (+ 1337185 1315346 1309145) => 3961676: 2.7784911784201154x slower
(find-three-primes 10000000000000) ; (+ 4159272 4121860 4173517) => 12454649: 3.1437828333260973x slower
(find-three-primes 100000000000000) ; (+ 13032210 13068029 12948528) => 39048767: 3.1352763935780126x slower


; When I bump the numbers up higher I see the (sqrt 10) slowdown that is expected for the algorhtim showing that it is indeed theta(sqrt(n)) runtime.


