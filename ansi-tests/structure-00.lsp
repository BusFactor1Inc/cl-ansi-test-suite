;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat May  9 11:21:25 1998
;;;; Contains: Common code for creating structure tests

(in-package :cl-test)
(declaim (optimize (safety 3)))

(defun make-struct-test-name (structure-name n)
  ;; (declare (type (or string symbol character) structure-name)
  ;;  (type fixnum n))
  (assert (typep structure-name '(or string symbol character)))
  (assert (typep n 'fixnum))
  (setf structure-name (string structure-name))
  (intern (concatenate 'string
	    structure-name
	    "/"
	    (princ-to-string n))))

(defun make-struct-p-fn (structure-name)
  (assert (typep structure-name '(or string symbol character)))
  (setf structure-name (string structure-name))
  (intern (concatenate 'string
	    structure-name
	    "-P")))

(defun make-struct-copy-fn (structure-name)
  (assert (typep structure-name '(or string symbol character)))
  (setf structure-name (string structure-name))
  (intern (concatenate 'string
		       "COPY-"
		       structure-name)))

(defun make-struct-field-fn (conc-name field-name)
  "Make field accessor for a field in a structure"
  (assert (typep conc-name '(or string symbol character)))
  (assert (typep field-name '(or string symbol character)))
  (setf conc-name (string conc-name))
  (setf field-name (string field-name))
  (intern (concatenate 'string conc-name field-name)))

(defun make-struct-make-fn (structure-name)
  "Make the make- function for a structure"
  (assert (typep structure-name '(or string symbol character)))
  (setf structure-name (string structure-name))
  (intern (concatenate 'string
	    "MAKE-" structure-name)))

(defun create-instance-of-type (type)
  "Return an instance of a type.  Signal an error if
  it can't figure out a value for the type."
  (cond
   ((eqt type t)  ;; anything
    'a)
   ((eqt type 'symbol)
    'b)
   ((eqt type 'null) nil)
   ((eqt type 'boolean) t)
   ((eqt type 'keyword) :foo)
   ((eqt type nil) (error "Cannot obtain element of type ~S~%" type))
   ((eqt type 'cons) (cons 'a 'b))
   ((eqt type 'list) (list 1 2 3))
   ((eqt type 'fixnum) 17)
   ((eqt type 'bignum)
    (let ((x 1))
      (loop until (typep x 'bignum)
	  do (setq x (* 2 x)))
      x))
   ((and (symbolp type)
	 (typep type 'structure-class))
    (let ((make-fn
	   (intern (concatenate 'string "MAKE-" (symbol-name type))
		   (symbol-package type))))
      (eval (list make-fn))))
   ((eqt type 'character) #\w)
   ((eqt type 'base-char) #\z)
   ((member type '(integer unsigned-byte signed-byte)) 35)
   ((eqt type 'bit) 1)
   ((and (consp type)
	 (consp (cdr type))
	 (consp (cddr type))
	 (null (cdddr type))
	 (eqt (car type) 'integer)
	 (integerp (second type)))
    (second type))
   ((member type '(float single-float long-float double-float short-float))
    0.0)
   ((and (consp type)
	 (eqt (car type) 'member)
	 (consp (cdr type)))
    (second type))
   ((and (consp type)
	 (eqt (car type) 'or)
	 (consp (second type)))
    (create-instance-of-type (second type)))
   (t (error "Cannot generate element for type ~S~%" type))))

(defun find-option (option-list option &optional default)
  (loop for opt in option-list
	when (or (eq opt option)
		 (and (consp opt)
		      (eq (car opt) option)))
	return opt
	finally (return default)))

;;
;; There are a number of standardized tests for
;; structures.  The following macro generates the
;; structure definition and the tests.
;;

(defmacro defstruct-with-tests
    (name-and-options &body slot-descriptions-and-documentation)
"Construct standardized tests for a defstruct, and also
do the defstruct."
  (defstruct-with-tests-fun name-and-options
    slot-descriptions-and-documentation))

(defun defstruct-with-tests-fun (name-and-options
				 slot-descriptions-and-documentation)
  ;; Function called from macro defstruct-with-tests
  (let* (
	 ;; Either NIL or the documentation string for the structure
	 (doc-string
	  (when (and (consp slot-descriptions-and-documentation)
		     (stringp (car slot-descriptions-and-documentation)))
	    (car slot-descriptions-and-documentation)))

	 ;; The list of slot descriptions that follows either the
	 ;; name and options or the doc string
	 (slot-descriptions
	  (if doc-string (cdr slot-descriptions-and-documentation)
	    slot-descriptions-and-documentation))

	 ;; The name of the structure (should be a symbol)
	 (name (if (consp name-and-options)
		   (car name-and-options)
		 name-and-options))
	 ;; The options list, or NIL if there were no options
	 (options (if (consp name-and-options)
		      (cdr name-and-options)
		    nil))

	 ;; List of symbols that are the names of the slots
	 (slot-names
	  (loop
	      for x in slot-descriptions collect
		(if (consp x) (car x) x)))

	 ;; Symbol obtained by prepending MAKE- to the name symbol
	 (make-fn (make-struct-make-fn name))

	 ;; The :predicate option entry from OPTIONS, or NIL if none
	 (predicate-option (find-option options :predicate))

	 ;; The name of the -P function, either the default or the
	 ;; one specified in the :predicate option
	 (p-fn (cond
		((or (eq predicate-option :predicate)
		     (null (cdr predicate-option)))
		 (make-struct-p-fn name))
		((cadr predicate-option) (cadr predicate-option))
		(t nil)))

	 ;; The :copier option, or NIL if no such option specified
	 (copier-option (find-option options :copier))
	 ;; The name of the copier function, either the default or
	 ;; one speciefied in the :copier option
	 (copy-fn (cond
		   ((or (eq copier-option :copier)
			(null (cdr copier-option)))
		    (make-struct-copy-fn name))
		   ((cadr copier-option) (cadr copier-option))
		   (t nil)))

	 ;; The :conc-name option, or NIL if none specified
	 (conc-option (find-option options :conc-name))
	 ;; String to be prepended to slot names to get the
	 ;; slot accessor function
	 (conc-prefix (cond
		       ((null conc-option)
			(concatenate 'string (string name) "-"))
		       ((or (eq conc-option :conc-name)
			    (null (cadr conc-option)))
			"")
		       (t (string (cadr conc-option)))))

	 ;; a list of initial values
	 (initial-value-alist
	  (loop
	      for slot-desc in slot-descriptions
	      collect
		(let ((slot-name (if (consp slot-desc)
				     (car slot-desc)
				   slot-desc))
		      (slot-attrs (if (consp slot-desc)
				      (cdr slot-desc)
				    nil)))
		  (when (and (consp slot-attrs)
			     (not (keywordp (car slot-attrs))))
		    (pop slot-attrs))
		  (let ((type (getf slot-attrs :type)))
		    (if type
			(cons slot-name (create-instance-of-type type))
		      (cons slot-name (gensym)))))))
	 )
    ;; Build the tests in an eval-when form
    `(eval-when (compile load eval)
       (defstruct ,name-and-options
	 ,@slot-descriptions-and-documentation)

       ;; Test that structure is of the correct type
       (deftest ,(make-struct-test-name name 1)
	 (and (functionp (function ,make-fn))
	      (symbol-function (quote ,make-fn))
	      (notnot (typep (,make-fn) (quote ,name))))
	 t)

       ;; Test that the predicate exists
       ,@(when p-fn
	   `((deftest ,(make-struct-test-name name 2)
	       (and (functionp (function ,p-fn))
		    (symbol-function (quote ,p-fn))
		    (notnot (,p-fn (,make-fn))))
	       t)))

       ;; Test that the elements of *universe* are not
       ;; of this type
       (deftest ,(make-struct-test-name name 3)
	 (count-if (function ,p-fn) *universe*)
	 0)

       (deftest ,(make-struct-test-name name 4)
	 (count-if (function (lambda (x) (typep x (quote ,name))))
		   *universe*)
	 0)

       ;; Check that the fields can be read after being initialized
       (deftest ,(make-struct-test-name name 5)
	 ,(let ((inits nil)
		(tests nil)
		(var (gensym "X")))
	    (loop
	     for (slot-name . initval) in initial-value-alist
	     do
	     (setf inits
		   (list* (intern (string slot-name) "KEYWORD")
			  (list 'quote initval)
			  inits))
	     (push `(eqlt (quote ,initval)
			  (,(make-struct-field-fn conc-prefix slot-name)
			   ,var))
		   tests))
	    `(let ((,var (,make-fn . ,inits)))
	       (and ,@tests t)))
	 t)

       ;; Check that two invocations return different structures
       (deftest ,(make-struct-test-name name 6)
	 (eqt (,make-fn) (,make-fn))
	 nil)

       ;; Check that we can setf the fields
       (deftest ,(make-struct-test-name name 7)
	 ,(let* ((var (gensym "X"))
		 (var2 (gensym "T"))
		 (tests
		  (loop
		   for (slot-name . initval) in initial-value-alist
		   for slot-desc in slot-descriptions
		   unless (and (consp slot-desc)
			       (getf (cddr slot-desc) :read-only))
		   collect
		   (let ((field-fn (make-struct-field-fn conc-prefix
							 slot-name)))
		     `(let ((,var2 (quote ,initval)))
			(setf (,field-fn ,var) ,var2)
			(eqlt (,field-fn ,var) ,var2))))))
	    `(let ((,var (,make-fn)))
	       (and ,@tests t)))
	 t)

       ;; Check that the copy function exists
       ,@(when copy-fn
	   `((deftest ,(make-struct-test-name name 8)
	       (and (functionp (function ,copy-fn))
		    (symbol-function (quote ,copy-fn))
		    t)
	       t)))

       ;; Check that the copy function properly copies fields
       ,@(when copy-fn
	   `((deftest ,(make-struct-test-name name 9)
	       ,(let* ((var (gensym "X"))
		       (var2 (gensym "Y")))
		  `(let ((,var (,make-fn
				,@(loop
				   for (slot-name . initval)
				   in initial-value-alist
				   nconc (list (intern (string slot-name)
						       "KEYWORD")
					       `(quote ,initval))))))
		     (let ((,var2 (,copy-fn ,var)))
		       (and
			(not (eqlt ,var ,var2))
			,@(loop
			   for (slot-name . nil) in initial-value-alist
			   collect
			   (let ((fn (make-struct-field-fn conc-prefix
							   slot-name)))
			     `(eqlt (,fn ,var) (,fn ,var2))))
			t))))
	       t)))
       )))
