; Newton's Method for finding Cube Root, using the approach in 1.7.
(ns sicpstudy.week01 (:use clojure.contrib.test-is))

(defn square [x]
  (* x x))

(defn abs [x]
  (if (< x 0) (- x) x))

(defn within-delta? [x y delta]
  (<= (abs (- x y)) delta))

(defn cbrt [x]
  (let [improve (fn [guess x]
                 (/ (+ (/ x (square guess)) (* 2 guess)) 3))
        cbrt-iter (fn [old-guess guess x]
                    (if (within-delta? old-guess guess 0.000001)
                      guess
                      (recur guess (improve guess x) x)
                      ))]
    (cbrt-iter 0.0 1.0 x)))

(cbrt 27)
(cbrt 8E15)
(cbrt 8E-15)


(deftest test-cbrt
  (is (within-delta? (cbrt 8E15) 2E5 0.000001))
  (is (within-delta? (cbrt 8E-15) 2E-5 0.000001))
  (is (within-delta? (cbrt 27) 3.0 0.000001)))

(run-tests)
