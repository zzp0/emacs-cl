(let ((load-path (cons "~/src/emacs-cl" load-path)))
  (require 'cl)
  (load "utils")
  (defmacro in-package (name) nil)
  (defmacro IN-PACKAGE (name) nil)

  (load "cl-flow")
  (load "cl-numbers")
  (load "cl-conses")
  (load "cl-structures")

  (load "cl-characters")
  (load "cl-strings")
  (load "cl-symbols")
  (load "cl-packages")
  (load "cl-streams")
  (load "cl-reader")

  (load "cl-typep")
  (load "cl-types")
  (load "cl-subtypep")

  (load "cl-arrays")
  (load "cl-sequences")
  (load "cl-printer")
  nil)
