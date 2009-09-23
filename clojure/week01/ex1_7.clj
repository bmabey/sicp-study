(defn square [x]
  (* x x))

(defn abs [x]
  (if (< x 0) (- x) x))

(defn average [numbers]
  (/ (apply + numbers) (count numbers)))

(defn within-delta? [x y delta]
  (<= (abs (- x y)) delta))

(defn sqrt [x]
  (let [improve (fn [guess x]
                  (average (list guess (/ x guess))))
        sqrt-iter (fn [old-guess guess x]
                    (if (within-delta? old-guess guess 0.000001)
                      guess
                      (sqrt-iter guess (improve guess x) x)
                      ))]
    (sqrt-iter 0.0 1.0 x)))

(sqrt 9)

(sqrt (+ 100 37))

(sqrt (+ (sqrt 2) (sqrt 3)))

(square (sqrt 1000))

(sqrt 0.005)
(sqrt 123456789012345678901234567890)

