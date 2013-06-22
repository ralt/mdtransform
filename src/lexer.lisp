(in-package #:mdtransform)

(defparameter *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant s-start 0)

(defparameter *state* s-start
  "The current state.")

(defun lex (letter)
  (cond
    ((string= "#" letter) (lex-sharp letter))
    ((string= "=" letter) (lex-equal letter))
    ((string= "-" letter) (lex-hyphen letter))
    (t (lex-default letter))))

(defun lex-sharp (letter)
  (format t "~A sharp ~%" letter))

(defun lex-equal (letter)
  (format t "~A equal ~%" letter))

(defun lex-hyphen (letter)
  (format t "~A hyphen ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
