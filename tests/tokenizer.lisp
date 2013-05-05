(in-package #:mdtransform-tests)

(defparameter *input-sample* "some sample

text")

(defparameter *input-sample-words* "some *sample* text")

(fiveam:test tokenizer-test
  "Tests the tokenizer API"
  (fiveam:is (equal '(("some sample") ("text")) (mdtransform::t-paragraphs *input-sample*)))
  (fiveam:is (equal '(((5 11) (12 21) (22 28) (28 31) (32 38) (38 44))) (mdtransform::t-words '("some *text* **other** [test][0] ![img][link]")))))
