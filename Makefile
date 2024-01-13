objfiles := gwen.pdf
srcfiles := gwentext.txt gwenpic.jpg gwen.tex

all: $(objfiles)

.PHONY: all

gwen.pdf: $(srcfiles)
	@echo building pdfs...
	@pdflatex gwen.tex

clean:
	rm gwen.aux gwen.log gwen.pdf