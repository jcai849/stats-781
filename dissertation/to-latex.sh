ls | awk 'BEGIN {start="\\begin{figure}\n\\centering\n\\includegraphics{";
middle="}\n\\caption{XXX\\label{fig:";
finish="}}\\end{figure}"}
{print start$1middle$1finish"\n"}'
