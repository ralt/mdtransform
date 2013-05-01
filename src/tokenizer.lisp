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
  (let ((ret (list (list)))
        (i 0))
    (loop
       for current-char in *special-characters*
       do (let ((indexes (cl-ppcre:all-matches
                          (format nil "~A[\\w ]+~A"
                                  (car current-char)
                                  (cdr current-char))
                          paragraph)))
            (loop
               for index in indexes
               do (progn
                    (setf i (1+ i))
                    (setf ret (append (last ret) (list index)))
                    (when (mod i 2)
                      (setf ret (append ret (list)))))
               finally (setf i 0))))
    ret))

(defun t-paragraphs (text)
  "Tokenizes into paragraphs"
  (let ((paragraphs (cl-ppcre:split "\\n\\n" text)))
    (mapcar 'list paragraphs)))
