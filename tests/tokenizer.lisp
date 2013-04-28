(in-package #:mdtransform-tests)

(defvar *input-sample* "some sample

text")

(fiveam:test tokenizer-test
  "Tests the tokenizer API"
  (fiveam:is (equal '(("some sample") ("text")) (mdtransform::tokenize *input-sample*))))
