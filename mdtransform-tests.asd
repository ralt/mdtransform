(asdf:defsystem #:mdtransform-tests
  :serial t
  :description "Markdown to HTML transformer -- tests"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :depends-on ("mdtransform" "fiveam")
  :components ((:file "tests/package")
               (:file "tests/mdtransform")
               (:file "tests/lexer")))

