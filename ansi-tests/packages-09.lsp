;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Apr 25 08:02:43 1998
;;;; Contains: Package test code, part 09

(in-package :cl-test)
(declaim (optimize (safety 3)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; make-package

;; Test basic make-package, using string, symbol and character
;;    package-designators

(deftest make-package-1
    (progn
      (ignore-errors (delete-package "TEST1"))
      (let ((p (ignore-errors (make-package "TEST1"))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-2
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1|))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-3
    (progn
      (ignore-errors (delete-package #\X))
      (let ((p (ignore-errors (make-package #\X))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "X")
		 (equal (package-nicknames p) nil)
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)
		 
;; Same, but with a null :use list

(deftest make-package-4
    (progn
      (ignore-errors (delete-package "TEST1"))
      (let ((p (ignore-errors (make-package "TEST1" :use nil))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) nil)
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-5
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1| :use nil))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) nil)
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-6
    (progn
      (ignore-errors (delete-package #\X))
      (let ((p (ignore-errors (make-package #\X))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "X")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) nil)
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

;; Same, but use the A package

(deftest make-package-7
    (progn
      (ignore-errors (delete-package "TEST1"))
      (let ((p (ignore-errors (make-package "TEST1" :use '("A")))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-7a
    (progn
      (ignore-errors (delete-package "TEST1"))
      (let ((p (ignore-errors (make-package "TEST1" :use '(#:|A|)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-7b
    (progn
      (ignore-errors (delete-package "TEST1"))
      (let ((p (ignore-errors (make-package "TEST1" :use '(#\A)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-8
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1| :use '("A")))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-8a
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1| :use '(#:|A|)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-8b
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1| :use '(#\A)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-9
    (progn
      (ignore-errors (delete-package #\X))
      (let ((p (ignore-errors (make-package #\X :use '("A")))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "X")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-9a
    (progn
      (ignore-errors (delete-package #\X))
      (let ((p (ignore-errors (make-package #\X :use '(#:|A|)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "X")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-9b
    (progn
      (ignore-errors (delete-package #\X))
      (let ((p (ignore-errors (make-package #\X :use '(#\A)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "X")
		 (equal (package-nicknames p) nil)
		 (equal (package-use-list p) (list (find-package "A")))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

;; make-package with nicknames

(deftest make-package-10
    (progn
      (ignore-errors (delete-package "TEST1"))
      (let ((p (ignore-errors (make-package "TEST1" :nicknames '("F")))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) '("F"))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-11
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1| :nicknames '(#:|G|)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) '("G"))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-12
    (progn
      (ignore-errors (delete-package '#:|TEST1|))
      (let ((p (ignore-errors (make-package '#:|TEST1| :nicknames '(#\G)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "TEST1")
		 (equal (package-nicknames p) '("G"))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

(deftest make-package-13
    (progn
      (ignore-errors (delete-package #\X))
      (let ((p (ignore-errors (make-package #\X :nicknames '("F" #\G #:|H|)))))
	(prog1
	    (and (packagep p)
		 (equal (package-name p) "X")
		 (null (set-exclusive-or (package-nicknames p)
					  '("F" "G" "H")
					  :test #'equal))
		 (equal (package-used-by-list p) nil))
	  (ignore-errors (delete-package p)))))
  t)

;; Signal a continuable error if the package or any nicknames
;; exist as packages or nicknames of packages

(deftest make-package-error-1
    (handler-case
	(make-package "A")
      (error (c)
	  (if (position 'abort (compute-restarts c)
			:key #'restart-name :test-not #'eq)
	      'success
	    'failure)))
  success)

(deftest make-package-error-2
    (handler-case
	(make-package "Q")
      (error (c)
	  (if (position 'abort (compute-restarts c)
			:key #'restart-name :test-not #'eq)
	      'success
	    'failure)))
  success)

(deftest make-package-error-3
    (handler-case
	(progn (ignore-errors (delete-package "TEST1"))
	       (make-package "TEST1" :nicknames '("A")))
      (error (c)
	  (if (position 'abort (compute-restarts c)
			:key #'restart-name :test-not #'eq)
	      'success
	    'failure)))
  success)    

(deftest make-package-error-4
    (handler-case
	(progn (ignore-errors (delete-package "TEST1"))
	       (make-package "TEST1" :nicknames '("Q")))
      (error (c)
	  (if (position 'abort (compute-restarts c)
			:key #'restart-name :test-not #'eq)
	      'success
	    'failure)))
  success)
