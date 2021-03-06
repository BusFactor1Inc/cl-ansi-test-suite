;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Mon Feb 23 06:26:25 2004
;;;; Contains: Printing tests for integers

(in-package :cl-test)



;;; Tests with *print-base*

(def-print-test print.integers.1 1 "1")
(def-print-test print.integers.2 2 "2")
(def-print-test print.integers.3 3 "3")
(def-print-test print.integers.4 4 "4")
(def-print-test print.integers.5 5 "5")
(def-print-test print.integers.6 6 "6")
(def-print-test print.integers.7 7 "7")
(def-print-test print.integers.8 8 "8")
(def-print-test print.integers.9 9 "9")

(def-print-test print.integers.10 -0 "0")
(def-print-test print.integers.11 -1 "-1")
(def-print-test print.integers.12 -2 "-2")
(def-print-test print.integers.13 -3 "-3")
(def-print-test print.integers.14 -4 "-4")
(def-print-test print.integers.15 -5 "-5")
(def-print-test print.integers.16 -6 "-6")
(def-print-test print.integers.17 -7 "-7")
(def-print-test print.integers.18 -8 "-8")
(def-print-test print.integers.19 -9 "-9")

(def-print-test print.integers.20 (expt 10 20) "100000000000000000000")
(def-print-test print.integers.21 (- (expt 10 20)) "-100000000000000000000")

(def-print-test print.integers.base.2.0 0 "0" (*print-base* 2))
(def-print-test print.integers.base.2.1 1 "1" (*print-base* 2))
(def-print-test print.integers.base.2.2 2 "10" (*print-base* 2))
(def-print-test print.integers.base.2.3 3 "11" (*print-base* 2))
(def-print-test print.integers.base.2.4 -1 "-1" (*print-base* 2))
(def-print-test print.integers.base.2.5 -2 "-10" (*print-base* 2))
(def-print-test print.integers.base.2.6 -3 "-11" (*print-base* 2))
(def-print-test print.integers.base.2.7 255 "11111111" (*print-base* 2))
(def-print-test print.integers.base.2.8 -252 "-11111100" (*print-base* 2))
(def-print-test print.integers.base.2.9 (expt 2 40)
  "10000000000000000000000000000000000000000" (*print-base* 2))
(def-print-test print.integers.base.2.10 (- (expt 2 40))
  "-10000000000000000000000000000000000000000" (*print-base* 2))

(def-print-test print.integers.base.3.0 0 "0" (*print-base* 3))
(def-print-test print.integers.base.3.1 1 "1" (*print-base* 3))
(def-print-test print.integers.base.3.2 2 "2" (*print-base* 3))
(def-print-test print.integers.base.3.3 3 "10" (*print-base* 3))
(def-print-test print.integers.base.3.4 -1 "-1" (*print-base* 3))
(def-print-test print.integers.base.3.5 -2 "-2" (*print-base* 3))
(def-print-test print.integers.base.3.6 -3 "-10" (*print-base* 3))
(def-print-test print.integers.base.3.7 80 "2222" (*print-base* 3))
(def-print-test print.integers.base.3.8 -78 "-2220" (*print-base* 3))
(def-print-test print.integers.base.3.9 (expt 3 40)
  "10000000000000000000000000000000000000000" (*print-base* 3))
(def-print-test print.integers.base.3.10 (- (expt 3 40))
  "-10000000000000000000000000000000000000000" (*print-base* 3))

(def-print-test print.integers.base.4.0 0 "0" (*print-base* 4))
(def-print-test print.integers.base.4.1 1 "1" (*print-base* 4))
(def-print-test print.integers.base.4.2 2 "2" (*print-base* 4))
(def-print-test print.integers.base.4.3 3 "3" (*print-base* 4))
(def-print-test print.integers.base.4.4 4 "10" (*print-base* 4))
(def-print-test print.integers.base.4.5 5 "11" (*print-base* 4))
(def-print-test print.integers.base.4.6 -1 "-1" (*print-base* 4))
(def-print-test print.integers.base.4.7 -2 "-2" (*print-base* 4))
(def-print-test print.integers.base.4.8 -3 "-3" (*print-base* 4))
(def-print-test print.integers.base.4.9 -4 "-10" (*print-base* 4))
(def-print-test print.integers.base.4.10 -5 "-11" (*print-base* 4))
(def-print-test print.integers.base.4.11 255 "3333" (*print-base* 4))
(def-print-test print.integers.base.4.12 -255 "-3333" (*print-base* 4))
(def-print-test print.integers.base.4.13 (expt 4 40)
  "10000000000000000000000000000000000000000" (*print-base* 4))
