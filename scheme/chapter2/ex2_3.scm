#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.3
; Implement a representation for rectangles in a plane. (Hint: You may want to make use of
; exercise 2.2.) In terms of your constructors and selectors, create procedures that compute the perimeter
; and the area of a given rectangle. Now implement a different representation for rectangles. Can you
; design your system with suitable abstraction barriers, so that the same perimeter and area procedures will
; work using either representation?

(define make-point cons)
(define x-point car)
(define y-point cdr)

(define make-dimension cons)
(define dimension-width car)
(define dimension-height cdr)

(define (make-rectangle top-left-x top-left-y width height)
 (cons (make-point top-left-x top-left-y) (make-dimension width height)))

(define rectangle-top-left-point car)
(define rectangle-dimension cdr)

(define (rectangle-height rectangle)
  (dimension-height (rectangle-dimension rectangle)))

(define (rectangle-width rectangle)
  (dimension-width (rectangle-dimension rectangle)))

(define (rectangle-area rectangle)
  (* (rectangle-width rectangle) (rectangle-height rectangle)))

(define (rectangle-perimeter rectangle)
  (+ (* 2 (rectangle-width rectangle)) (* 2 (rectangle-height rectangle))))

(check-equal? (rectangle-area (make-rectangle 0 0 5 10)) 50)
(check-equal? (rectangle-perimeter (make-rectangle 0 0 5 10)) 30)
