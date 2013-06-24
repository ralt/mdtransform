(in-package #:mdtransform-tests)

(fiveam:test image-test
  "Tests the image lexer"
  (input "![0]")
  (fiveam:is (equal 'mdtransform::image (type-of (car mdtransform::*tokens*)))))

(fiveam:test link-test
  "Tests the link lexer"
  (input "[0]")
  (fiveam:is (equal 'mdtransform::link (type-of (car mdtransform::*tokens*)))))
