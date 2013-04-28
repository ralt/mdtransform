;;;; mdtransform.asd

(asdf:defsystem #:mdtransform
  :serial t
  :description "Markdown to HTML transformer"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :components ((:file "src/package")
               (:file "src/tokenizer")
               (:file "src/parser")
               (:file "src/ast")
               (:file "src/mdtransform")))

