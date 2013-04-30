(in-package #:mdtransform)

(defvar *special-characters* '(("\\\*\\\*" . "\\\*\\\*")
                              ("\\\*". "\\\*")
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
  (let ((words '())
        (indexes '()))
    (loop
       for current-char in *special-characters*
       do (let ((index (cl-ppcre:all-matches
                        (format nil "~A[\\w ]+~A"
                                (car current-char)
                                (cdr current-char))
                        paragraph)))
            (format t "~A~%~A~%~%" (car index) (cdr index))))))

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))
