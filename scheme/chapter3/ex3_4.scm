#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 3.4.
; Modify the make-account procedure of exercise 3.3 by adding another local state
; variable so that, if an account is accessed more than seven consecutive times with an incorrect password,
; it invokes the procedure call-the-cops.

(define (make-monitored fn)
 (let ((times-called 0))
  (lambda args
   (if (eq? 'how-many-calls? (car args))
    times-called
   (begin
    (set! times-called (+ times-called 1))
    (apply fn args))))))

(define (inc x) (+ x 1))

(define call-the-cops
  (make-monitored (lambda args "Wra-wro")))

(define (make-account balance password)
 (let ((consecutive-count 0))
  (define (inc-count)
   (begin
    (set! consecutive-count (inc consecutive-count))
    (if (< 7 consecutive-count) (call-the-cops consecutive-count) '())))
  (define (reset-count)
   (set! consecutive-count 0))
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
    (define (dispatch p m)
     (if (not (eq? p password))
      (begin
       (inc-count)
       (lambda args "Incorrect password"))
      (begin
        (reset-count)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m))))))
  dispatch))

(let ((acc (make-account 100 'secret-password)))
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'secret-password 'deposit) 50) 150) ; successful attempt should reset counter
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? (call-the-cops 'how-many-calls?) 0)
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? (call-the-cops 'how-many-calls?) 1)
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? (call-the-cops 'how-many-calls?) 2)
 (check-equal? ((acc 'secret-password 'deposit) 50) 200) ; successful attempt should reset counter
 (check-equal? (call-the-cops 'how-many-calls?) 2)
 (check-equal? ((acc 'wrong-password 'deposit) 50) "Incorrect password")
 (check-equal? (call-the-cops 'how-many-calls?) 2))
