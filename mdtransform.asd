;;;; mdtransform.asd

(asdf:defsystem #:mdtransform
  :serial t
  :description "Markdown to HTML transformer"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :components ((:file "src/package")
               (:file "src/tokens")
               (:file "src/lexer-impl")
               (:file "src/lexer")
               (:file "src/parser")
               (:file "src/input")
               (:file "src/mdtransform")))
