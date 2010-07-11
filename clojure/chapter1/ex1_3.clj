(defn square [x] (* x x))

(defn squared-sum [x y]
  (+ (square x) (square y))
)

(defn squared-sum-of-two-greatest [x y z]
  (if (> x y)
    (if (> y z)
        (squared-sum x y)
        (squared-sum x z)
        )
    (if (> x z)
        (squared-sum y x)
        (squared-sum y z)
        )
    )
)

(squared-sum-of-two-greatest 2 1 3)
; # => 13
(squared-sum-of-two-greatest 5 5 9)
; # => 106
(squared-sum-of-two-greatest 1 3 4)
; # => 25
