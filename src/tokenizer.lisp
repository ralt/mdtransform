(in-package #:mdtransform)

(defvar *special-characters* '(("*" . "*")
                              ("**" . "**")
                              ("[" . "]")
                              ("![" . "]")))

(defun tokenize (input)
  "Tokenizes the markdown input"
  (let ((tokens '()))
    (append tokens (t-words (t-paragraphs input)))))

(defun t-words (paragraphs)
  "Tokenizes each paragraph in words"
  (mapcar #'t-word paragraphs))

(defun t-word (paragraph)
  "Tokenizes a single paragraph in words"
  ; First split by special characters
  (reduce #'(lambda (x)
              x)
          *special-characters*))

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))
