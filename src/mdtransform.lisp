(in-package #:mdtransform)

(defun main (&optional from-code?)
  (format (if from-code? nil t) "~A" (ast-to-html (parse (tokenize (get-input))))))
