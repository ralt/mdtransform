(in-package #:mdtransform)

(defvar *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant s-start 0)
(defconstant s-in-h1 1)
(defconstant s-in-h2 2)
(defconstant s-in-h3 3)
(defconstant s-in-h4 4)

(defvar *state* s-start
  "The current state.")
(defvar *current* ""
  "The current token being lexed.")

(deflexer #\# (letter)
          (when (eq *state* s-start)
            (setf *state* s-in-h1)
            (return-from lexer nil))
          (when (eq *state* s-in-h1)
            (setf *state* s-in-h2)
            (return-from lexer nil))
          (when (eq *state* s-in-h2)
            (setf *state* s-in-h3)
            (return-from lexer nil))
          (when (eq *state* s-in-h3)
            (setf *state* s-in-h4)
            (return-from lexer nil))

          ;; Default behavior when none of the above applied.
          (setf *current* (concatenate 'string *current* letter)))

(deflexer #\= (letter)
  (format t "~A equal ~%" letter))

(deflexer #\- (letter)
  (format t "~A hyphen ~%" letter))

(deflexer #\newline (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
