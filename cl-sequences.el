;;;; -*- emacs-lisp -*-
;;;
;;; Copyright (C) 2003 Lars Brinkhoff.
;;; This file implements operators in chapter 17, Sequences.

(IN-PACKAGE "EMACS-CL")

(defun COPY-SEQ (sequence)
  (cond
    ((listp sequence)
     (copy-list sequence))
    ((SIMPLE-VECTOR-P sequence)
     (copy-sequence sequence))
    ((vector-and-typep sequence 'VECTOR)
     (let ((storage (aref sequence 2))
	   (vector (make-vector
		    (1+ (or (FILL-POINTER sequence) (LENGTH sequence)))
		    'SIMPLE-VECTOR)))
       (do ((i 1 (1+ i)))
	   ((= i (length vector)))
	 (aset vector i (aref storage (1- i))))
       vector))
    ((VECTORP sequence)
     (subseq (aref sequence 2) 0 (FILL-POINTER sequence)))
    (t
     (error))))

(defun ELT (sequence index)
  (cond
    ((listp sequence)
     (nth index sequence))
    ((VECTORP sequence)
     (if (ARRAY-HAS-FILL-POINTER-P sequence)
	 (if (cl:< index (FILL-POINTER sequence))
	     (AREF sequence index)
	     (error))
	 (AREF sequence index)))
    (t
     (error "type error"))))

(defsetf ELT (sequence index) (obj)
  `(if (listp ,sequence)
       (setf (nth ,index ,sequence) ,obj)
       (setf (AREF ,sequence ,index) ,obj)))

(DEFSETF ELT (sequence index) (obj)
  `(IF (LISTP ,sequence)
       (SETF (NTH ,index ,sequence) ,obj)
       (SETF (AREF ,sequence ,index) ,obj)))

(cl:defun FILL (seq obj &key (start 0) end)
  (let ((len (LENGTH seq)))
    (unless end
      (setq end len))
    (do ((i start (1+ i)))
	((eq i len))
      (setf (ELT seq i) obj)))
  seq)

(cl:defun MAKE-SEQUENCE (type size &key initial-element)
  (cond
    ((SUBTYPEP type 'LIST)
     (make-list size initial-element))
    ((SUBTYPEP type 'BIT-VECTOR)
     (make-bool-vector size (ecase initial-element ((0 nil) nil) (1 t))))
    ((SUBTYPEP type 'STRING)
     (make-string size (if initial-element (CHAR-CODE initial-element) 0)))
    ((SUBTYPEP type 'VECTOR)
     (let ((vector (make-vector (1+ size) initial-element)))
       (aset vector 0 'SIMPLE-VECTOR)
       vector))
    (t
     (error))))

(defun SUBSEQ (seq start &optional end)
  (unless end
    (setq end (LENGTH seq)))
  (cond
    ((SIMPLE-STRING-P seq)
     (substring seq start end))
    ((STRINGP seq)
     (substring (aref seq 2) start end))
    ((listp seq)
     (if (eq start end)
	 nil
	 (let ((new (copy-list (nthcdr start seq))))
	   (setcdr (nthcdr (- end start 1) new) nil)
	   new)))
;     ((BIT-VECTOR-P seq)
;      (let* ((s (if (SIMPLE-BIT-VECTOR-P seq) seq (aref seq 2)))
; 	    (len (- end start))
; 	    (new (make-bool-vector len nil)))
;        (do ((i 0 (1+ i))
; 	    (j start (1+ j)))
; 	   ((eq i len))
; 	 (aset new i (aref s j)))
;        new))
;     ((VECTORP seq)
;      (let* ((len (- end start -1))
; 	    (new (make-vector len 'SIMPLE-VECTOR))
; 	    (s (if (SIMPLE-VECTOR-P seq)
; 		   (progn (incf start) seq)
; 		   (aref seq 2))))
;        (do ((i 1 (1+ i))
; 	    (j start (1+ j)))
; 	   ((eq i len))
; 	 (aset new i (aref seq j)))
;        new))
    ((VECTORP seq)
     (let ((len (- end start))
	   (i0 0))
       (when (eq (aref seq 0) 'SIMPLE-VECTOR)
	 (incf i0)
	 (incf len)
	 (incf start))
       (let ((new (if (BIT-VECTOR-P seq)
		      (make-bool-vector len nil)
		      (make-vector len 'SIMPLE-VECTOR)))
	     (storage (if (SIMPLE-VECTOR-P seq) seq (aref seq 2))))
	 (do ((i i0 (1+ i))
	      (j start (1+ j)))
	     ((eq i len))
	   (aset new i (aref storage j)))
	 new)))
    (t
     (type-error seq 'SEQUENCE))))

;;; TODO: SETF SUBSEQ

(defun* MAP (type fn &rest sequences)
  (let ((i 0)
	(result nil))
    (loop
      (when (some (lambda (seq) (eq i (LENGTH seq))) sequences)
	(return-from MAP
	  (progn
	    (setq result (nreverse result))
	    (ecase type
	      (LIST	result)
	      (VECTOR	(apply #'VECTOR result))))))
      (push (APPLY fn (mapcar (lambda (seq) (ELT seq i)) sequences)) result)
      (incf i))))

(defun* MAP-INTO (result fn &rest sequences)
  (let ((i 0))
    (loop
      (when (or (eq i (LENGTH result))
		(some (lambda (seq) (eq i (LENGTH seq))) sequences))
	(return-from MAP-INTO result))
      (setf (ELT result i) (APPLY fn (mapcar (lambda (seq) (ELT seq i))
					     sequences)))
      (incf i))))

;;; TODO: REDUCE

;;; TODO: COUNT, COUNT-IF, COUNT-IF-NOT

(defun LENGTH (sequence)
  (cond
    ((or (listp sequence)
	 (SIMPLE-BIT-VECTOR-P sequence)
	 (SIMPLE-STRING-P sequence))
     (length sequence))
    ((SIMPLE-VECTOR-P sequence)
     (1- (length sequence)))
    ((VECTORP sequence)
     (if (ARRAY-HAS-FILL-POINTER-P sequence)
	 (FILL-POINTER sequence)
	 (length (aref sequence 2))))
    (t
     (error))))

;;; TODO: REVERSE, NREVERSE

(cl:defun SORT (sequence predicate &key (key (cl:function IDENTITY)))
  (cond 
    ((listp sequence)
     (sort sequence (lambda (x y)
		      (FUNCALL predicate (FUNCALL key x) (FUNCALL key y)))))
    ((VECTORP sequence)
     (MAP-INTO sequence
	       #'IDENTITY
	       (SORT (MAP 'LIST #'IDENTITY sequence) predicate :key key)))
    (t
     (error "type error"))))

(fset 'STABLE-SORT (symbol-function 'SORT))

(cl:defun FIND (obj seq &key from-end test test-not (start 0) end
		             (key (cl:function IDENTITY)))
    (when (and test test-not)
      (error))
    (when test-not
      (setq test (COMPLEMENT test-not)))
    (unless test
      (setq test (cl:function EQL)))
  (FIND-IF (lambda (x) (FUNCALL test obj x)) seq
	   (kw FROM-END) from-end (kw START) start
	   (kw END) end (kw KEY) key))

(cl:defun FIND-IF (predicate seq &key from-end (start 0) end
		                      (key (cl:function IDENTITY)))
  (let ((len (LENGTH seq)))
    (unless end
      (setq end len))
    (catch 'FIND
      (if from-end
	  (do ((i (1- end) (1- i)))
	      ((eq i -1))
	    (let ((elt (ELT seq i)))
	      (when (FUNCALL predicate (FUNCALL key elt))
		(throw 'FIND elt))))
	  (do ((i start (1+ i)))
	      ((eq i end))
	    (let ((elt (ELT seq i)))
	      (when (FUNCALL predicate (FUNCALL key elt))
		(throw 'FIND elt))))))))

(cl:defun FIND-IF-NOT (predicate seq &key from-end (start 0) end
		                      (key (cl:function IDENTITY)))
  (FIND-IF (COMPLEMENT predicate) seq
	   (kw FROM-END) from-end (kw START) start
	   (kw END) end (kw KEY) key))

(defmacro* dovector ((var vector &optional result) &body body)
  (with-gensyms (i len vec)
    `(let* (,var (,i 0) (,vec ,vector) (,len (LENGTH ,vec)))
       (while (< ,i ,len)
	 (setq ,var (AREF ,vec ,i))
	 ,@body
	 (incf ,i))
       ,result)))

(defmacro* dosequence ((var sequence &optional result) &body body)
  (let ((seq (gensym)))
    `(let ((,seq ,sequence))
       (if (listp ,seq)
	   (dolist (,var ,seq ,result) ,@body)
	   (dovector (,var ,seq ,result) ,@body)))))

(defun CONCATENATE (type &rest sequences)
  (ecase type
    (VECTOR
     (let ((vector (make-vector (1+ (reduce #'+ (mapcar #'LENGTH sequences)))
				'SIMPLE-VECTOR))
	   (i 0))
       (dolist (seq sequences)
	 (dosequence (x seq)
	   (aset vector (incf i) x)))
       vector))
    (STRING
     (let ((string
	    (make-string (reduce #'+ (mapcar #'LENGTH sequences)) 0))
	   (i -1))
       (dolist (seq sequences)
	 (dosequence (x seq)
	   (aset string (incf i) (CHAR-CODE x))))
       string))))

;;; ...

;;; TODO: merge

;;; TODO: remove, remove-if, remove-if-not, delete, delete-if, delete-if-not

;;; TODO: remove-duplicates, delete-duplicates
