(in-package #:mdtransform)

(defparameter *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant s-start 0)

(defparameter *state* s-start
  "The current state.")

(defvar *lexers* '())

(defmacro deflexer (letter args &body body)
  (let ((name (intern (format nil "~a-~a" 'lex letter))))
    `(progn
       (defun ,name ,args
         ,@body)
       (let ((cons (assoc ,letter *lexers* :test #'equal)))
         (if cons
             (setf (cdr cons) #',name)
             (push (cons ,letter #',name) *lexers*))))))

(defun get-lexer (letter)
  (or (cdr (assoc letter *lexers* :test #'equal))
      #'lex-default))

(defun lex (letter)
  (funcall (get-lexer letter) letter))

;;;

(deflexer "#" (letter)
  (format t "~A sharp ~%" letter))

(deflexer "=" (letter)
  (format t "~A equal ~%" letter))

(deflexer "-" (letter)
  (format t "~A hyphen ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
