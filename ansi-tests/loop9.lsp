;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Thu Nov 14 06:25:21 2002
;;;; Contains: Tests for loop list accumulation clauses

(in-package :cl-test)

;;; Tests of COLLECT, COLLECTING

(deftest loop.9.1
  (loop for x in '(2 3 4) collect (1+ x))
  (3 4 5))

(deftest loop.9.2
  (loop for x in '(2 3 4) collecting (1+ x))
  (3 4 5))

(deftest loop.9.3
  (loop for x in '(0 1 2)
	when (eql x 2) do (return 'good)
	collect x)
  good)

(deftest loop.9.4
  (loop for x in '(a b c)
	collect (list x) into foo
	finally (return (reverse foo)))
  ((c) (b) (a)))

(deftest loop.9.5
  (loop for x in '(a b c)
	collecting (list x) into foo
	finally (return (reverse foo)))
  ((c) (b) (a)))

(deftest loop.9.6
  (loop for x from 1 to 10
	when (evenp x) collect x into foo
	when (oddp x)  collect x into bar
	finally (return (list foo bar)))
  ((2 4 6 8 10) (1 3 5 7 9)))

(deftest loop.9.7
  (loop for x from 1 to 10
	collect (if (> x 5) (loop-finish) x))
  (1 2 3 4 5))

(deftest loop.9.8
  (loop for x from 1 to 20
	when (eql (mod x 5) 0) collect x into foo
	when (eql (mod x 5) 2) collect x into foo
	finally (return foo))
  (2 5 7 10 12 15 17 20))

(deftest loop.9.9
  (loop for x from 1 to 20
	when (eql (mod x 5) 0) collecting x into foo
	when (eql (mod x 5) 2) collecting x into foo
	finally (return foo))
  (2 5 7 10 12 15 17 20))

(deftest loop.9.10
  (classify-error
   (loop with foo = '(a b)
	 for x in '(c d) collect x into foo
	 finally (return foo)))
  program-error)

(deftest loop.9.11
  (classify-error
   (loop with foo = '(a b)
	 for x in '(c d) collecting x into foo
	 finally (return foo)))
  program-error)

(deftest loop.9.12
  (let ((foo '(a b)))
    (values
     (loop for x in '(c d e) collect x into foo finally (return foo))
     foo))
  (c d e)
  (a b))

;;; Tests of APPEND, APPENDING

(deftest loop.9.20
  (loop for x in '((a b) (c d) (e f g) () (i)) append x)
  (a b c d e f g i))

(deftest loop.9.21
  (loop for x in '((a b) (c d) (e f g) () (i)) appending x)
  (a b c d e f g i))

(deftest loop.9.22
  (loop for x in '((a) (b) (c . whatever)) append x)
  (a b c . whatever))

(deftest loop.9.23
  (loop for x in '((a) (b) (c . whatever)) appending x)
  (a b c . whatever))

(deftest loop.9.24
  (loop for x in '(a b c d)
	append (list x)
	when (eq x 'b) append '(1 2 3)
	when (eq x 'd) appending '(4 5 6))
  (a b 1 2 3 c d 4 5 6))

(deftest loop.9.25
  (let (z)
    (values
     (loop for x in '((a) (b) (c) (d))
	   append x into foo
	   finally (setq z foo))
     z))
  nil
  (a b c d))

(deftest loop.9.26
  (loop for x in '((a) (b) (c) (d))
	for i from 1
	append x into foo
	append x into foo
	appending (list i) into foo
	finally (return foo))
  (a a 1 b b 2 c c 3 d d 4))

(deftest loop.9.27
  (classify-error
   (loop with foo = '(a b)
	 for x in '(c d) append (list x) into foo
	 finally (return foo)))
  program-error)

(deftest loop.9.28
  (classify-error
   (loop with foo = '(a b)
	 for x in '(c d) appending (list x) into foo
	 finally (return foo)))
  program-error)


;;; NCONC, NCONCING

(deftest loop.9.30
  (loop for x in '((a b) (c d) (e f g) () (i)) nconc (copy-seq x))
  (a b c d e f g i))

(deftest loop.9.31
  (loop for x in '((a b) (c d) (e f g) () (i)) nconcing (copy-seq x))
  (a b c d e f g i))

(deftest loop.9.32
  (loop for x in '((a) (b) (c . whatever)) nconc (copy-seq x))
  (a b c . whatever))

(deftest loop.9.33
  (loop for x in '((a) (b) (c . whatever)) nconcing (copy-seq x))
  (a b c . whatever))

(deftest loop.9.34
  (loop for x in '(a b c d)
	nconc (list x)
	when (eq x 'b) nconc (copy-seq '(1 2 3))
	when (eq x 'd) nconcing (copy-seq '(4 5 6)))
  (a b 1 2 3 c d 4 5 6))

(deftest loop.9.35
  (let (z)
    (values
     (loop for x in '((a) (b) (c) (d))
	   nconc (copy-seq x) into foo
	   finally (setq z foo))
     z))
  nil
  (a b c d))

(deftest loop.9.36
  (loop for x in '((a) (b) (c) (d))
	for i from 1
	nconc (copy-seq x) into foo
	nconc (copy-seq x) into foo
	nconcing (list i) into foo
	finally (return foo))
  (a a 1 b b 2 c c 3 d d 4))

(deftest loop.9.37
  (classify-error
   (loop with foo = '(a b)
	 for x in '(c d) nconc (list x) into foo
	 finally (return foo)))
  program-error)

(deftest loop.9.38
  (classify-error
   (loop with foo = '(a b)
	 for x in '(c d) nconcing (list x) into foo
	 finally (return foo)))
  program-error)

;;; Combinations

(deftest loop.9.40
  (loop for x in '(1 2 3 4 5 6 7)
	if (< x 2) append (list x)
	else if (< x 5) nconc (list (1+ x))
	else collect (+ x 2))
  (1 3 4 5 7 8 9))

(deftest loop.9.41
  (loop for x in '(1 2 3 4 5 6 7)
	if (< x 2) append (list x) into foo
	else if (< x 5) nconc (list (1+ x)) into foo
	else collect (+ x 2) into foo
	finally (return foo))
  (1 3 4 5 7 8 9))