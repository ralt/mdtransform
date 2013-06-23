(in-package #:mdtransform)

(defvar *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant s-start 0)

(defvar *state* s-start
  "The current state.")

(deflexer #\# (letter)
  (format t "~A sharp ~%" letter))

(deflexer #\= (letter)
  (format t "~A equal ~%" letter))

(deflexer #\- (letter)
  (format t "~A hyphen ~%" letter))

(deflexer #\newline (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
