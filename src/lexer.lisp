(in-package #:mdtransform)

(defvar *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstant s-start 0)
(defconstant s-in-h1 1)
(defconstant s-in-h2 2)
(defconstant s-in-h3 3)
(defconstant s-in-h4 4)
(defconstant s-one-newline 5)
(defconstant s-in-h1-second-line 6)
(defconstant s-in-h2-second-line 7)

(defvar *state* s-start
  "The current state.")
(defvar *current* ""
  "The current token being lexed.")

(deflexer #\# (letter)
  (when-breaker (eq *state* s-start)
    (setf *state* s-in-h1))
  (when-breaker (eq *state* s-in-h1)
    (setf *state* s-in-h2))
  (when-breaker (eq *state* s-in-h2)
    (setf *state* s-in-h3))
  (when-breaker (eq *state* s-in-h3)
    (setf *state* s-in-h4))

  ;; Default behavior when none of the above applied.
  (setf *current* (concatenate 'string *current* letter)))

(deflexer #\= (letter)
  (when-breaker (or (eq *state* s-one-newline)
                    (eq *state* s-in-h1-second-line))
    (setf *state* s-in-h1-second-line))

  (setf *current* (concatenate 'string *current* letter)))

(deflexer #\- (letter)
  (when-breaker (or (eq *state* s-one-newline)
                    (eq *state* s-in-h2-second-line))
    (setf *state* s-in-h2-second-line))

  (setf *current* (concatenate 'string *current* letter)) 
  (format t "~A hyphen ~%" letter))

(deflexer #\[ (letter)
  (format t "~A open square bracket~%" letter))

(deflexer #\] (letter)
  (format t "~A close square bracket~%" letter))

(deflexer #\! (letter)
  (format t "~A exclamation mark~%" letter))

(deflexer #\newline (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
