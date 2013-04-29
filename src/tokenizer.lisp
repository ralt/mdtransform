(in-package #:mdtransform)

(defun tokenize (input)
  "Tokenizes the markdown input"
  (let ((tokens '()))
    (append tokens (t-words (t-paragraphs input)))))

(defun t-words (paragraph)
  "Tokenizes each paragraph in words"
  paragraph)

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))
