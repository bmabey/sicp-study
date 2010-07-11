;; Exercies 1.26
;;
;; By not using the square procedure the expmod procedure gets evaluated twice for each set of arguments.
;; This counteracts the optimizations of expmod and brings the runtime back to θ(n).
