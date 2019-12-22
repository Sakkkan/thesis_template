TEX := uplatex
DVIPDFMX := dvipdfmx
BIB := pbibtex

MAIN := main
PRE := preamble
TEXS := $(wildcard *.tex)

STYS := $(wildcard *.sty)
FIGS := $(wildcard fig/*)

PDFS := $(wildcard fig/*pdf)
PNGS := $(wildcard fig/*png)

FIGS := $(filter-out fig/*~, $(FIGS))

BBL  := $(MAIN).bbl

.PHONY: all clean

all: $(MAIN).pdf

%.aux: %.tex
	$(TEX) $(MAIN)

$(BBL): $(MAIN).aux thesis.bib jecon.bst
	$(BIB) $(MAIN)

$(MAIN).dvi: $(TEXS) $(STYS) $(FIGS) $(BBL)
	$(TEX)	$(MAIN)

	if egrep 'No file $(MAIN).toc.' $(MAIN).log;\
	then\
		$(TEX)	$(MAIN);\
	fi

	if egrep 'LaTeX Warning: There were undefined references.' $(MAIN).log;\
	then\
		$(TEX) $(MAIN);\
	fi

	if egrep 'There were undefined citations.' $(MAIN).log;\
	then\
		$(TEX) $(MAIN);\
	fi

$(MAIN).pdf: $(MAIN).dvi
	$(DVIPDFMX) $^

clean:
	rm -f *.pdf *.dvi *.aux *.log *.lot *.lof *.out *.toc tex/*.aux *~ src/*~ tex/*~ *.bbl *.blg
