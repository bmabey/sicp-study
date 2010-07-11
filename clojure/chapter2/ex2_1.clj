; Rational number code translated from section 2.1
(ns sicpstudy.ex2_1 (:use clojure.contrib.test-is))

(defn gcd [a b]
  (if (= b 0)
    a
    (gcd b (mod a b))))

(defn make-rat [n d]
  (let [g (gcd n d)]
    [(/ n g) (/ d g)]))

(defn numer [x]
  (first x))

(defn denom [x]
  (last x))

(defn equal-rat? [x y]
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(defn add-rat [x y]
 (make-rat (+ (* (numer x) (denom y))
              (* (numer y) (denom x)))
           (* (denom x) (denom y))))

(defn sub-rat [x y]
 (make-rat (- (* (numer x) (denom y))
              (* (numer y) (denom x)))
           (* (denom x) (denom y))))

(defn div-rat [x y]
 (make-rat (* (numer x) (denom y))
           (* (denom x) (numer y))))

(defn mul-rat [x y]
 (make-rat (* (numer x) (numer y))
           (* (denom x) (denom y))))

(deftest test-equal-rat
  (is (equal-rat? (make-rat 1 2) (make-rat 1 2)))
  (is (not (equal-rat? (make-rat 3 2) (make-rat 1 2)))))

(deftest test-make-rat-reduces-to-lowest-terms
  (is (equal-rat? (make-rat 5 10) (make-rat 1 2))))

(deftest test-make-rat-handles-signs
  (is (equal-rat? (make-rat -1 -2) [1 2]))
  (is (equal-rat? (make-rat -5 -3) [5 3]))
  (is (equal-rat? (make-rat -1 2) [-1 2])))

(deftest test-make-rat-only-allows-numer-to-be-negative
  (is (equal-rat? (make-rat 2 -4) [-1 2])))

(deftest test-numer
  (is (= (numer (make-rat 5 7)) 5)))

(deftest test-denom
  (is (= (denom (make-rat 5 7)) 7)))

(deftest test-add-rat
 (is (equal-rat? (add-rat (make-rat 3 4) (make-rat 1 2)) (make-rat 5 4))))

(deftest test-sub-rat
 (is (equal-rat? (sub-rat (make-rat 3 4) (make-rat 1 2)) (make-rat 1 4))))

(deftest test-div-rat
 (is (equal-rat? (div-rat (make-rat 1 2) (make-rat 3 5)) (make-rat 5 6))))

(deftest test-mul-rat
 (is (equal-rat? (mul-rat (make-rat 1 2) (make-rat 5 6)) (make-rat 5 12))))

(run-tests)

