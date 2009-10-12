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

(find-three-primes 1000)
(find-three-primes 10000)
(find-three-primes 100000)
(find-three-primes 1000000)

