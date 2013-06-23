(in-package #:mdtransform)

;;; Defines tokens classes

(defclass token ()
  ((content
     :initarg :content)))

(defclass link (token)
  ())

(defclass image (token)
  ())
