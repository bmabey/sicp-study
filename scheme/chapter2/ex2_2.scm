#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.2
; Consider the problem of representing line segments in a plane. Each segment is
; represented as a pair of points: a starting point and an ending point. Define a constructor
; make-segment and selectors start-segment and end-segment that define the representation of
; segments in terms of points. Furthermore, a point can be represented as a pair of numbers: the x
; coordinate and the y coordinate. Accordingly, specify a constructor make-point and selectors
; x-point and y-point that define this representation. Finally, using your selectors and constructors,
; define a procedure midpoint-segment that takes a line segment as argument and returns its midpoint
; (the point whose coordinates are the average of the coordinates of the endpoints).


(define make-point cons)
(define x-point car)
(define y-point cdr)

(define (make-segment x1 y1 x2 y2)
 (cons (make-point x1 y1) (make-point x2 y2)))

(define start-segment car)
(define end-segment cdr)

(define (midpoint-segment segment)
 (let ((x1 (x-point (start-segment segment)))
       (x2 (x-point (end-segment segment)))
       (y1 (y-point (start-segment segment)))
       (y2 (y-point (end-segment segment)))
       )
 (make-point (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))))

(check-equal? (midpoint-segment (make-segment 0 0 0 10)) (make-point 0 5))
(check-equal? (midpoint-segment (make-segment -6 5 7 3)) (make-point (/ 1 2) 4))
