(in-package #:mdtransform)

(defun main ()
  (format t "~A" (ast-to-html (parse (tokenize (get-input))))))
