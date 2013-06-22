(in-package #:mdtransform)

(defparameter *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant *s-start* 0)

(defparameter *state* *s-start*
  "The current state.")

(defgeneric lex (letter)
  :documentation "Lexes a letter")

(defmethod lex ((letter (string= "#")))
  (format t "~A#~%" letter))

(defmethod lex ((letter (string= "=")))
  (format t "~A=~%" letter))

(defmethod lex ((letter (string= "-")))
  (format t "~A-~%" letter))

(defmethod lex (letter)
  (format t "~A~%" letter))
