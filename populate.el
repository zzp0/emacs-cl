;;;; -*- emacs-lisp -*-
;;;
;;; Copyright (C) 2003 Lars Brinkhoff.
;;; This file does the final work of setting up packages.

(IN-PACKAGE "EMACS-CL")

(defun populate-packages ()
  (let ((emacs-cl-table (make-hash-table :test 'equal)))
    (aset *emacs-cl-package* 3 nil)	;shadowing symbols
    (aset *emacs-cl-package* 6 emacs-cl-table) ;hash table
    (aset *emacs-cl-package* 7 nil)	;exported symbols

    (dolist (sym '(&ALLOW-OTHER-KEYS &AUX &BODY &ENVIRONMENT &KEY &OPTIONAL
&REST &WHOLE *BREAK-ON-SIGNALS* *DEBUG-IO* *DEBUGGER-HOOK* *ERROR-OUTPUT*
*FEATURES* *GENSYM-COUNTER* *MACROEXPAND-HOOK* *PACKAGE* *PRINT-BASE*
*PRINT-RADIX* *QUERY-IO* *READ-BASE* *READ-DEFAULT-FLOAT-FORMAT* *READ-EVAL*
*READ-SUPPRESS* *READTABLE* *STANDARD-INPUT* *STANDARD-OUTPUT* *TERMINAL-IO*
*TRACE-OUTPUT* ABORT ABS ACONS ACOS ACOSH AJOIN ADJUST-ARRAY ADJUSTABLE-ARRAY-P
ALPHA-CHAR-P ALPHANUMERICP AND APPEND APPLY AREF ARITHMETIC-ERROR
ARITHMETIC-ERROR-OPERANDS ARITHMETIC-ERROR-OPERATION ARRAY ARRAY-DIMENSION
ARRAY-DIMENSION-LIMIT ARRAY-DIMENSIONS ARRAY-DISPLACEMENT ARRAY-ELEMENT-TYPE
ARRAY-HAS-FILL-POINTER-P ARRAY-IN-BOUNDS-P ARRAY-RANK ARRAY-RANK-LIMIT
ARRAY-ROW-MAJOR-INDEX ARRAY-TOTAL-SIZE ARRAY-TOTAL-SIZE-LIMIT ARRAYP ASH ASIN
ASINH ASSERT ASSOC ASSOC-IF ASSOC-IF-NOT ATAN ATANH ATOM BASE-CHAR BASE-STRING
BIGNUM BIT BIT-AND BIT-ANDC1 BIT-ANDC2 BIT-EQV BIT-IOR BIT-NAND BIT-NOR BIT-NOT
BIT-ORC1 BIT-ORC2 BIT-VECTOR BIT-VECTOR-P BIT-XOR BLOCK BOOLE BOOLE-1 BOOLE-2
BOOLE-AND BOOLE-ANDC1 BOOLE-ANDC2 BOOLE-C1 BOOLE-C2 BOOLE-CLR BOOLE-EQV
BOOLE-IOR BOOLE-NAND BOOLE-NOR BOOLE-ORC1 BOOLE-ORC2 BOOLE-SET BOOLE-XOR
BOOLEAN BOTH-CASE-P BOUNDP BREAK BUTLAST BYTE BYTE-POSITION BYTE-SIZE CAAAAR
CAAADR CAAAR CAADAR CAADDR CAADR CAAR CADAAR CADADR CADAR CADDAR CADDDR
CALL-ARGUMENTS-LIMIT CADDR CADR CAR CASE CATCH CDAAAR CDAADR CDAAR CDADAR
CDADDR CDADR CDAR CDDAAR CDDADR CDDAR CDDDAR CDDDDR CDDDR CDDR CDR CEILING
CELL-ERROR CELL-ERROR-NAME CERROR CHAR CHAR-CODE CHAR-CODE-LIMIT CHAR-DOWNCASE
CHAR-EQUAL CHAR-GREATERP CHAR-LESSP CHAR-NAME CHAR-NOT-EQUAL CHAR-NOT-GREATERP
CHAR-NOT-LESSP CHAR-UPCASE CHAR/= CHAR< CHAR<= CHAR= CHAR> CHAR>= CHARACTER
CHARACTERP CHECK-TYPE CIS CLOSE CLRHASH CODE-CHAR COERCE COMPILED-FUNCTION
COMPILED-FUNCTION-P COMPILER-MACRO-FUNCTION COMPLEMENT COMPLEX COMPLEXP
COMPUTE-RESTARTS CONCATENATE COND CONDITION CONJUGATE CONS CONSTANTLY CONSP
CONTINUE CONTROL-ERROR COPY-ALIST COPY-LIST COPY-READTABLE COPY-SEQ
COPY-STRUCTURE COPY-SYMBOL COPY-TREE COS COSH DECF DECLAIM DECLARATION DECLARE
DECODE-FLOAT DEFCONSTANT DEFINE-COMPILER-MACRO DEFINE-CONDITION
DEFINE-SETF-EXPANDER DEFINE-SYMBOL-MACRO DEFMACRO DEFPACKAGE DEFPARAMETER
DEFSETF DEFSTRUCT DEFTYPE DEFUN DEFVAR DELETE-FILE DELETE-PACKAGE DENOMINATOR
DEPOSIT-FIELD DIGIT-CHAR-P DIRECTORY DISASSEMBLE DIVISION-BY-ZERO DO DO*
DO-SYMBOLS DO-ALL-SYMBOLS DO-EXTERNAL-SYMBOLS DOLIST DOTIMES DOUBLE-FLOAT
DOUBLE-FLOAT-EPSILON DOUBLE-FLOAT-NEGATIVE-EPSILON DPB DYNAMIC-EXTENT ECASE
EIGHTH ELT END-OF-FILE ENDP ENSURE-DIRECTORIES-EXIST EQ EQL EQUAL EQUALP ERROR
ETYPECASE EVAL-WHEN EVENP EVER EXP EXPORT EXPT EXTENDED-CHAR FBOUNDP FCEILING
FDEFINITION FFLOOR FIFTH FILE-AUTHOR FILE-ERROR FILE-ERROR-PATHNAME
FILE-POSITION FILE-STRING-LENGTH FILE-WRITE-DATE FILL FILL-POINTER FIND FIND-IF
FIND-IF-NOT FIND-ALL-SYMBOLS FIND-PACKAGE FIND-RESTART FIND-SYMBOL FIRST FIXNUM
FLET FLOAT FLOAT-DIGITS FLOAT-PRECISION FLOAT-RADIX FLOAT-SIGN
FLOATING-POINT-INEXACT FLOATING-POINT-INVALID-OPERATION FLOATING-POINT-OVERFLOW
FLOATING-POINT-UNDERFLOW FLOATP FLOOR FMAKUNBOUND FOURTH FRESH-LINE FROUND
FTRUNCATE FTYPE FUNCALL FUNCTION FUNCTIONP GENSYM GENTEMP GET
GET-DISPATCH-MACRO-CHARACTER GET-INTERNAL-REAL-TIME GET-MACRO-CHARACTER
GET-SETF-EXPANSION GET-OUTPUT-STREAM-STRING GET-PROPERTIES GETF GETHASH GO
GRAPHIC-CHAR-P HANDLER-BIND HASH-TABLE HASH-TABLE-COUNT HASH-TABLE-P
HASH-TABLE-REHASH-SIZE HASH-TABLE-REHASH-THRESHOLD HASH-TABLE-SIZE
HASH-TABLE-TEST IDENTITY IF IGNORE IGNORE-ERRORS IGNORABLE IMAGPART IMPORT
IN-PACKAGE INCF INLINE INPUT-STREAM-P INTEGER INTEGER-DECODE-FLOAT
INTEGER-LENGTH INTEGERP INTERN INTERNAL-TIME-UNITS-PER-SECOND INVOKE-DEBUGGER
INVOKE-RESTART ISQRT KEYWORD KEYWORDP LABELS LAMBDA LAMBDA-LIST-KEYWORDS
LAMBDA-PARAMETERS-LIMIT LAST LCM LDB LDB-TEST LDIFF LEAST-NEGATIVE-DOUBLE-FLOAT
LEAST-NEGATIVE-LONG-FLOAT LEAST-NEGATIVE-NORMALIZED-DOUBLE-FLOAT
LEAST-NEGATIVE-NORMALIZED-LONG-FLOAT LEAST-NEGATIVE-NORMALIZED-SHORT-FLOAT
LEAST-NEGATIVE-NORMALIZED-SINGLE-FLOAT LEAST-NEGATIVE-SHORT-FLOAT
LEAST-NEGATIVE-SINGLE-FLOAT LEAST-POSITIVE-DOUBLE-FLOAT
LEAST-POSITIVE-LONG-FLOAT LEAST-POSITIVE-NORMALIZED-DOUBLE-FLOAT
LEAST-POSITIVE-NORMALIZED-LONG-FLOAT LEAST-POSITIVE-NORMALIZED-SHORT-FLOAT
LEAST-POSITIVE-NORMALIZED-SINGLE-FLOAT LEAST-POSITIVE-SHORT-FLOAT
LEAST-POSITIVE-SINGLE-FLOAT LENGTH LET LET* LISP-IMPLEMENTATION-TYPE
LISP-IMPLEMENTATION-VERSION LIST LIST* LIST-ALL-PACKAGES LIST-LENGTH LISTP
LOAD-TIME-VALUE LOCALLY LOG LOGAND LOGANDC1 LOGANDC2 LOGBITP LOGCOUNT LOGEQV
LOGIOR LOGNAND LOGNOR LOGNOT LOGORC1 LOGORC2 LOGTEST LOGXOR LONG-FLOAT
LONG-FLOAT-EPSILON LONG-FLOAT-NEGATIVE-EPSILON LONG-SITE-NAME LOOP LOWER-CASE-P
MACHINE-INSTANCE MACHINE-TYPE MACHINE-VERSION MACRO-FUNCTION MACROEXPAND
MACROEXPAND-1 MACROLET MAKE-ARRAY MAKE-CONDITION MAKE-DISPATCH-MACRO-CHARACTER
MAKE-HASH-TABLE MAKE-LIST MAKE-PACKAGE MAKE-RANDOM-STATE MAKE-SEQUENCE
MAKE-STRING MAKE-SYMBOL MAKE-STRING-INPUT-STREAM MAKE-STRING-OUTPUT-STREAM
MAKE-TWO-WAY-STREAM MAKUNBOUND MAP MAP-INTO MAPC MAPCAN MAPCAR MAPCON MAPHASH
MAPL MAPLIST MASK-FIELD MAX MEMBER MEMBER-IF MEMBER-IF-NOT MIN MINUSP MOD
MOST-NEGATIVE-DOUBLE-FLOAT MOST-NEGATIVE-FIXNUM MOST-NEGATIVE-LONG-FLOAT
MOST-NEGATIVE-SHORT-FLOAT MOST-NEGATIVE-SINGLE-FLOAT MOST-POSITIVE-DOUBLE-FLOAT
MOST-POSITIVE-FIXNUM MOST-POSITIVE-LONG-FLOAT MOST-POSITIVE-SHORT-FLOAT
MOST-POSITIVE-SINGLE-FLOAT MUFFLE-WARNING MULTIPLE-VALUE-BIND
MULTIPLE-VALUE-CALL MULTIPLE-VALUE-LIST MULTIPLE-VALUE-PROG1
MULTIPLE-VALUE-SETQ NAME-CHAR NBUTLAST NCONC NINTH NOT NOTANY NOTEVERY
NOTINLINE NRECONC NSTRING-DOWNCASE NSTRING-UPCASE NSUBLIS NSUBST NSUBST-IF
NSUBST-IF-NOT NTH NTH-VALUE NTHCDR NULL NUMBER NUMBERP NUMERATOR ODDP OPEN
OPTIMIZE OR OTHERWISE OUTPUT-STREAM-P PACKAGE PACKAGE-ERROR
PACKAGE-ERROR-PACKAGE PACKAGE-NAME PACKAGE-NICKNAMES PACKAGE-SHADOWING-SYMBOLS
PACKAGE-USE-LIST PACKAGE-USED-BY-LIST PACKAGEP PAIRLIS PARSE-ERROR
PARSE-INTEGER PEEK-CHAR PHASE POP PRIN1 PRINC PRINT PRINT-UNREADABLE-OBJECT
PROBE-FILE PROCLAIM PROG PROG* PROG1 PROG2 PROGN PROGRAM-ERROR PSETQ PROGV PUSH
PUSHNEW QUOTE RANDOM RANDOM-STATE RANDOM-STATE-P RASSOC RASSOC-IF RASSOC-IF-NOT
RATIO RATIONAL RATIONALIZE RATIONALP READ-CHAR READ-DELIMITED-LIST
READ-FROM-STRING READ-LINE READ-PRESERVING-WHITESPACE READTABLE READTABLE-CASE
READTABLEP REAL REALP REALPART REMHASH REMPROP RENAME-FILE REST RESTART
RESTART-BIND RESTART-NAME RETURN RETURN-FROM ROOM ROUND ROW-MAJOR-AREF RPLACA
RPLACD SBIT SCALE-FLOAT SCHAR SECOND SERIOUS-CONDITION SET SET-DIFFERENCE
SET-DISPATCH-MACRO-CHARACTER SET-MACRO-CHARACTER SET-SYNTAX-FROM-CHAR SETF SETQ
SEVENTH SHADOW SHORT-FLOAT SHORT-FLOAT-EPSILON SHORT-FLOAT-NEGATIVE-EPSILON
SHORT-SITE-NAME SIMPLE-BIT-VECTOR SIMPLE-BIT-VECTOR-P SIMPLE-CONDITION
SIMPLE-CONDITION-FORMAT-CONTROL SIMPLE-CONDITION-FORMAT-ARGUMENTS SIMPLE-ERROR
SIMPLE-STRING SIMPLE-STRING-P SIMPLE-VECTOR SIMPLE-VECTOR-P SIMPLE-WARNING SIN
SINGLE-FLOAT SINGLE-FLOAT-EPSILON SINGLE-FLOAT-NEGATIVE-EPSILON SINH SIGNAL
SIGNED-BYTE SIGNUM SIXTH SLEEP SOFTWARE-TYPE SOFTWARE-VERSION SOME SORT SPECIAL
SPECIAL-OPERATOR-P SQRT STABLE-SORT STANDARD-CHAR STANDARD-CHAR-P
STORAGE-CONDITION STORE-VALUE STREAM STREAM-ERROR STREAM-ERROR-STREAM STREAMP
STRING/= STRING< STRING<= STRING= STRING> STRING>= STRING STRING-DOWNCASE
STRING-EQUAL STRING-LESSP STRING-GREATERP STRING-NOT-LESSP STRING-NOT-GREATERP
STRING-UPCASE STRINGP STYLE-WARNING SUBLIS SUBSEQ SUBST SUBST-IF SUBST-IF-NOT
SUBTYPEP SVREF SYMBOL SYMBOL-FUNCTION SYMBOL-MACROLET SYMBOL-NAME
SYMBOL-PACKAGE SYMBOL-PLIST SYMBOL-VALUE SYMBOLP T TAGBODY TAILP TAN TANH TENTH
TERPRI THE THIRD THROW TIME TREE-EQUAL TRUENAME TRUNCATE
TWO-WAY-STREAM-INPUT-STREAM TWO-WAY-STREAM-OUTPUT-STREAM TYPE TYPE-ERROR
TYPE-ERROR-DATUM TYPE-ERROR-EXPECTED-TYPE TYPE-OF TYPECASE TYPEP
UNBOUND-VARIABLE UNDEFINED-FUNCTION UNEXPORT UNLESS UNREAD-CHAR UNSIGNED-BYTE
UNUSE-PACKAGE UNWIND-PROTECT UPGRADED-ARRAY-ELEMENT-TYPE
UPGRADED-COMPLEX-PART-TYPE UPPER-CASE-P USE-PACKAGE USE-VALUE UNINTERN VALUES
VALES-LIST VECTOR VECTOR-POP VECTOR-PUSH VECTOR-PUSH-EXTEND VECTORP WARN
WARNING WHEN WITH-HASH-TABLE-ITERATOR WITH-INPUT-FROM-STRING WITH-OPEN-FILE
WITH-OPEN-STREAM WITH-OUTPUT-TO-STRING WITH-STANDARD-IO-SYNTAX WRITE-CHAR
WRITE-LINE WRITE-STRING ZEROP))
      (setf (gethash (SYMBOL-NAME sym) emacs-cl-table) sym)
      (setf (SYMBOL-PACKAGE sym) *emacs-cl-package*))

    ;; NIL is a special case, because its Emacs Lisp symbol-name isn't
    ;; equal to its Common Lisp SYMBOL-NAME.
    (setf (gethash "NIL" emacs-cl-table) nil)
    (setf (SYMBOL-PACKAGE nil) *emacs-cl-package*)

    ;; Internal symbols.
    (dolist (sym '(BACKQUOTE COMMA COMMA-AT COMMA-DOT INTERPRETED-FUNCTION
		   INTERPRETED-FUNCTION-P))
      (setf (gethash (SYMBOL-NAME sym) emacs-cl-table) sym)
      (setf (SYMBOL-PACKAGE sym) *emacs-cl-package*))

    ;; Symbols prefixed with "cl:" in Emacs Lisp.
    (dolist (name '("=" "/=" "<" ">" "<=" ">=" "*" "+" "-" "/" "1+" "1-"))
      (let ((to (make-symbol name))
	    (from (intern (concat "cl:" name))))
	(setf (gethash name emacs-cl-table) to)
	(setf (SYMBOL-PACKAGE to) *emacs-cl-package*)
	(if (boundp from)
	    (set to (symbol-value from)))
	(fset to (symbol-function from))))

    (setq star (INTERN "*" "EMACS-CL"))

    (dolist (sym '(** *** ++ +++ // ///))
      (setf (gethash (symbol-name sym) emacs-cl-table) sym)
      (setf (SYMBOL-PACKAGE sym) *emacs-cl-package*)
      (set sym nil))

    (setq *global-environment*
	  (vector 'environment
		  ;; Variable information
		  nil nil nil
		  ;; Function information
		  nil nil nil
		  ;; Block and tagbody information
		  nil nil))

    (dolist (sym '(&ALLOW-OTHER-KEYS &AUX &BODY &ENVIRONMENT &KEY &OPTIONAL
&REST &WHOLE * ** *** *BREAK-ON-SIGNALS* *COMPILE-FILE-PATHNAME*
*COMPILE-FILE-TRUENAME* *COMPILE-PRINT* *COMPILE-VERBOSE* *DEBUG-IO*
*DEBUGGER-HOOK* *DEFAULT-PATHNAME-DEFAULTS* *ERROR-OUTPUT* *FEATURES*
*GENSYM-COUNTER* *LOAD-PATHNAME* *LOAD-PRINT* *LOAD-TRUENAME* *LOAD-VERBOSE*
*MACROEXPAND-HOOK* *MODULES* *PACKAGE* *PRINT-ARRAY* *PRINT-BASE* *PRINT-CASE*
*PRINT-CIRCLE* *PRINT-ESCAPE* *PRINT-GENSYM* *PRINT-LENGTH* *PRINT-LEVEL*
*PRINT-LINES* *PRINT-MISER-WIDTH* *PRINT-PPRINT-DISPATCH* *PRINT-PRETTY*
*PRINT-RADIX* *PRINT-READABLY* *PRINT-RIGHT-MARGIN* *QUERY-IO* *RANDOM-STATE*
*READ-BASE* *READ-DEFAULT-FLOAT-FORMAT* *READ-EVAL* *READ-SUPPRESS* *READTABLE*
*STANDARD-INPUT* *STANDARD-OUTPUT* *TERMINAL-IO* *TRACE-OUTPUT* + ++ +++ - / //
/// /= 1+ 1- < <= = > >= ABORT ABS ACONS ACOS ACOSH ADD-METHOD ADJOIN
ADJUST-ARRAY ADJUSTABLE-ARRAY-P ALLOCATE-INSTANCE ALPHA-CHAR-P ALPHANUMERICP
AND APPEND APPLY APROPOS APROPOS-LIST AREF ARITHMETIC-ERROR
ARITHMETIC-ERROR-OPERANDS ARITHMETIC-ERROR-OPERATION ARRAY ARRAY-DIMENSION
ARRAY-DIMENSION-LIMIT ARRAY-DIMENSIONS ARRAY-DISPLACEMENT ARRAY-ELEMENT-TYPE
ARRAY-HAS-FILL-POINTER-P ARRAY-IN-BOUNDS-P ARRAY-RANK ARRAY-RANK-LIMIT
ARRAY-ROW-MAJOR-INDEX ARRAY-TOTAL-SIZE ARRAY-TOTAL-SIZE-LIMIT ARRAYP ASH ASIN
ASINH ASSERT ASSOC ASSOC-IF ASSOC-IF-NOT ATAN ATANH ATOM BASE-CHAR BASE-STRING
BIGNUM BIT BIT-AND BIT-ANDC1 BIT-ANDC2 BIT-EQV BIT-IOR BIT-NAND BIT-NOR BIT-NOT
BIT-ORC1 BIT-ORC2 BIT-VECTOR BIT-VECTOR-P BIT-XOR BLOCK BOOLE BOOLE-1 BOOLE-2
BOOLE-AND BOOLE-ANDC1 BOOLE-ANDC2 BOOLE-C1 BOOLE-C2 BOOLE-CLR BOOLE-EQV
BOOLE-IOR BOOLE-NAND BOOLE-NOR BOOLE-ORC1 BOOLE-ORC2 BOOLE-SET BOOLE-XOR
BOOLEAN BOTH-CASE-P BOUNDP BREAK BROADCAST-STREAM BROADCAST-STREAM-STREAMS
BUILT-IN-CLASS BUTLAST BYTE BYTE-POSITION BYTE-SIZE CAAAAR CAAADR CAAAR CAADAR
CAADDR CAADR CAAR CADAAR CADADR CADAR CADDAR CADDDR CADDR CADR
CALL-ARGUMENTS-LIMIT CALL-METHOD CALL-NEXT-METHOD CAR CASE CATCH CCASE CDAAAR
CDAADR CDAAR CDADAR CDADDR CDADR CDAR CDDAAR CDDADR CDDAR CDDDAR CDDDDR CDDDR
CDDR CDR CEILING CELL-ERROR CELL-ERROR-NAME CERROR CHANGE-CLASS CHAR CHAR-CODE
CHAR-CODE-LIMIT CHAR-DOWNCASE CHAR-EQUAL CHAR-GREATERP CHAR-INT CHAR-LESSP
CHAR-NAME CHAR-NOT-EQUAL CHAR-NOT-GREATERP CHAR-NOT-LESSP CHAR-UPCASE CHAR/=
CHAR< CHAR<= CHAR= CHAR> CHAR>= CHARACTER CHARACTERP CHECK-TYPE CIS CLASS
CLASS-NAME CLASS-OF CLEAR-INPUT CLEAR-OUTPUT CLOSE CLRHASH CODE-CHAR COERCE
COMPILATION-SPEED COMPILE COMPILE-FILE COMPILE-FILE-PATHNAME COMPILED-FUNCTION
COMPILED-FUNCTION-P COMPILER-MACRO COMPILER-MACRO-FUNCTION COMPLEMENT COMPLEX
COMPLEXP COMPUTE-APPLICABLE-METHODS COMPUTE-RESTARTS CONCATENATE
CONCATENATED-STREAM CONCATENATED-STREAM-STREAMS COND CONDITION CONJUGATE CONS
CONSP CONSTANTLY CONSTANTP CONTINUE CONTROL-ERROR COPY-ALIST COPY-LIST
COPY-PPRINT-DISPATCH COPY-READTABLE COPY-SEQ COPY-STRUCTURE COPY-SYMBOL
COPY-TREE COS COSH COUNT COUNT-IF COUNT-IF-NOT CTYPECASE DEBUG DECF DECLAIM
DECLARATION DECLARE DECODE-FLOAT DECODE-UNIVERSAL-TIME DEFCLASS DEFCONSTANT
DEFGENERIC DEFINE-COMPILER-MACRO DEFINE-CONDITION DEFINE-METHOD-COMBINATION
DEFINE-MODIFY-MACRO DEFINE-SETF-EXPANDER DEFINE-SYMBOL-MACRO DEFMACRO DEFMETHOD
DEFPACKAGE DEFPARAMETER DEFSETF DEFSTRUCT DEFTYPE DEFUN DEFVAR DELETE
DELETE-DUPLICATES DELETE-FILE DELETE-IF DELETE-IF-NOT DELETE-PACKAGE
DENOMINATOR DEPOSIT-FIELD DESCRIBE DESCRIBE-OBJECT DESTRUCTURING-BIND
DIGIT-CHAR DIGIT-CHAR-P DIRECTORY DIRECTORY-NAMESTRING DISASSEMBLE
DIVISION-BY-ZERO DO DO* DO-ALL-SYMBOLS DO-EXTERNAL-SYMBOLS DO-SYMBOLS
DOCUMENTATION DOLIST DOTIMES DOUBLE-FLOAT DOUBLE-FLOAT-EPSILON
DOUBLE-FLOAT-NEGATIVE-EPSILON DPB DRIBBLE DYNAMIC-EXTENT ECASE ECHO-STREAM
ECHO-STREAM-INPUT-STREAM ECHO-STREAM-OUTPUT-STREAM ED EIGHTH ELT
ENCODE-UNIVERSAL-TIME END-OF-FILE ENDP ENOUGH-NAMESTRING
ENSURE-DIRECTORIES-EXIST ENSURE-GENERIC-FUNCTION EQ EQL EQUAL EQUALP ERROR
ETYPECASE EVAL EVAL-WHEN EVENP EVERY EXP EXPORT EXPT EXTENDED-CHAR FBOUNDP
FCEILING FDEFINITION FFLOOR FIFTH FILE-AUTHOR FILE-ERROR FILE-ERROR-PATHNAME
FILE-LENGTH FILE-NAMESTRING FILE-POSITION FILE-STREAM FILE-STRING-LENGTH
FILE-WRITE-DATE FILL FILL-POINTER FIND FIND-ALL-SYMBOLS FIND-CLASS FIND-IF
FIND-IF-NOT FIND-METHOD FIND-PACKAGE FIND-RESTART FIND-SYMBOL FINISH-OUTPUT
FIRST FIXNUM FLET FLOAT FLOAT-DIGITS FLOAT-PRECISION FLOAT-RADIX FLOAT-SIGN
FLOATING-POINT-INEXACT FLOATING-POINT-INVALID-OPERATION FLOATING-POINT-OVERFLOW
FLOATING-POINT-UNDERFLOW FLOATP FLOOR FMAKUNBOUND FORCE-OUTPUT FORMAT FORMATTER
FOURTH FRESH-LINE FROUND FTRUNCATE FTYPE FUNCALL FUNCTION FUNCTION-KEYWORDS
FUNCTION-LAMBDA-EXPRESSION FUNCTIONP GCD GENERIC-FUNCTION GENSYM GENTEMP GET
GET-DECODED-TIME GET-DISPATCH-MACRO-CHARACTER GET-INTERNAL-REAL-TIME
GET-INTERNAL-RUN-TIME GET-MACRO-CHARACTER GET-OUTPUT-STREAM-STRING
GET-PROPERTIES GET-SETF-EXPANSION GET-UNIVERSAL-TIME GETF GETHASH GO
GRAPHIC-CHAR-P HANDLER-BIND HANDLER-CASE HASH-TABLE HASH-TABLE-COUNT
HASH-TABLE-P HASH-TABLE-REHASH-SIZE HASH-TABLE-REHASH-THRESHOLD HASH-TABLE-SIZE
HASH-TABLE-TEST HOST-NAMESTRING IDENTITY IF IGNORABLE IGNORE IGNORE-ERRORS
IMAGPART IMPORT IN-PACKAGE INCF INITIALIZE-INSTANCE INLINE INPUT-STREAM-P
INSPECT INTEGER INTEGER-DECODE-FLOAT INTEGER-LENGTH INTEGERP
INTERACTIVE-STREAM-P INTERN INTERNAL-TIME-UNITS-PER-SECOND INTERSECTION
INVALID-METHOD-ERROR INVOKE-DEBUGGER INVOKE-RESTART
INVOKE-RESTART-INTERACTIVELY ISQRT KEYWORD KEYWORDP LABELS LAMBDA
LAMBDA-LIST-KEYWORDS LAMBDA-PARAMETERS-LIMIT LAST LCM LDB LDB-TEST LDIFF
LEAST-NEGATIVE-DOUBLE-FLOAT LEAST-NEGATIVE-LONG-FLOAT
LEAST-NEGATIVE-NORMALIZED-DOUBLE-FLOAT LEAST-NEGATIVE-NORMALIZED-LONG-FLOAT
LEAST-NEGATIVE-NORMALIZED-SHORT-FLOAT LEAST-NEGATIVE-NORMALIZED-SINGLE-FLOAT
LEAST-NEGATIVE-SHORT-FLOAT LEAST-NEGATIVE-SINGLE-FLOAT
LEAST-POSITIVE-DOUBLE-FLOAT LEAST-POSITIVE-LONG-FLOAT
LEAST-POSITIVE-NORMALIZED-DOUBLE-FLOAT LEAST-POSITIVE-NORMALIZED-LONG-FLOAT
LEAST-POSITIVE-NORMALIZED-SHORT-FLOAT LEAST-POSITIVE-NORMALIZED-SINGLE-FLOAT
LEAST-POSITIVE-SHORT-FLOAT LEAST-POSITIVE-SINGLE-FLOAT LENGTH LET LET*
LISP-IMPLEMENTATION-TYPE LISP-IMPLEMENTATION-VERSION LIST LIST*
LIST-ALL-PACKAGES LIST-LENGTH LISTEN LISTP LOAD
LOAD-LOGICAL-PATHNAME-TRANSLATIONS LOAD-TIME-VALUE LOCALLY LOG LOGAND LOGANDC1
LOGANDC2 LOGBITP LOGCOUNT LOGEQV LOGICAL-PATHNAME LOGICAL-PATHNAME-TRANSLATIONS
LOGIOR LOGNAND LOGNOR LOGNOT LOGORC1 LOGORC2 LOGTEST LOGXOR LONG-FLOAT
LONG-FLOAT-EPSILON LONG-FLOAT-NEGATIVE-EPSILON LONG-SITE-NAME LOOP LOOP-FINISH
LOWER-CASE-P MACHINE-INSTANCE MACHINE-TYPE MACHINE-VERSION MACRO-FUNCTION
MACROEXPAND MACROEXPAND-1 MACROLET MAKE-ARRAY MAKE-BROADCAST-STREAM
MAKE-CONCATENATED-STREAM MAKE-CONDITION MAKE-DISPATCH-MACRO-CHARACTER
MAKE-ECHO-STREAM MAKE-HASH-TABLE MAKE-INSTANCE MAKE-INSTANCES-OBSOLETE
MAKE-LIST MAKE-LOAD-FORM MAKE-LOAD-FORM-SAVING-SLOTS MAKE-METHOD MAKE-PACKAGE
MAKE-PATHNAME MAKE-RANDOM-STATE MAKE-SEQUENCE MAKE-STRING
MAKE-STRING-INPUT-STREAM MAKE-STRING-OUTPUT-STREAM MAKE-SYMBOL
MAKE-SYNONYM-STREAM MAKE-TWO-WAY-STREAM MAKUNBOUND MAP MAP-INTO MAPC MAPCAN
MAPCAR MAPCON MAPHASH MAPL MAPLIST MASK-FIELD MAX MEMBER MEMBER-IF
MEMBER-IF-NOT MERGE MERGE-PATHNAMES METHOD METHOD-COMBINATION
METHOD-COMBINATION-ERROR METHOD-QUALIFIERS MIN MINUSP MISMATCH MOD
MOST-NEGATIVE-DOUBLE-FLOAT MOST-NEGATIVE-FIXNUM MOST-NEGATIVE-LONG-FLOAT
MOST-NEGATIVE-SHORT-FLOAT MOST-NEGATIVE-SINGLE-FLOAT MOST-POSITIVE-DOUBLE-FLOAT
MOST-POSITIVE-FIXNUM MOST-POSITIVE-LONG-FLOAT MOST-POSITIVE-SHORT-FLOAT
MOST-POSITIVE-SINGLE-FLOAT MUFFLE-WARNING MULTIPLE-VALUE-BIND
MULTIPLE-VALUE-CALL MULTIPLE-VALUE-LIST MULTIPLE-VALUE-PROG1
MULTIPLE-VALUE-SETQ MULTIPLE-VALUES-LIMIT NAME-CHAR NAMESTRING NBUTLAST NCONC
NEXT-METHOD-P NIL NINTERSECTION NINTH NO-APPLICABLE-METHOD NO-NEXT-METHOD NOT
NOTANY NOTEVERY NOTINLINE NRECONC NREVERSE NSET-DIFFERENCE NSET-EXCLUSIVE-OR
NSTRING-CAPITALIZE NSTRING-DOWNCASE NSTRING-UPCASE NSUBLIS NSUBST NSUBST-IF
NSUBST-IF-NOT NSUBSTITUTE NSUBSTITUTE-IF NSUBSTITUTE-IF-NOT NTH NTH-VALUE
NTHCDR NULL NUMBER NUMBERP NUMERATOR NUNION ODDP OPEN OPEN-STREAM-P OPTIMIZE OR
OTHERWISE OUTPUT-STREAM-P PACKAGE PACKAGE-ERROR PACKAGE-ERROR-PACKAGE
PACKAGE-NAME PACKAGE-NICKNAMES PACKAGE-SHADOWING-SYMBOLS PACKAGE-USE-LIST
PACKAGE-USED-BY-LIST PACKAGEP PAIRLIS PARSE-ERROR PARSE-INTEGER
PARSE-NAMESTRING PATHNAME PATHNAME-DEVICE PATHNAME-DIRECTORY PATHNAME-HOST
PATHNAME-MATCH-P PATHNAME-NAME PATHNAME-TYPE PATHNAME-VERSION PATHNAMEP
PEEK-CHAR PHASE PI PLUSP POP POSITION POSITION-IF POSITION-IF-NOT PPRINT
PPRINT-DISPATCH PPRINT-EXIT-IF-LIST-EXHAUSTED PPRINT-FILL PPRINT-INDENT
PPRINT-LINEAR PPRINT-LOGICAL-BLOCK PPRINT-NEWLINE PPRINT-POP PPRINT-TAB
PPRINT-TABULAR PRIN1 PRIN1-TO-STRING PRINC PRINC-TO-STRING PRINT
PRINT-NOT-READABLE PRINT-NOT-READABLE-OBJECT PRINT-OBJECT
PRINT-UNREADABLE-OBJECT PROBE-FILE PROCLAIM PROG PROG* PROG1 PROG2 PROGN
PROGRAM-ERROR PROGV PROVIDE PSETF PSETQ PUSH PUSHNEW QUOTE RANDOM RANDOM-STATE
RANDOM-STATE-P RASSOC RASSOC-IF RASSOC-IF-NOT RATIO RATIONAL RATIONALIZE
RATIONALP READ READ-BYTE READ-CHAR READ-CHAR-NO-HANG READ-DELIMITED-LIST
READ-FROM-STRING READ-LINE READ-PRESERVING-WHITESPACE READ-SEQUENCE
READER-ERROR READTABLE READTABLE-CASE READTABLEP REAL REALP REALPART REDUCE
REINITIALIZE-INSTANCE REM REMF REMHASH REMOVE REMOVE-DUPLICATES REMOVE-IF
REMOVE-IF-NOT REMOVE-METHOD REMPROP RENAME-FILE RENAME-PACKAGE REPLACE REQUIRE
REST RESTART RESTART-BIND RESTART-CASE RESTART-NAME RETURN RETURN-FROM
REVAPPEND REVERSE ROOM ROTATEF ROUND ROW-MAJOR-AREF RPLACA RPLACD SAFETY
SATISFIES SBIT SCALE-FLOAT SCHAR SEARCH SECOND SEQUENCE SERIOUS-CONDITION SET
SET-DIFFERENCE SET-DISPATCH-MACRO-CHARACTER SET-EXCLUSIVE-OR
SET-MACRO-CHARACTER SET-PPRINT-DISPATCH SET-SYNTAX-FROM-CHAR SETF SETQ SEVENTH
SHADOW SHADOWING-IMPORT SHARED-INITIALIZE SHIFTF SHORT-FLOAT
SHORT-FLOAT-EPSILON SHORT-FLOAT-NEGATIVE-EPSILON SHORT-SITE-NAME SIGNAL
SIGNED-BYTE SIGNUM SIMPLE-ARRAY SIMPLE-BASE-STRING SIMPLE-BIT-VECTOR
SIMPLE-BIT-VECTOR-P SIMPLE-CONDITION SIMPLE-CONDITION-FORMAT-ARGUMENTS
SIMPLE-CONDITION-FORMAT-CONTROL SIMPLE-ERROR SIMPLE-STRING SIMPLE-STRING-P
SIMPLE-TYPE-ERROR SIMPLE-VECTOR SIMPLE-VECTOR-P SIMPLE-WARNING SIN SINGLE-FLOAT
SINGLE-FLOAT-EPSILON SINGLE-FLOAT-NEGATIVE-EPSILON SINH SIXTH SLEEP SLOT-BOUNDP
SLOT-EXISTS-P SLOT-MAKUNBOUND SLOT-MISSING SLOT-UNBOUND SLOT-VALUE
SOFTWARE-TYPE SOFTWARE-VERSION SOME SORT SPACE SPECIAL SPECIAL-OPERATOR-P SPEED
SQRT STABLE-SORT STANDARD STANDARD-CHAR STANDARD-CHAR-P STANDARD-CLASS
STANDARD-GENERIC-FUNCTION STANDARD-METHOD STANDARD-OBJECT STEP
STORAGE-CONDITION STORE-VALUE STREAM STREAM-ELEMENT-TYPE STREAM-ERROR
STREAM-ERROR-STREAM STREAM-EXTERNAL-FORMAT STREAMP STRING STRING-CAPITALIZE
STRING-DOWNCASE STRING-EQUAL STRING-GREATERP STRING-LEFT-TRIM STRING-LESSP
STRING-NOT-EQUAL STRING-NOT-GREATERP STRING-NOT-LESSP STRING-RIGHT-TRIM
STRING-STREAM STRING-TRIM STRING-UPCASE STRING/= STRING< STRING<= STRING=
STRING> STRING>= STRINGP STRUCTURE STRUCTURE-CLASS STRUCTURE-OBJECT
STYLE-WARNING SUBLIS SUBSEQ SUBSETP SUBST SUBST-IF SUBST-IF-NOT SUBSTITUTE
SUBSTITUTE-IF SUBSTITUTE-IF-NOT SUBTYPEP SVREF SXHASH SYMBOL SYMBOL-FUNCTION
SYMBOL-MACROLET SYMBOL-NAME SYMBOL-PACKAGE SYMBOL-PLIST SYMBOL-VALUE SYMBOLP
SYNONYM-STREAM SYNONYM-STREAM-SYMBOL T TAGBODY TAILP TAN TANH TENTH TERPRI THE
THIRD THROW TIME TRACE TRANSLATE-LOGICAL-PATHNAME TRANSLATE-PATHNAME TREE-EQUAL
TRUENAME TRUNCATE TWO-WAY-STREAM TWO-WAY-STREAM-INPUT-STREAM
TWO-WAY-STREAM-OUTPUT-STREAM TYPE TYPE-ERROR TYPE-ERROR-DATUM
TYPE-ERROR-EXPECTED-TYPE TYPE-OF TYPECASE TYPEP UNBOUND-SLOT
UNBOUND-SLOT-INSTANCE UNBOUND-VARIABLE UNDEFINED-FUNCTION UNEXPORT UNINTERN
UNION UNLESS UNREAD-CHAR UNSIGNED-BYTE UNTRACE UNUSE-PACKAGE UNWIND-PROTECT
UPDATE-INSTANCE-FOR-DIFFERENT-CLASS UPDATE-INSTANCE-FOR-REDEFINED-CLASS
UPGRADED-ARRAY-ELEMENT-TYPE UPGRADED-COMPLEX-PART-TYPE UPPER-CASE-P USE-PACKAGE
USE-VALUE USER-HOMEDIR-PATHNAME VALUES VALUES-LIST VARIABLE VECTOR VECTOR-POP
VECTOR-PUSH VECTOR-PUSH-EXTEND VECTORP WARN WARNING WHEN WILD-PATHNAME-P
WITH-ACCESSORS WITH-COMPILATION-UNIT WITH-CONDITION-RESTARTS
WITH-HASH-TABLE-ITERATOR WITH-INPUT-FROM-STRING WITH-OPEN-FILE WITH-OPEN-STREAM
WITH-OUTPUT-TO-STRING WITH-PACKAGE-ITERATOR WITH-SIMPLE-RESTART WITH-SLOTS
WITH-STANDARD-IO-SYNTAX WRITE WRITE-BYTE WRITE-CHAR WRITE-LINE WRITE-SEQUENCE
WRITE-STRING WRITE-TO-STRING Y-OR-N-P YES-OR-NO-P ZEROP))
      (MULTIPLE-VALUE-BIND (symbol found)
	  (FIND-SYMBOL (SYMBOL-NAME sym) *cl-package*)
	(when found
	  (UNINTERN symbol *cl-package*)))
      (MULTIPLE-VALUE-BIND (symbol found)
	  (FIND-SYMBOL (SYMBOL-NAME sym) *emacs-cl-package*)
	(when found
	  (IMPORT (list symbol) *cl-package*)
	  (EXPORT (list symbol) *cl-package*))))))


;;; Local variables:
;;; fill-column: 79
;;; End:
