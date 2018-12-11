TEX = nfv-iot-diogo2018-v0
OUTPUT = nfv-iot-diogo2018-v0
LATEX           = latex
PDFLATEX	= pdflatex
DVIPS           = dvips
DVIPDF		= dvipdfm
BIBTEX		= bibtex
MAKEINDEX	= makeindex
PDFVIEWER	= evince
ZIP		= zip
OUTPUTDIR	= output

ALL             = $(TEX).ps $(TEX).pdf


all: pdflatex

pngfig: pdflatex1 bib pdflatex2 finalize

epsfig: dvi1 bib dvi2 pdf finalize

pdflatex: pdf1 bib pdf2 finalize

finalize: movePDF clean zip #view

pdf1:
#	bash imgs/converte.sh 
	$(PDFLATEX) $(TEX)
	$(PDFLATEX) $(TEX)

pdf2: 
	$(PDFLATEX) $(TEX)
	$(PDFLATEX) $(TEX)

dvi1:
	bash imgs/converte.sh 
	$(LATEX) $(TEX)
	$(LATEX) $(TEX)

dvi2: 
	$(LATEX) $(TEX)
	$(LATEX) $(TEX)

bib:
	$(BIBTEX) $(TEX)

index:
	$(MAKEINDEX) -s coppe.ist -o $(TEX).lab $(TEX).abx

pdf:
	$(DVIPDF) -c -r 300 -p a4 $(TEX)

pdflatex1:
	$(PDFLATEX) $(TEX)
	$(PDFLATEX) $(TEX)

pdflatex2:
	$(PDFLATEX) $(TEX)
	$(PDFLATEX) $(TEX)

movePDF: verifyOutputFolder
	mv $(TEX).pdf $(OUTPUTDIR)/$(OUTPUT).pdf

verifyOutputFolder:
	mkdir -p $(OUTPUTDIR)

ps: 
	$(DVIPS) -t a4 $(TEX).dvi -o $(TEX).ps

clean:
	rm -rf *.bbl *.aux *.dvi *.toc *.lof *.lol *log *.lot *.blg *.snm *.out *.nav *.abx *.syx *.vrb *.lab *.ilg *~
	
view: verifyOutputFolder
	$(PDFVIEWER) $(OUTPUTDIR)/$(OUTPUT).pdf &
	
zip: verifyOutputFolder
	$(ZIP) $(OUTPUTDIR)/$(OUTPUT).zip *.tex *.bib
