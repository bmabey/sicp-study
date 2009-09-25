  #lang scheme/base
(require (planet schematics/schemeunit:3)
          "file.scm")

(check-equal? (my-+ 1 1) 2 "Simple addition")
(check-equal? (my-* 1 2) 2 "Simple multiplication")
