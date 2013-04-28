(in-package #:mdtransform)

(defun tokenize (input)
  (let ((tokens '())
        (paragraphs (cl-ppcre:split "\\n\\n" input)))
    (append tokens (mapcar 'list paragraphs))))
