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
(defvar *previous* ""
  "The previous state")
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

  (add-current letter))

(deflexer #\= (letter)
  (when-breaker (or (eq *state* s-one-newline)
                    (eq *state* s-in-h1-second-line))
    (setf *state* s-in-h1-second-line))

  (add-current letter))

(deflexer #\- (letter)
  (when-breaker (or (eq *state* s-one-newline)
                    (eq *state* s-in-h2-second-line))
    (setf *state* s-in-h2-second-line))

  (add-current letter))

(deflexer #\! (letter)
  (setf *previous* *state*)
  (setf *state* s-in-image)
  (add-current letter))

(deflexer #\[ (letter)
  (add-current letter)
  (when-breaker (eq *state* s-in-image)
    (setf *state* s-in-image))

  (setf *previous* *state*)
  (setf *state* s-in-link))

(deflexer #\] (letter)
  (add-current letter)

  (when-breaker (eq *state* s-in-link)
    (add-token 'link)
    (setf *state* *previous*))
  (when-breaker (eq *state* s-in-image)
    (add-token 'image)
    (setf *state* *previous*)))

(deflexer #\newline (letter)
  (format t "~A newline ~%" letter))

(defun lex-default (letter)
  (add-current letter))
