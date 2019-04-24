#lang racket
(module+ test (require rackunit))
(provide pmap andpmap pfor-each)

;; generic concurrent map
(define (pmap proc lst)
  (define semaphore (make-semaphore 1))
  (define lst-length (length lst))
  (define results (make-vector lst-length #f))
  (define indexes (for/list ((x (in-range lst-length))) x))
  (define (pproc item index)
    (thread (λ ()
              (define output (proc item))
              (semaphore-wait semaphore)
              (vector-set! results index output)
              (semaphore-post semaphore))))
  (define threads (map pproc lst indexes))
  (for-each thread-wait threads)
  (vector->list results))
; unit test
(module+ test
  (check-equal? (pmap string-upcase '("naice" "world" "buddy"))
                '("NAICE" "WORLD" "BUDDY")))

;; generic concurrent map
(define (andpmap proc lst)
  (define results (pmap proc lst))
  (if (member #f results) #f #t))
; unit test
(module+ test
  (check-equal? (andpmap even? '(2 3 4)) #f)
  (check-equal? (andpmap even? '(2 4 6)) #t))

;; generic concurrent for-each
(define (pfor-each proc lst)
  (define semaphore (make-semaphore 1))
  (define lst-length (length lst))
  (define results (make-vector lst-length #f))
  (define indexes (for/list ((x (in-range lst-length))) x))
  (define (pproc item index)
    (thread (λ ()
              (define output (proc item))
              (semaphore-wait semaphore)
              (vector-set! results index output)
              (semaphore-post semaphore))))
  (define threads (map pproc lst indexes))
  (for-each thread-wait threads))
; unit test
(module+ test
  (check-equal? (pfor-each string-upcase '("naice" "world" "buddy"))
                (void)))
                
; EOF
