#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.59
; Implement the union-set operation for the unordered-list representation of sets.

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())

        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define make-set list)

(define (union-set set1 set2)
  (define (unionize union other-set)
    (cond ((null? other-set) union)
          ((element-of-set? (car other-set) union)
            (union-set union (cdr other-set)))
          (else
            (cons (car other-set) (unionize union (cdr other-set))))))
 (unionize (append set2) set1)) ; Using append so the sets are not modified.


(check-equal? (union-set (make-set 1 2 3 4) (make-set 3 4 5 6 7)) (make-set 1 2 3 4 5 6 7))
(check-equal? (union-set (make-set) (make-set)) (make-set))
(check-equal? (union-set (make-set 1 2) (make-set 5 6)) (make-set 1 2 5 6))
