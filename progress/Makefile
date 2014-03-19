document:
	pandoc -S --biblio document.bib --csl ieee.csl progress.markdown -f markdown+pipe_tables+table_captions -o report.tex
	pdflatex document
	pdflatex document
	pdflatex document
clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol *.out
cleaner: clean
	rm -f *.pdf
