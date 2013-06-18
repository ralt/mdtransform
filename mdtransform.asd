;;;; mdtransform.asd

(asdf:defsystem #:mdtransform
  :serial t
  :description "Markdown to HTML transformer"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :depends-on ("cl-ppcre")
  :components ((:file "src/package")
               (:file "src/input")
               (:file "src/lexer")
               (:file "src/parser")
               (:file "src/mdtransform")))
