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
              s-in-image
              s-in-link)

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

  (add-current))

(deflexer #\= (letter)
  (when-breaker (or (eq *state* s-one-newline)
                    (eq *state* s-in-h1-second-line))
    (setf *state* s-in-h1-second-line))

  (add-current))

(deflexer #\- (letter)
  (when-breaker (or (eq *state* s-one-newline)
                    (eq *state* s-in-h2-second-line))
    (setf *state* s-in-h2-second-line))

  (add-current))

(deflexer #\! (letter)
  (setf *state* s-in-image)
  (add-current))

(deflexer #\[ (letter)
  (when-breaker (eq *state* s-in-image)
    (setf *state* s-in-image))

  (setf *state* s-in-link))

(deflexer #\] (letter)
  (add-current)

  (when-breaker (eq *state* s-in-link)
    (add-token 'link))
  (when-breaker (eq *state* s-in-image)
    (add-token 'image)))

(deflexer #\newline (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (format t "~A default~%" letter))
