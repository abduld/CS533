

FIGURES=
TARGET=paper
INKSCAPE=inkscape

all : $(TARGET).pdf

$(TARGET).pdf :
	pdflatex $(TARGET).tex
	bibtex $(TARGET)
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex

figures/%.eps : figures/%.svg
	$(INKSCAPE) --export-eps=$@ --export-area-page $<

figures/%.eps : figures/%.gp figures/%.dat
	cd figures && gnuplot $(notdir $<)

clean:
	rm -fr *.pdf *bbl *dvi *.log

