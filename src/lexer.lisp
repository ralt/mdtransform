(in-package #:mdtransform)

(defvar *tokens* '()
  "The full list of tokens.")

;;; State constants
(defconstants s-start
              s-in-h1
              s-in-h2
              s-in-h3
              s-in-h4
              s-one-newline
              s-in-h1-second-line
              s-in-h2-second-line
              s-in-image)

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

(deflexer #\! (letter)
  (setf *state* s-in-image))

(deflexer #\[ (letter)
  (format t "~A open square bracket~%" letter))

(deflexer #\] (letter)
  (format t "~A close square bracket~%" letter))

(deflexer #\newline (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
