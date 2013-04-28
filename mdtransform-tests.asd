(asdf:defsystem #:mdtransform-tests
  :serial t
  :description "Markdown to HTML transformer -- tests"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :depends-on ("mdtransform" "fiveam")
  :components ((:file "src/package")
               (:file "src/input")
               (:file "src/tokenizer")
               (:file "src/parser")
               (:file "src/ast")
               (:file "src/mdtransform")))