(def-print-test print.integers.base.4.14 (- (expt 4 40))
  "-10000000000000000000000000000000000000000" (*print-base* 4))

(def-print-test print.integers.base.7.0 0 "0" (*print-base* 7))
(def-print-test print.integers.base.7.1 1 "1" (*print-base* 7))
(def-print-test print.integers.base.7.2 2 "2" (*print-base* 7))
(def-print-test print.integers.base.7.3 16 "22" (*print-base* 7))
(def-print-test print.integers.base.7.4 66 "123" (*print-base* 7))
(def-print-test print.integers.base.7.5 -1 "-1" (*print-base* 7))
(def-print-test print.integers.base.7.6 -7 "-10" (*print-base* 7))
(def-print-test print.integers.base.7.7 -48 "-66" (*print-base* 7))
(def-print-test print.integers.base.7.8 (expt 7 40)
  "10000000000000000000000000000000000000000" (*print-base* 7))
(def-print-test print.integers.base.7.9 (- (expt 7 40))
  "-10000000000000000000000000000000000000000" (*print-base* 7))

(def-print-test print.integers.base.11.0 0 "0" (*print-base* 11))
(def-print-test print.integers.base.11.1 1 "1" (*print-base* 11))
(def-print-test print.integers.base.11.2 2 "2" (*print-base* 11))
(def-print-test print.integers.base.11.3 10 "A" (*print-base* 11))
(def-print-test print.integers.base.11.4 11 "10" (*print-base* 11))
(def-print-test print.integers.base.11.5 121 "100" (*print-base* 11))
(def-print-test print.integers.base.11.6 -1 "-1" (*print-base* 11))
(def-print-test print.integers.base.11.7 -10 "-A" (*print-base* 11))
(def-print-test print.integers.base.11.8 -21 "-1A" (*print-base* 11))
(def-print-test print.integers.base.11.9 -110 "-A0" (*print-base* 11))
(def-print-test print.integers.base.11.10 (expt 11 40)
  "10000000000000000000000000000000000000000" (*print-base* 11))
(def-print-test print.integers.base.11.11 (- (expt 11 40))
  "-10000000000000000000000000000000000000000" (*print-base* 11))

(def-print-test print.integers.base.16.0 0 "0" (*print-base* 16))
(def-print-test print.integers.base.16.1 1 "1" (*print-base* 16))
(def-print-test print.integers.base.16.2 2 "2" (*print-base* 16))
(def-print-test print.integers.base.16.3 12 "C" (*print-base* 16))
(def-print-test print.integers.base.16.4 17 "11" (*print-base* 16))
(def-print-test print.integers.base.16.5 256 "100" (*print-base* 16))
(def-print-test print.integers.base.16.6 -1 "-1" (*print-base* 16))
(def-print-test print.integers.base.16.7 -14 "-E" (*print-base* 16))
(def-print-test print.integers.base.16.8 -30 "-1E" (*print-base* 16))
(def-print-test print.integers.base.16.9 -208 "-D0" (*print-base* 16))
(def-print-test print.integers.base.16.10 (expt 16 40)
  "10000000000000000000000000000000000000000" (*print-base* 16))
(def-print-test print.integers.base.16.11 (- (expt 16 40))
  "-10000000000000000000000000000000000000000" (*print-base* 16))

