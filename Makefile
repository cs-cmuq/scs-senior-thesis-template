DOCNAME = main
OUTDIR = .tmp

.PHONY: all clean

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).tex
	mkdir -p $(OUTDIR)

	# 1. First pdflatex run (generates .aux)
	pdflatex -output-directory=$(OUTDIR) $(DOCNAME).tex

	# 2. Run BibTeX
	# 'cd' into .tmp to satisfy write permissions.
	# 'BIBINPUTS=..:' tells bibtex to look in the parent folder for your .bib file.
	cd $(OUTDIR) && BIBINPUTS=..: bibtex $(DOCNAME)

	# 3. Two more pdflatex runs to resolve all references and page numbers
	pdflatex -output-directory=$(OUTDIR) $(DOCNAME).tex
	pdflatex -output-directory=$(OUTDIR) $(DOCNAME).tex

	# 4. Move the final PDF back to the root directory
	mv $(OUTDIR)/$(DOCNAME).pdf .

clean:
	rm -rf $(OUTDIR) $(DOCNAME).pdf
