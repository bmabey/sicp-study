#lang planet neil/sicp
; Exercise 3.22
; Instead of representing a queue as a pair of pointers, we can build a queue as a procedure with local state. The local
; state will consist of pointers to the beginning and the end of an ordinary list. Thus, the make-queue procedure
; will have the form:
;
; (define (make-queue)
;   (let ((front-ptr ...) (rear-ptr ...))
;    <definitions of internal procedures>
;    (define (dispatch m) ...) dispatch))

; Complete the definition of make-queue and provide implementations of the queue operations using this representation.

;; Whats nice about this implementation is that the desctructive functions, e.g. set-front-ptr!, that no callee should
;; be worried about is nicey encapsulated inside the returned closure.  The OO cousin of course being the private method.

(define (make-queue)
  (let ((queue (cons '()'())))
    (define (front-ptr) (car queue))
    (define (rear-ptr) (cdr queue))
    (define (set-front-ptr! item) (set-car! queue item))
    (define (set-rear-ptr! item) (set-cdr! queue item))
    (define (empty?) (null? (front-ptr)))
    (define (insert item)
      (let ((new-pair (cons item '())))
        (cond ((empty?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               queue)
              (else
               (set-cdr! (rear-ptr) new-pair)
               (set-rear-ptr! new-pair)
               queue))))
    (define (print) (display (front-ptr)))
    (define (front)
      (if (empty?)
          (error "FRONT called with an empty queue" queue)))
    (define (delete!)
      (cond
       ((empty?)
        (error "DELETE! called with an empty queue" queue))
       (else
        (let ((deleted (car (front-ptr))))
          (set-front-ptr! (cdr (front-ptr)))
          deleted))))

    (define (dispatch m . args)
      (apply
       ;; I'm sure I could use the symbol and resolve the function in the env, but this works... (I don't know how to resolve it)
       (cond ((eq? m 'print) print)
             ((eq? m 'set-front-ptr!) set-front-ptr!)
             ((eq? m 'empty?) empty?)
             ((eq? m 'insert) insert)
             ((eq? m 'front) front)
             ((eq? m 'delete!) delete!))
       args))
    dispatch))

;; > (define q (make-queue))
;; > (q 'insert 4)
;; (mcons (mcons 4 '()) (mcons 4 '()))
;; > (q 'insert 5)
;; (mcons (mcons 4 (mcons 5 '())) (mcons 5 '()))
;; > (q 'print)
;; (4 5)
;; > (q 'delete!)
;; 4
;; > (q 'print)
;; (5)
;; > (q 'empty?)
;; #f
;; > (q 'delete!)
;; 5
;; > (q 'empty?)
;; #t
;; > (q 'print)
;; ()
