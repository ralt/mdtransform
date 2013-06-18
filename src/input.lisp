(in-package #:mdtransform)

;; Returns a string of standard input
(defun get-input ()
  (with-open-stream (s *standard-input*)
    (loop for char = (read-char s nil)
       while char
       (lex char))))
