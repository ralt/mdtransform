;;;; mdtransform.lisp

(in-package #:mdtransform)

;;; "mdtransform" goes here. Hacks and glory await!

;; Returns a string of standard input
(defun get-input ()
  (reduce #'(lambda (a b)
              ; reduces the list to a string separated by CRLF
              (format nil "~A~%~A" a b))
          ; returns a list (line1 line2 line3)
          (with-open-stream (s *standard-input*)
            (loop for line = (read-line s nil)
                  while line
                  collect line))))

(format t "~A" (ast-to-html (parse (tokenize (get-input)))))
