; Exercise 2.60
; We specified that a set would be represented as a list with no duplicates. Now suppose 
; we allow duplicates. For instance, the set {1,2,3} could be represented as the list (2 3 2 1 3 2 2). 
; Design procedures element-of-set?, adjoin-set, union-set, and intersection-set 
; that operate on this representation. How does the efficiency of each compare with the corresponding 
; procedure for the non-duplicate representation? Are there applications for which you would use this 
; representation in preference to the non-duplicate one?

; Without actually implementing them.. element-of-set? would operate the same way.  The worst case for
; element-of-set? will become worse though.  Instead of n being the cardinality of the set it would be 
; the length of the list which will be higher. adjoin-set and union-set would be faster operations since
; they would not need to use element-of-set? to verify the uniqueness of a given object before inserting it.
; intersection-set however would still need to use element-of-set? and thereby be slower.
;
; So, if adjoin-set and union-set are the most common operations it would make since to adopt this 
; representation and make the common case fast.

