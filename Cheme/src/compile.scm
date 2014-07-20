(define keywords
  #('if 'for 'function 'ret 'int 'global ))

(define (if-exp? p)
	(eq? 'if (car p)))

(define (for-exp? p)
	(eq? 'for (car p)))

(define (global-exp? p)
  (eq? 'global (car p)))

(define (declare-exp? p)
  (cond
    ((eq? p 'int) #t)
    ((eq? p 'char) #t)
    (else #f)))

;;; (if cond-exp then-clause [alternate])
(define (if:formed? p)
  (and (>= (length p) 3) (<= (length p) 4)))

(define (if:then-clause p)
  (cadr p))

;;; (for init-expression check-exp increte-exp [body])
(define (for:formed? p)
  (and (>= (length p) 3) (<= (length p) 4)))