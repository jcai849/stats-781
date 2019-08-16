(TeX-add-style-hook
 "jason-cairns-dissertation"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "11pt" "a4paper" "oneside")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "UKenglish") ("datetime2" "en-GB" "showdow") ("biblatex" "sorting=none" "hyperref=true" "backend=biber" "style=numeric" "backref=true")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "report"
    "rep11"
    "mathtools"
    "amsfonts"
    "minted"
    "booktabs"
    "babel"
    "datetime2"
    "csquotes"
    "hyperref"
    "imakeidx"
    "biblatex"
    "todonotes"
    "pdfpages"
    "graphicx"
    "framed"
    "dsfont"
    "caption"
    "parskip")
   (LaTeX-add-labels
    "cha:acknowledgements"
    "cha:introduction"
    "cha:text-analyt-backgr"
    "cha:program-structure"
    "sec:program-architecture-1"
    "sec:import"
    "sec:insight"
    "sec:visualisation"
    "sec:user-interface"
    "cha:appendix")
   (LaTeX-add-bibliographies
    "references"))
 :latex)

