#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.56
; Show how to extend the basic differentiator to handle more kinds of expressions. For
; instance, implement the differentiation rule
; by adding a new clause to the deriv program and defining appropriate procedures
; exponentiation?, base, exponent, and make-exponentiation. (You may use the symbol
; ** to denote exponentiation.) Build in the rules that anything raised to the power 0 is 1 and anything
; raised to the power 1 is the thing itself.

(define variable? symbol?)

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (make-expt base exponent)
 (cond ((and (number? base) (number? exponent)) (expt base exponent))
        ((and (variable? base) (=number? exponent 1)) base)
        ((and (variable? base) (=number? exponent 0)) 1)
        ((and (variable? base) (number? exponent) (list 'expt base exponent)))
        (else (error "I don't handle exponents with two variables."))))

; A sum is a list whose first element is the symbol +:
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

; The addend is the second item of the sum list:
(define addend cadr)
(define base cadr)

; The augend is the third item of the sum list:
(define augend caddr)

(define exponent caddr)

; A product is a list whose first element is the symbol *:
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (expt? x)
  (and (pair? x) (eq? (car x) 'expt)))

; The multiplier is the second item of the product list:
(define multiplier cadr)

; The multiplicand is the third item of the product list:
(define multiplicand caddr)

(define (deriv-expt expt-exp)
 (let ((base (base expt-exp))
       (exponent (exponent expt-exp)))
        (make-product exponent (make-expt base (- exponent 1)))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((expt? exp) (deriv-expt exp))
        (else (error "unknown expression type -- DERIV" exp))))

(check-equal? (deriv '(+ x 5) 'x) 1)
(check-equal? (deriv '(* x y) 'x) 'y)
(check-equal? (deriv '(expt x 4) 'x) '(* 4 (expt x 3)))
(check-equal? (deriv '(expt x 2) 'x) '(* 2 x))
