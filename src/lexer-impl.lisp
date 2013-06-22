(in-package #:mdtransform)

;;; Implementation of the lexer

(defvar *lexers* '())

(defmacro deflexer (letter args &body body)
  `(unless (assoc ,letter *lexers* :test #'equal)
     (setf *lexers* (acons ,letter
                           #'(lambda (,@args)
                               ,@body)
                           *lexers*))))

(defun get-lexer (letter)
  (or (cdr (assoc letter *lexers* :test #'equal))
      #'lex-default))

(defun lex (letter)
  (funcall (get-lexer letter) letter))
