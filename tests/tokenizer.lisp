(in-package #:mdtransform-tests)

(defparameter *input-sample* "some sample

text")

(defparameter *input-sample-words* "some *sample* text")

(fiveam:test tokenizer-test
  "Tests the tokenizer API"
  (fiveam:is (equal '(("some sample") ("text")) (mdtransform::t-paragraphs *input-sample*)))
  (fiveam:is (equal '("some " "*sample*" "text") (mdtransform::t-words *input-sample-words*))))
