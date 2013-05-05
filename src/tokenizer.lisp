(in-package #:mdtransform)

(defvar *special-characters* '(("\\\*\\\*" . "\\\*\\\*")
                              ("\\\*" . "\\\*")
                              ("[" . "]")
                              ("![" . "]")))

;;; Used for dynamic scoping only
(defvar *dynamic-list* '())

(defun tokenize (input)
  "Tokenizes the markdown input"
  (let ((tokens '()))
    (append tokens (t-words (t-paragraphs input)))))

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))

(defun t-words (paragraphs)
  "Tokenizes each paragraph in words"
  (mapcar #'t-word paragraphs))

(defun t-word (paragraph)
  "Tokenizes a single paragraph in words"
  (let ((indexes (filter-indexes (get-indexes paragraph))))
    (indexes-to-words indexes paragraph)))

(defun indexes-to-words (indexes paragraph)
  (loop
       for index in indexes
       do (format t
                  ; Debugging why it returns " [test]"
                  "~A ~A~%"
                  (subseq paragraph
                          (car index)
                          (cadr index))
                  index))
  ; For tests
  indexes)

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
  "Filters the indexes to remove duplicates"
  (let ((*dynamic-list* indexes))
    ; We need to sort so that the smaller gets first
    (sort (remove-if #'filter-index indexes)
          #'(lambda (a b)
              (> (car b) (car a))))))

(defun filter-index (index)
  "Filters a single index from the other"
  (let ((found? nil))
    (loop
       for i in *dynamic-list*
       when (and (> (car index)
                    (car i))
                 (<= (cadr index)
                    (cadr i)))
       do (setf found? t))
    found?))
