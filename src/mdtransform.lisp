(in-package #:mdtransform)

(defun main (&optional from-code?)
  "Main function to transform Markdown to HTML"
  (format (if from-code? nil t) "~A" (ast-to-html (parse (tokenize (get-input))))))
