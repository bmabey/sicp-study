; Exercise 2.55
; Eva Lu Ator types to the interpreter the expression 
; (car ''abracadabra) 
; To her surprise, the interpreter prints back quote. Explain.
;
; I was surprised myself. The quote object is returned by the evaluation of car, that is obvious.
; What surprised was that (pair? ''a) is true.  However, ''a is shorthand for (quote (quote a)) 
; which does look more like a list than when using the specail ' symbol.  So, given that it seems
; natural that the car call would return quote.

