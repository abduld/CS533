document:
	cat proposal.markdown > report.markdown
	pandoc -o report.tex report.markdown
	pdflatex document
	pdflatex document
	pdflatex document
clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol *.out
cleaner: clean
	rm -f *.pdf
