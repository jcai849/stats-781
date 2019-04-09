(TeX-add-style-hook
 "journal"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "latin1") ("fontenc" "T1") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
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
    "sec:org6f229bb"
    "sec:org195fba5"
    "sec:org4476a5d"
    "sec:org09aad24"
    "sec:orgd9675e5"
    "sec:org8444a95"
    "sec:orgf916aac"
    "sec:org4c32989"
    "sec:org7d0c701"
    "sec:org9c502de"
    "sec:org0a78bd3"
    "sec:org4b7876d"
    "sec:org55af2a7"
    "sec:org24a30ef"
    "sec:org986fc5c"
    "sec:org5521762"
    "sec:orgfd5b6b1"
    "sec:orgf9ac5fd"
    "sec:org01a57cc"))
 :latex)

