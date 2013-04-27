;;;; mdtransform.asd

(asdf:defsystem #:mdtransform
  :serial t
  :description "Markdown to HTML transformer"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :components ((:file "package")
               (:file "tokenizer")
               (:file "parser")
               (:file "ast")
               (:file "mdtransform")))

