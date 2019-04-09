(TeX-add-style-hook
 "meeting_notes"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref")
   (LaTeX-add-labels
    "sec:orgde47e23"
    "sec:org7bba46c"
    "sec:org2c30583"
    "sec:org969fe61"
    "sec:org8edee7b"
    "sec:org61a6b2d"
    "sec:org28cf0d8"
    "sec:org5b8770c"
    "sec:org0f841a7"
    "sec:orgf4f23dd"
    "sec:org45d09cf"
    "sec:org40e4774"
    "sec:orgda6998a"
    "sec:org3f8b161"
    "sec:org132af34"
    "sec:orgd1ccbad"
    "sec:orge83fc28"
    "sec:org06b65a9"
    "sec:org5add0f3"
    "sec:orgae31cc8"))
 :latex)

