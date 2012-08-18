(ns sicp.ch3
  (:use midje.sweet))

;; Exercise 3.55. Define a procedure partial-sums that takes as
;; argument a stream S and returns the stream whose elements are
; ;S0, S0 + S1, S0 + S1 + S2, .... For example, (partial-sums integers)
;; should be the stream 1, 3, 6, 10, 15, ....

(defn partial-sums [seq]
  ;; yeah, I know, seems like cheating
  (reductions + seq))

(fact
  (let [integers (rest (range))]
    (take 5 (partial-sums integers))) => [1 3 6 10 15])


;; Section 3.5.3
;; http://mitpress.mit.edu/sicp/full-text/sicp/book/node72.html

;; fibonachi has gotten old so we are going to calculate pi ;)

;; first, without acceleration
(defn calculate-pi
  "Calculates Pi using the approximation 4 * (1 - 1/3 + 1/5 - 1/7 + ...)"
  [iterations]
  (let [odd-numbers (filter odd? (iterate inc 1))]
    (* 4.0
       (apply + (map / (cycle [1.0 -1.0]) (take iterations odd-numbers))))))

(fact
  (calculate-pi 10)  => 3.0418396189294032
  (calculate-pi 100) => 3.1315929035585537)

(defn pi-seq []
  (let [odd-numbers (filter odd? (range))]
    (map #(* 4 %) (partial-sums (map / (cycle [1.0 -1.0]) odd-numbers)))))

(fact
  (take 5 (pi-seq)) => [4.0 2.666666666666667 3.466666666666667 2.8952380952380956 3.3396825396825403])

  ;; "So far, our use of the stream of states approach is not much
  ;; different from updating state variables. But streams give us an
  ;; opportunity to do some interesting tricks. For example, we can
  ;; transform a stream with a sequence accelerator that converts a
  ;; sequence of approximations to a new sequence that converges to the
  ;; same value as the original, only faster.
  ;;
  ;; One such accelerator, due to the eighteenth-century Swiss
  ;; mathematician Leonhard Euler, works well with sequences that are
  ;; partial sums of alternating series (series of terms with
  ;; alternating signs). In Euler's technique, if S_n is the nth term of
  ;; the original sum sequence, then the accelerated sequence has terms
  ;;
  ;; $S_{n+1} - \frac{(S_{n+1} - S_n)^2}{S_{n-1} - 2S_n + S_{n+1}}$"
  

(defn square [x]
  (* x x))

(defn euler-transform [seq]
  (letfn [(step [S_n-1 S_n S_n+1]
            (- S_n+1 (/ (square (- S_n+1 S_n)) (+ S_n-1 (* -2 S_n) S_n+1))))]
    (map #(apply step %) (partition 3 1 seq))))

(fact
  (take 5 (euler-transform (pi-seq))) => [3.166666666666667
                                          3.1333333333333337  3.1452380952380956
                                          3.13968253968254 3.1427128427128435])

;; "Even better, we can accelerate the accelerated sequence, and
;; recursively accelerate that, and so on. Namely, we create a stream
;; of streams (a structure we'll call a tableau) in which each stream
;; is the transform of the preceding one:"


(defn tableau [transform seq]
  (iterate transform seq))

;; haha, even more cheating.... I could even just say:
;; (def tableau iterate)


;; "Finally, we form a sequence by taking the first term in each row
;; of the tableau:"

(defn accelerated-sequence [transform s]
  (map first (tableau transform s)))

(fact
  (take 5 (accelerated-sequence euler-transform (pi-seq))) => [4.0 3.166666666666667
                                                               3.142105263157895 3.141599357319005
                                                               3.1415927140337785])

;; "The result is impressive. Taking eight terms of the sequence yields
;; the correct value of $\pi$ to 14 decimal places. If we had used
;; only the original $\pi$ sequence, we would need to compute on the
;; order of 1013 terms (i.e., expanding the series far enough so that
;; the individual terms are less then 10-13) to get that much
;; accuracy!
;;
;; We could have implemented these acceleration techniques without
;; using streams. But the stream formulation is particularly elegant
;; and convenient because the entire sequence of states is available
;; to us as a data structure that can be manipulated with a uniform
;; set of operations."


(defn accelerated-calculate-pi
  [iterations]
  (last (take iterations (accelerated-sequence euler-transform (pi-seq)))))

(fact
  (accelerated-calculate-pi 10)  => 3.141592653589795
  (Math/PI)                      => 3.141592653589793)



;; (time (calculate-pi 1000))
;; "Elapsed time: 2.63 msecs"
;; 3.140592653839794

;; (time (accelerated-calculate-pi 10))
;; "Elapsed time: 0.297 msecs"
;; 3.141592653589795
