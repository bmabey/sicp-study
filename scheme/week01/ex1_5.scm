;; SICP Exercise 1.5
;; Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is
;; using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:
(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))
;; Then he evaluates the expression
; (test 0 (p))

;; What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What
;; behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer.
;; (Assume that the evaluation rule for the special form if is the same whether the interpreter is using
;; normal or applicative order: The predicate expression is evaluated first, and the result determines
;; whether to evaluate the consequent or the alternative expression.)
;; ****
;;
;; When an interpreter uses applicative-order evaluation the operands are evaluated along with the operators
;; *before* the procedure is applied.  This means that the 'p' procedure is ran when the interpreter evaluates
;; (p) before it applies the test procedure.  When 'p' is called then the interpreter enters an endless loop
;; as it recursively calls 'p'.
;;
;; With normal-order evaluation the operands are lazily evaluated, meaning evaluation is delayed until the
;; called procedure requires them. In the case where the above code is interpreted normal-order then 0 will
;; be returned when x = 0.
