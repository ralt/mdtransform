(in-package #:mdtransform)

;;; Implementation of the lexer

(defvar *lexers* '())

(defmacro deflexer (letter args &body body)
  `(unless (assoc ,letter *lexers* :test #'equal)
     (setf *lexers* (acons ,letter
                           #'(lambda ,args
                               ;; Anaphoric macro for lexers to RETURN-FROM
                               (block lexer
                                      ,@body))
                           *lexers*))))

(defun get-lexer (letter)
  (or (cdr (assoc letter *lexers* :test #'equal))
      #'lex-default))

(defun lex (letter)
  (funcall (get-lexer letter) letter))

;;; Returns from the lexer block after the when
(defmacro when-breaker (con &body body)
  `(when ,con
     ,@body
     (return-from lexer nil)))

(defmacro defconstants (&rest names)
  `(progn
     ,@(loop for i from 0 for name in names collecting
             `(defconstant ,name ,i))))

(defmacro add-current ()
  `(setf *current* (concatenate *current* letter)))

(defun add-token (token-class)
  (setf *tokens*
        (append *tokens*
                (make-instance token-class
                               :content *current*))))
