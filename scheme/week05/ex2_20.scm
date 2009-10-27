#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.18
; ... write a procedure same-parity that takes one or more integers and returns a list
; of all the arguments that have the same even-odd parity as the first argument. For example,
; (same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
; (same-parity 2 3 4 5 6 7)
; (2 4 6)

(define (empty? items)
 (zero? (length items)))

(define (filter filter-function items)
 (if (empty? items)
  items
   (let ((head (car items)) (tail (cdr items)))
         (if (filter-function head)
          (cons head (filter filter-function tail))
          (filter filter-function tail)))))

; This was working but was adding things in reverse order...
; (define (filter-iter filtered items)
;  (if (empty? items)
;   filtered
;   (let ((head (car items)))
;     (filter-iter
;      (if (filter-function head)
;       (cons head filtered)
;       filtered)
;      (cdr items)))))
; (filter-iter (list) items))

(define (same-parity . numbers)
 (if (empty? numbers)
  numbers
   (let ((parity-function (if (even? (car numbers)) even? odd?)))
    (filter parity-function numbers))))

(check-equal? (same-parity) (list))
(check-equal? (same-parity 1) (list 1))
(check-equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7))
(check-equal? (same-parity 2 3 4 5 6 7) (list 2 4 6))
