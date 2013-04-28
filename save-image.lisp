#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(ql:quickload "mdtransform")

(sb-ext:save-lisp-and-die #P"dist/mdtransform"
                          :toplevel 'mdtransform:main
                          :executable t
                          :purify t)
