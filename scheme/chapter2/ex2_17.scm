#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.17
; Define a procedure last-pair that returns the list that contains only the last element
; of a given (nonempty) list:
; (last-pair (list 23 72 149 34))
; (34)

(define (last-pair items)
  (let ((num-head-items (- (length items) 1)))
    (define (last-pair-iter sub-list n)
     (if (= num-head-items n)
      (cdr sub-list)
      (last-pair-iter (cdr sub-list) (+ n 1))))
    (if (<= num-head-items 0)
     items
      (last-pair-iter items 1))))

(check-equal? (last-pair (list)) (list))
(check-equal? (last-pair (list 42)) (list 42))
(check-equal? (last-pair (list 23 42)) (list 42))
(check-equal? (last-pair (list 23 72 149 34)) (list 34))
