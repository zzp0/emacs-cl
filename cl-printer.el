;;;; -*- emacs-lisp -*-
;;;;
;;;; Copyright (C) 2003 Lars Brinkhoff.
;;;;
;;;; This file implements operators in chapter 14, Conses.

(defun terpri ()
  (princ "\n"))

;;; Ad-hoc unexensible.
(defun cl:print (object &optional stream-designator)
  (let ((stream (resolve-output-stream-designator stream-designator)))
    (cond
      ((or (integerp object)
	   (floatp object)
	   (symbolp object)
	   (stringp object))
       (princ object))
      ((characterp object)
       (princ "#\\")
       (princ (or (char-name object)
		  (string (char-code object)))))
      ((cl::bignump object)
       (princ "#x")
       (dotimes (i (1- (length object)))
	 (let ((num (aref object (- (length object) i 1))))
	   (dotimes (j 7)
	     (princ (string (aref "0123456789abcdef"
				  (logand (ash num (* -4 (- 6 j))) 15))))))))
      ((bit-vector-p object)
       (princ "#*")
       (dotimes (i (cl:length object))
	 (princ (cl:aref object i))))
      ((cl:stringp object)
       (print (copy-seq object)))
      ((cl:vectorp object)
       (princ "#(")
       (dotimes (i (cl:length object))
	 (cl:print (cl:aref object i))
	 (when (< (1+ i) (cl:length object))
	   (princ " ")))
       (princ ")"))
      (t
       (error))))
  object)