(def-print-test print.integers.base.36.0 0 "0" (*print-base* 36))
(def-print-test print.integers.base.36.1 1 "1" (*print-base* 36))
(def-print-test print.integers.base.36.2 2 "2" (*print-base* 36))
(def-print-test print.integers.base.36.3 12 "C" (*print-base* 36))
(def-print-test print.integers.base.36.4 37 "11" (*print-base* 36))
(def-print-test print.integers.base.36.5 (* 36 36) "100" (*print-base* 36))
(def-print-test print.integers.base.36.6 -1 "-1" (*print-base* 36))
(def-print-test print.integers.base.36.7 -14 "-E" (*print-base* 36))
(def-print-test print.integers.base.36.8 -35 "-Z" (*print-base* 36))
(def-print-test print.integers.base.36.9 -37 "-11" (*print-base* 36))
(def-print-test print.integers.base.36.10 (- 2 (* 36 36)) "-ZY" (*print-base* 36))
(def-print-test print.integers.base.36.11 (expt 36 40)
  "10000000000000000000000000000000000000000" (*print-base* 36))
(def-print-test print.integers.base.36.12 (- (expt 36 40))
  "-10000000000000000000000000000000000000000" (*print-base* 36))

;;; With *print-radix*

(def-print-test print.integers.radix.0 0 "0." (*print-radix* t))
(def-print-test print.integers.radix.1 1 "1." (*print-radix* t))
(def-print-test print.integers.radix.2 123456 "123456." (*print-radix* t))
(def-print-test print.integers.radix.3 123456789 "123456789." (*print-radix* t))
(def-print-test print.integers.radix.4 -5 "-5." (*print-radix* t))
(def-print-test print.integers.radix.5 -249213 "-249213." (*print-radix* t))
(def-print-test print.integers.radix.6 -917512001 "-917512001." (*print-radix* t))

