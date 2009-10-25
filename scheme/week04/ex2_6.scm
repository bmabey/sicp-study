#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.6.
; In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a
; language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative
; integers are concerned) by implementing 0 and the operation of adding 1 as
;
; (define zero (lambda (f) (lambda (x) x)))
; (define (add-1 n)
;   (lambda (f) (lambda (x) (f ((n f) x)))))
;
; This representation is known as Church numerals, after its inventor, Alonzo Church, the logician who
; invented lambda calculus.
;
; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to evaluate
; (add-1 zero)). Give a direct definition of the addition procedure + (not in terms of repeated
; application of add-1).


(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
 (lambda (f) (lambda (x) (f ((n f) x)))))


; In order to determine how to define one directly we can, as suggested, use the substitution method
; on (add-1 zero). Note: I am using g and y instead of f and x for the variables in the zero lambdas
; to avoid confusion.
;
; (add-1 zero)
; (lambda (f) (lambda (x) (f ((zero f) x))))
; (lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) y)) f) x))))
;
; At this point we are done expanding it but we can simplify it down.
; With zero fully expanded we see it takes one argument (called g) which it simply ignores and returns
; (lambda (y) y), also know as the identity function.  The argument that the outer 'zero' lambda is provided,
; and ignores, is f.  So the f is removed leaving only the identity function:
;
; (lambda (f) (lambda (x) (f (identity x))))
;
; Which then simplifies to:
;
; (lambda (f) (lambda (x) (f x)))
;
; This is our direct definition of one:

(define one (lambda (f) (lambda (x) (f x))))

; With that definition we can reason about creating a procedure which can give us real numbers from the
; Church numerals being represented as lambdas.
; (idea and procedure courtesy of http://www.kendyck.com/archives/2007/07/07/solution-to-sicp-26/)
(define (to-integer n)
  (define (inc x) (+ 1 x))
  ((n inc) 0))

(check-equal? (to-integer one) 1)

; Now, lets do the same thing to obtain the direct definition of two using one as a starting point.
;
; (add-1 one)
; (lambda (f) (lambda (x) (f ((one f) x))))
; (lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) (g y))) f) x))))
;
; Lets start by taking f for g in the outer 'one' lambda:
; (lambda (f) (lambda (x) (f ((lambda (y) (f y)) x))))
;
; We can now apply x as y to get our definition of two:
; (lambda (f) (lambda (x) (f (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(check-equal? (to-integer two) 2)

; For a general way of adding Church numbers I find it easiest to think of the process in terms
; of composing the given lambdas/procedures.  In exercise 1.42 we came up with the following compose:

(define (compose f g) (lambda (x) (f (g x))))

; With this we can compose the Church numerals by passing along the 'f' lambda they need to operate:

(define (add a b)
 (lambda (f) (compose (a f) (b f))))

(check-equal? (to-integer (add one two)) 3)
