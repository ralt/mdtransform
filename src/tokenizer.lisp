(in-package #:mdtransform)

(defvar *special-characters* '(("\\\*\\\*" . "\\\*\\\*")
                              ("\\\*" . "\\\*")
                              ("[" . "]")
                              ("![" . "]")))

(defvar *list* '())

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
        (indexes (filter-indexes (get-indexes paragraph))))
    (format t "~A" indexes)))

(defun get-indexes (paragraph)
  "Gets the indexes for each special character"
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
  "Gets the indexes for a special character"
  (loop
     while indexes
     for a = (pop indexes)
     for b = (pop indexes)
     collect (list a b)))

(defun filter-indexes (indexes)
  (let ((*list* indexes))
    (remove-if #'filter-index indexes)))

(defun filter-index (index)
  (format t "~A~%" index)
  (format t "~A~%" *list*)
  (let ((found? nil))
    (loop
       for i in *list*
       when (and (> (car index)
                    (car i))
                 (< (cdr index)
                    (cdr i)))
       do (setf found? t))))

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))
