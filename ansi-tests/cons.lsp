;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Apr 19 21:24:25 2003
;;;; Contains: Tests for CONS

(in-package :cl-test)

;; Various easy tests of cons
(deftest cons-of-symbols
  (cons 'a 'b)
  (a . b))

(deftest cons-with-nil
  (cons 'a nil)
  (a))

;; successive calls to cons produces results that are equal, but not eq
(deftest cons-eq-equal
  (let ((x (cons 'a 'b))
	(y (cons 'a 'b)))
    (and (not (eqt x y))
	 (equalt x y)))
  t)

;; list can be expressed as a bunch of conses (with nil)
(deftest cons-equal-list
  (equalt (cons 'a (cons 'b (cons 'c nil)))
	  (list 'a 'b 'c))
  t)

;;; Order of evaluation of cons arguments
(deftest cons.order.1
  (let ((i 0)) (values (cons (incf i) (incf i)) i))
  (1 . 2) 2)

(deftest cons.error.1
  (classify-error (cons))
  program-error)

(deftest cons.error.2
  (classify-error (cons 'a))
  program-error)

(deftest cons.error.3
  (classify-error (cons 'a 'b 'c))
  program-error)