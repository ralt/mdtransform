(in-package #:mdtransform-tests)

(fiveam:test tokenizer-test
  "Tests the tokenizer API"
  (let ((input "some sample

text"))
    (fiveam:is (equal '(("some sample") ("text")) (mdtransform::tokenize input)))))
