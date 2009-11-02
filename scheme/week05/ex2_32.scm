#lang scheme/base
(require (planet schematics/schemeunit:3))
; Exercise 2.33
; We can represent a set as a list of distinct elements, and we can represent the set of all
; subsets of the set as a list of lists. For example, if the set is (1 2 3), then the set of all subsets is
; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). Complete the following definition of a
; procedure that generates the set of subsets of a set and give a clear explanation of why it works:
; (define (subsets s)
;   (if (null? s)
;       (list nil)
;       (let ((rest (subsets (cdr s))))
;         (append rest (map <??> rest)))))

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s)))
            (head (car s)))
        (append rest (map (lambda (x) (cons head x)) rest)))))

(check-equal? (subsets (list 1 2 3))
              (list (list) (list 3) (list 2) (list 2 3) (list 1) (list 1 3) (list 1 2) (list 1 2 3)))

; To come up with this solution I assumed I had a working subsets procedure.  With that assumption I then
; looked at what I would have for 'rest' in the case of {1 2 3} and what would be needed for the map's lambda.
; In this example 'rest' would be the subsets of {2 3} which are {0 {2} {3}}. I observed that the subsets of
; {1 2 3} are the subsets of {2 3} 'union'ed with those subsets intersected with the set {1}: {{1} {1 2} {1 3}}
; The append procedure (union) takes care of combining the 'rest' subsets with the other subsets yielding 
; The key observation, then, is that the subset of set s is equal to s' U t where s' is the 
; subset for s - {i} (given i ∈ s), and t is the set of each subset s'_j intersected with i.
