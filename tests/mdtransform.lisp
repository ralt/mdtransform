(in-package #:mdtransform-tests)

;;; Utility functions for tests

(defun input (str)
  (let ((*standard-input* (make-string-input-stream str)))
    (mdtransform::get-input)))
