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
        (indexes (get-indexes paragraph)))))

(defun get-indexes (paragraph)
  (let ((ret '()))
    (loop
       for current-char in *special-characters*
       do (let ((indexes (cl-ppcre:all-matches
                          (format nil "~A[\\w ]+~A"
                                  (car current-char)
                                  (cdr current-char))
                          paragraph)))
            (setf ret (append ret (collect-indexes indexes)))))
    ret))

(defun collect-indexes (indexes)
  (loop
     while indexes
     for a = (pop indexes)
     for b = (pop indexes)
     collect (list a b)))

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))