(def-print-test print.integers.radix.base.2.0 0 "#b0" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.1 1 "#b1" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.2 2 "#b10" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.3 3 "#b11" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.4 -1 "#b-1" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.5 -2 "#b-10" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.6 -3 "#b-11" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.7 256 "#b100000000" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.8 -256 "#b-100000000" (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.9 (expt 2 100)
  (concatenate 'string "#b1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 2))
(def-print-test print.integers.radix.base.2.10 (- (expt 2 200))
  (concatenate 'string "#b-1" (make-string 200 :initial-element #\0))
  (*print-radix* t) (*print-base* 2))

(def-print-test print.integers.radix.base.3.0 0 "#3r0" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.1 1 "#3r1" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.2 2 "#3r2" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.3 4 "#3r11" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.4 -1 "#3r-1" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.5 -2 "#3r-2" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.6 -4 "#3r-11" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.7 6561 "#3r100000000" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.8 -81 "#3r-10000" (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.9 (expt 3 100)
  (concatenate 'string "#3r1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 3))
(def-print-test print.integers.radix.base.3.10 (- 1 (expt 3 200))
  (concatenate 'string "#3r-" (make-string 200 :initial-element #\2))
  (*print-radix* t) (*print-base* 3))

(def-print-test print.integers.radix.base.5.0 0 "#5r0" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.1 1 "#5r1" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.2 2 "#5r2" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.3 6 "#5r11" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.4 -1 "#5r-1" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.5 -2 "#5r-2" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.6 -8 "#5r-13" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.7 390625 "#5r100000000" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.8 -625 "#5r-10000" (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.9 (expt 5 100)
  (concatenate 'string "#5r1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 5))
(def-print-test print.integers.radix.base.5.10 (- 1 (expt 5 200))
  (concatenate 'string "#5r-" (make-string 200 :initial-element #\4))
  (*print-radix* t) (*print-base* 5))

(def-print-test print.integers.radix.base.8.0 0 "#o0" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.1 1 "#o1" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.2 2 "#o2" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.3 9 "#o11" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.4 -1 "#o-1" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.5 -2 "#o-2" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.6 -11 "#o-13" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.7 16777216 "#o100000000" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.8 -4096 "#o-10000" (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.9 (expt 8 100)
  (concatenate 'string "#o1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 8))
(def-print-test print.integers.radix.base.8.10 (- 1 (expt 8 200))
  (concatenate 'string "#o-" (make-string 200 :initial-element #\7))
  (*print-radix* t) (*print-base* 8))

(def-print-test print.integers.radix.base.12.0 0 "#12r0" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.1 1 "#12r1" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.2 2 "#12r2" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.3 13 "#12r11" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.4 -1 "#12r-1" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.5 -2 "#12r-2" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.6 -15 "#12r-13" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.7 (expt 12 8)
  "#12r100000000" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.8 (- (* 12 12 12 12))
  "#12r-10000" (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.9 (expt 12 100)
  (concatenate 'string "#12r1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 12))
(def-print-test print.integers.radix.base.12.10 (- 1 (expt 12 200))
  (concatenate 'string "#12r-" (make-string 200 :initial-element #\B))
  (*print-radix* t) (*print-base* 12))

(def-print-test print.integers.radix.base.16.0 0 "#x0" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.1 1 "#x1" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.2 2 "#x2" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.3 17 "#x11" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.4 -1 "#x-1" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.5 -2 "#x-2" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.6 -19 "#x-13" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.7 (expt 16 8)
  "#x100000000" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.8 (- (* 16 16 16 16))
  "#x-10000" (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.9 (expt 16 100)
  (concatenate 'string "#x1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 16))
(def-print-test print.integers.radix.base.16.10 (- 1 (expt 16 200))
  (concatenate 'string "#x-" (make-string 200 :initial-element #\F))
  (*print-radix* t) (*print-base* 16))

(def-print-test print.integers.radix.base.36.0 0 "#36r0" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.1 1 "#36r1" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.2 2 "#36r2" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.3 37 "#36r11" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.4 -1 "#36r-1" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.5 -2 "#36r-2" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.6 -39 "#36r-13" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.7 (expt 36 8)
  "#36r100000000" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.8 (- (* 36 36 36 36))
  "#36r-10000" (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.9 (expt 36 100)
  (concatenate 'string "#36r1" (make-string 100 :initial-element #\0))
  (*print-radix* t) (*print-base* 36))
(def-print-test print.integers.radix.base.36.10 (- 1 (expt 36 200))
  (concatenate 'string "#36r-" (make-string 200 :initial-element #\Z))
  (*print-radix* t) (*print-base* 36))

(deftest print.integers.base.various.1
  (with-standard-io-syntax
   (loop for b from 2 to 36
         nconc
         (let ((*print-base* b) (*read-base* b))
           (loop for i from 1 to 100
                 for n = (expt b i)
                 for str = (with-output-to-string (s) (prin1 n s))
                 for result = (read-from-string str)
                 unless (= n result)
                 collect (list b i n str result)))))
  nil)

(deftest print.integers.base.various.2
  (with-standard-io-syntax
   (loop for b from 2 to 36
         nconc
         (let ((*print-base* b) (*read-base* b))
           (loop for i from 1 to 100
                 for n = (- (expt b i))
                 for str = (with-output-to-string (s) (prin1 n s))
                 for result = (read-from-string str)
                 unless (= n result)
                 collect (list b i n str result)))))
  nil)

(deftest print.integers.base.various.3
  (with-standard-io-syntax
   (loop for b from 2 to 36
         nconc
         (let ((*print-base* b) (*read-base* b) (*print-radix* t))
           (loop for i from 1 to 100
                 for n = (expt b i)
                 for str = (with-output-to-string (s) (prin1 n s))
                 for result = (read-from-string str)
                 unless (= n result)
                 collect (list b i n str result)))))
  nil)

(deftest print.integers.base.various.4
  (with-standard-io-syntax
   (loop for b from 2 to 36
         nconc
         (let ((*print-base* b) (*read-base* b) (*print-radix* t))
           (loop for i from 1 to 100
                 for n = (- (expt b i))
                 for str = (with-output-to-string (s) (prin1 n s))
                 for result = (read-from-string str)
                 unless (= n result)
                 collect (list b i n str result)))))
  nil)

(deftest print.integers.random.1
  (loop for numbits = (random 40)
        for bound = (ash 1 numbits)
        for r = (- (random (+ bound bound)) bound)
        repeat 10000
        nconc (randomly-check-readability r))
  nil)
