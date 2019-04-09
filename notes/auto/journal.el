(TeX-add-style-hook
 "journal"
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
    "sec:orgb48adf5"
    "sec:orga3c451c"
    "sec:orgfe7562a"
    "sec:org28a2ffa"
    "sec:org39a3be4"
    "sec:org7961e81"
    "sec:orgc024ee3"
    "sec:org11df7d1"
    "sec:org7b193fc"
    "sec:org0874674"
    "sec:org88e1533"
    "sec:org503efeb"
    "sec:orgd9057cd"
    "sec:org1272b59"
    "sec:org6d9eb1e"
    "sec:orgc2b638a"
    "sec:org2e1c9ea"
    "sec:orgd8f78a2"
    "sec:org430bccb"
    "sec:orged92e7b"))
 :latex)

