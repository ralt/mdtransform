(in-package #:mdtransform)

(defparameter *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant s-start 0)

(defparameter *state* s-start
  "The current state.")

(deflexer "#" (letter)
  (format t "~A sharp ~%" letter))

(deflexer "=" (letter)
  (format t "~A equal ~%" letter))

(deflexer "-" (letter)
  (format t "~A hyphen ~%" letter))

;;; newline is better written this way
(deflexer (format nil "~%") (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
